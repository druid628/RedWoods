<?php

/*
 * This file is part of the Whitecap utility.
 *
 * (c) Micah Breedlove <druid628@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

use Silex\Application;
use Silex\Provider\TwigServiceProvider;
use Silex\Provider\UrlGeneratorServiceProvider;
use Sismo\Sismo;
use Sismo\Project;
use Sismo\Storage\Storage;
use Sismo\Builder;
use Symfony\Component\Process\Process;
use Symfony\Component\HttpFoundation\Response;

$app = new Application();

