<?php

/**
 * stay alive phillip, stay alive!
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
class phillipPing {

    /**
     * @return sfEventDispatcher
     */
    protected function getDispatcher() {
        return phillip::getInstance()->getDispatcher();
    }

    /**
     * Send command to irc server
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
     * Connect to dispatcher and listen for events
     */
    public function __construct() {
        $this->getDispatcher()->connect('server.command.PING', array($this, 'pong'));
    }

    /**
     * Fires when PING command is received
     *
     * @param sfEvent $event
     */
    public function pong(sfEvent $event)
    {
        $p = $event->getParameters();
        $this->sendCommand(sprintf('PONG :%s',$p['trailing']));
    }

}