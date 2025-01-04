<?php

namespace druid628\Whitecap;

use Sismo\Sismo;
use Sismo\Project;
use Sismo\Storage\Storage;
use Sismo\Builder;
use Symfony\Component\Process\Process;
use Pimple;

/*
 * This file is part of the Whitecap utility.
 *
 * (c) Micah Breedlove <druid628@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

class VolcanoDI extends Pimple // also known as Joe
{

    /**
     * 
     * @return Sismo
     */
    public function getSismo() 
    {
        $this->prepareSismo();
        return $this['sismo'];
    }

    /**
     * Used to build instances of Sismo 
     * Code taken from Sismo/src/app.php written by Fabpot
     * Modified by druid628
     */
    private function prepareSismo() 
    {
        $this['data.path']   = getenv('SISMO_DATA_PATH') ?: getenv('HOME').'/.sismo/data';
        $this['config.file'] = getenv('SISMO_CONFIG_PATH') ?: getenv('HOME').'/.sismo/config.php';
        $this['config.storage.file'] = getenv('SISMO_STORAGE_PATH') ?: getenv('HOME').'/.sismo/storage.php';
        $this['build.path']  = $this->share(function ($this) { return $this['data.path'].'/build'; });
        $this['db.path']     = $this->share(function ($this) {
            if (!is_dir($this['data.path'])) {
                mkdir($this['data.path'], 0777, true);
            }
        
            return $this['data.path'].'/sismo.db';
        });
        $this['twig.cache.path'] = $this->share(function ($this) { return $this['data.path'].'/cache'; });
        $this['git.path']        = getenv('SISMO_GIT_PATH') ?: 'git';
        $this['git.cmds']        = array();
        $this['db.schema']       = <<<EOF
CREATE TABLE IF NOT EXISTS project (
    slug        TEXT,
    name        TEXT,
    repository  TEXT,
    branch      TEXT,
    command     BLOB,
    url_pattern TEXT,
    PRIMARY KEY (slug)
);

CREATE TABLE IF NOT EXISTS `commit` (
    slug          TEXT,
    sha           TEXT,
    date          TEXT,
    message       BLOB,
    author        TEXT,
    status        TEXT,
    output        BLOB,
    build_date    TEXT DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (slug, sha),
    CONSTRAINT slug FOREIGN KEY (slug) REFERENCES project(slug) ON DELETE CASCADE
);
EOF;
    
        $that = $this; // when converting to php 5.4 undo this

        $this['db'] = $this->share(function () use (&$that) {
            $db = new \SQLite3($that['db.path']);
            $db->busyTimeout(1000);
            $db->exec($that['db.schema']);
        
            return $db;
        });

        $this['storage'] = $this->share(function () use (&$that) {
            if (is_file($that['config.storage.file'])) {
                $storage = require $that['config.storage.file'];
            } else {
                $storage = new Storage($that['db']);
            }
        
            return $storage;
        });
        
        $this['builder'] = $this->share(function () use (&$that) {
            $process = new Process(sprintf('%s --version', $that['git.path']));
            if ($process->run() > 0) {
                throw new \RuntimeException(sprintf('The git binary cannot be found (%s).', $that['git.path']));
            }
        
            return new Builder($that['build.path'], $that['git.path'], $that['git.cmds']);
        });
        
        $this['sismo'] = $this->share(function () use (&$that) {
            $sismo = new Sismo($that['storage'], $that['builder']);
            if (!is_file($that['config.file'])) {
                throw new \RuntimeException(sprintf("Looks like you forgot to define your projects.\nSismo looked into \"%s\".", $that['config.file']));
            }
            $projects = require $that['config.file'];
        
            if (null === $projects) {
                throw new \RuntimeException(sprintf('The "%s" configuration file must return an array of Projects (returns null).', $that['config.file']));
            }
        
            if (!is_array($projects)) {
                throw new \RuntimeException(sprintf('The "%s" configuration file must return an array of Projects (returns a non-array).', $that['config.file']));
            }
        
            foreach ($projects as $project) {
                if (!$project instanceof Project) {
                    throw new \RuntimeException(sprintf('The "%s" configuration file must return an array of Project instances.', $that['config.file']));
                }
        
                $sismo->addProject($project);
            }
        
            return $sismo;
        });
    }

}
