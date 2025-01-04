<?php

/**
 * Bet form base class.
 *
 * @method Bet getObject() Returns the current form's model object
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseBetForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'bet_id'     => new sfWidgetFormInputHidden(),
      'user_id'    => new sfWidgetFormInputText(),
      'game_id'    => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('Game'), 'add_empty' => false)),
      'pick'       => new sfWidgetFormInputText(),
      'odds'       => new sfWidgetFormInputText(),
      'amount'     => new sfWidgetFormInputText(),
      'created_at' => new sfWidgetFormDateTime(),
      'updated_at' => new sfWidgetFormDateTime(),
    ));

    $this->setValidators(array(
      'bet_id'     => new sfValidatorChoice(array('choices' => array($this->getObject()->get('bet_id')), 'empty_value' => $this->getObject()->get('bet_id'), 'required' => false)),
      'user_id'    => new sfValidatorInteger(array('required' => false)),
      'game_id'    => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('Game'))),
      'pick'       => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'odds'       => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'amount'     => new sfValidatorString(array('max_length' => 10, 'required' => false)),
      'created_at' => new sfValidatorDateTime(),
      'updated_at' => new sfValidatorDateTime(),
    ));

    $this->widgetSchema->setNameFormat('bet[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'Bet';
  }

}
