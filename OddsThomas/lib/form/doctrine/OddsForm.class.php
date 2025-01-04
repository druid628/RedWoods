<?php

/**
 * Odds form.
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormTemplate.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class OddsForm extends BaseOddsForm
{
  public function configure()
  {
	  unset($this['created_at'], $this['updated_at']);
  }

  public function setGame($game_id)
  {
	  $q = Doctrine::getTable('Game')->find($game_id);
	  $ws = $this->getWidgetSchema();
	  $ws['team1']->setLabel($q->getTeam1());
	  $ws['team2']->setLabel($q->getTeam2());
	  $ws['game_id'] = new sfWidgetFormInputHidden(array(), array('value' => $game_id));
  }
}
