<?php

/**
 * Sends the irc server your user information
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
class phillipConnect {

    /**
     * @return sfEventDispatcher
     */
    protected function getDispatcher() {
        return phillip::getInstance()->getDispatcher();
    }

    /**
     * send command to irc server
     *
     * @param string $cmd
     */
    protected function sendCommand($cmd) {
        phillip::getInstance()->sendCommand($cmd);
    }

    /**
     * @return sfServiceContainerBuilder
     */
    protected function getContainer()
    {
        return phillip::getInstance()->getContainer();
    }

    /**
     * Listen for all the events
     */
    public function __construct() {
        $this->getDispatcher()->connect('irc.connect', array($this, 'connect'));
    }


    /**
     * Gets triggered on irc.connect event
     *
     * @param sfEvent $event 
     */
    public function connect(sfEvent $event) {
        $p = $this->getContainer()->getParameters();
        phillip::getInstance()->log('Connected');
        phillip::getInstance()->sendCommand(sprintf('USER %s %s %s :%s', $p['irc.username'], $p['irc.hostname'], $p['irc.hostname'], $p['irc.realname']));
        phillip::getInstance()->sendCommand(sprintf('NICK %s', $p['irc.username']));
    }

}