<?php

/**
 * Bet form.
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormTemplate.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class BetForm extends BaseBetForm
{
  public function configure()
  {
	  unset($this['created_at'], $this['updated_at']);
	  $ws = $this->getWidgetSchema();
	  $vs = $this->getValidatorSchema();
	  $ws['odds'] = new sfWidgetFormInputHidden();
	  $vs['amount'] = new sfValidatorInteger(array('required' => 'true', 'min' => '500'), array('min' => 'Must bet minimum of 500'));
  }

  public function save($con = null)
  {
	  $dc = Doctrine_Query::create()
	  	->select('o.' . $this->values['pick'])
		->from('Odds o')
		->where('o.game_id = ' . $this->values['game_id'])
		->andWhere('o.active = 1')
		->fetchArray();
	  $this->values['odds'] = $dc[0][$this->values['pick']];
	  parent::save($con);
  }
}
