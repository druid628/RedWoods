<?php

/**
 * game module helper.
 *
 * @package    OddsThomas
 * @subpackage game
 * @author     druid628
 * @version    SVN: $Id: helper.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class gameGeneratorHelper extends BaseGameGeneratorHelper
{

  public function linkToBet($object, $params)
  {
	  #var_dump($this->getUrlForAction('edit'));
	  #die();

    $params['ui-icon'] = $this->getIcon('edit', $params);
    $content = '<li class="sf_admin_action_show">'. link_to1(UIHelper::addIcon($params) . __ ($params['label'], array(), 'sf_admin'), 'bet/new?game_id=' . $object->getGameId(), $params['params']).'</li>';

    return $content;
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), 'bet_edit', $object, $params['params']).'</li>';
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), url_for('bet/new?game_id='. $object->getGameId()), $object, $params['params']).'</li>';
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), $this->getUrlForAction('show'), $object, $params['params']).'</li>';
  }

  public function linkToOdds($object, $params)
  {
	  #var_dump($this->getUrlForAction('edit'));
	  #die();

    $params['ui-icon'] = $this->getIcon('show', $params);
    $content = '<li class="sf_admin_action_show">'. link_to1(UIHelper::addIcon($params) . __ ($params['label'], array(), 'sf_admin'), 'odds/new?game_id=' . $object->getGameId(), $params['params']).'</li>';

    return $content;
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), 'bet_edit', $object, $params['params']).'</li>';
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), url_for('bet/new?game_id='. $object->getGameId()), $object, $params['params']).'</li>';
    #return '<li class="sf_admin_action_show">'.link_to(UIHelper::addIcon($params) . __($params['label'], array(), 'sf_admin'), $this->getUrlForAction('show'), $object, $params['params']).'</li>';
  }
}
