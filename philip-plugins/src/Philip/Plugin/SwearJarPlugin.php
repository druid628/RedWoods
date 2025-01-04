<?php

namespace Philip\Plugin;

use Philip\AbstractPlugin as BasePlugin;
use Philip\IRC\Response;

/**
 * Adds a "swear jar" to the Philip IRC bot.
 *
 * @author Bill Israel <bill.israel@gmail.com>
 */
class SwearJarPlugin extends BasePlugin
{
    /**
     * Listens to channel messages and lets everyone know who owes what to
     * the "swear jar".
     */
    public function init()
    {

        $swear_conf = array(
          "normal" => array(
              "cost" => 0.25,
          ),
          "demolition_man" => array(
              "cost" => 1,
          ),
        );

        $bot = $this->bot;
        $config = $bot->getConfig();
        $swear_mode = "normal";
        if(isset($config['swear_mode']) && $config['swear_mode'] == "demolition_man")
        {
            $swear_mode = "demolition_man";
        }
        $swears = array('fu+ck', 'sh+i+t', 'cu+nt', 'co+ck');
        $swear_jar = array();

        // Don't say bad words, kids.
        $re = '/' . implode('|', $swears) . '/i';
        $this->bot->onChannel($re, function($event) use (&$swear_jar, $swear_conf, $swear_mode) {
            
            $who = $event->getRequest()->getSendingUser();
            if (!isset($swear_jar[$who])) {
                $swear_jar[$who] = 0;
            }

            $price = ($swear_jar[$who] += $swear_conf[$swear_mode]['cost']);
            if( $swear_mode == "demolition_man" )
            {
                if($price == 1) {
                    $responseOutput = sprintf("%s, you are fined %d credit for a violation of the Verbal Morality Statute.",  $who, $price);
                } else {
                    $responseOutput = sprintf("%s, you have been fined %d credit for a violation of the Verbal Morality Statute.",  $who, $price);
                }
            } else {
                $responseOutput = sprintf("Mind your tongue $who! Now you owe \$%.2f to the swear jar.", $price);
            }

            $event->addResponse(
                Response::msg(
                    $event->getRequest()->getSource(),
                    $responseOutput
            ));
        });
    }
}

