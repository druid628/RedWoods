<?php

namespace Philip\Plugin;

use Philip\AbstractPlugin as BasePlugin;
use Philip\IRC\Response;

/**
 * Adds functionality to clean out the channel for a while.
 *
 * @author Micah Breedlove <druid628@gmail.com>
 */
class EarmuffsPlugin extends BasePlugin
{
    public function init()
    {
        $bot = $this->bot;
        $config = $bot->getConfig();
        $cold_users = array();

        if(isset($config['cold_users']))
        {
            $cold_users = array_merge($cold_users, $config['cold_users']);
        }

        // Allow the bot to join rooms
        $this->bot->onPrivateMessage("/^!earmuffs(.*)/", function($event) use ($config, $bot, $cold_users) {
            $matches = $event->getMatches();
            $user = $event->getRequest()->getSendingUser();
            $kickBanUsers = explode(' ', $matches[0]);

            if ($bot->isAdmin($user)) {
                if(empty($kickBanUsers)){
                    foreach($kickBanUsers as $kbuser){
                        // kick $kbuser
                        // ban  $kbuser
                        // msg  $kbuser - "Please put your earmuffs on."
                    }
                } else { 
                    foreach($cold_users as $kbuser){
                        // kick $kbuser
                        // ban  $kbuser
                        // msg  $kbuser - "Please put your earmuffs on."
                    }

                }
                //$event->addResponse(Response::join(implode(',', $rooms)));
            } else {
                $event->addResponse(Response::msg($user, "You're not the boss of me."));
            }
        });
    }
}
