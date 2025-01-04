<?php
/**
 * The  yeah hush.
 *
 * @author Bill Israel <bill.israel@gmail.com>
 */
require __DIR__ . '/../../vendor/autoload.php';
require_once(__DIR__ . '/../config/philip-config.php');

use Philip\Philip;
use Philip\IRC\Response;
use Symfony\Component\Process\Process;

// Create the bot, passing in configuration options
$bot = new Philip($philipConfig);

// Load my plugins
$bot->loadPlugins(array(
    'Philip\\Plugin\\AdminPlugin',
    'druid628\\Whitecap\\philip\\SismoPlugin',
));

// Ready, set, go.
$bot->run();

