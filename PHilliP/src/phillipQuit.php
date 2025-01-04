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
class phillipQuit {

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
    protected function getContainer() {
        return phillip::getInstance()->getContainer();
    }

    /**
     * Listen for all the events
     */
    public function __construct() {
        $this->getDispatcher()->connect('server.command.PRIVMSG', array($this, 'privmsg'));
    }

    /**
     * Executed when a privmsg command comes in
     *
     * @param Event $event
     */
    public function privmsg(sfEvent $event) {
        $p = $this->getContainer()->getParameters();
        $request = $event->getParameters();
        if (preg_match('/^!quit\s/i', $request['trailing']) && in_array($request['nick'], $p['users.trusted']))
        {
            $c = preg_replace('/^(!quit\s)/i', '', $request['trailing']);
            $this->sendCommand(sprintf('QUIT :%s',$c));
            phillip::getInstance()->closeConnection();
        }
    }

}