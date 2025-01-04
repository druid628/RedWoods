<?php

/**
 * Game form.
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormTemplate.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class GameForm extends BaseGameForm
{
  public function configure()
  {
	  unset($this['created_at'], $this['updated_at']);

	  if(!$this->isNew())
	  {
		  $ws = $this->getWidgetSchema();
		  $ws['result'] = new sfWidgetFormChoice(array('label' => 'Result', 'choices' => array($this->getObject()->getTeam1() => $this->getObject()->getTeam1(), 'Draw' => 'Draw', $this->getObject()->getTeam2() => $this->getObject()->getTeam2())));
	  }

  }
}
