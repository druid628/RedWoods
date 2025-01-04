<?php

/**
 * Description
 *
 * @package
 * @subpackage
 * @author     Joshua Estes <Joshua.Estes@iostudio.com>
 * @copyright  iostudio 2012
 * @version    0.1.0
 * @category
 * @license
 *
 */

require_once __DIR__ . '/../vendor/dependency-injection/lib/sfServiceContainerAutoloader.php';
sfServiceContainerAutoloader::register();

require_once __DIR__ . '/../vendor/event-dispatcher/lib/sfEventDispatcher.php';

require_once __DIR__ . '/../vendor/yaml/lib/sfYamlParser.php';
require_once __DIR__ . '/../vendor/yaml/lib/sfYamlDumper.php';