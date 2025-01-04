<?php

/**
 * UserInfo form base class.
 *
 * @method UserInfo getObject() Returns the current form's model object
 *
 * @package    OddsThomas
 * @subpackage form
 * @author     druid628
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseUserInfoForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'user_id'     => new sfWidgetFormInputHidden(),
      'balance'     => new sfWidgetFormInputText(),
      'last_payday' => new sfWidgetFormInputText(),
    ));

    $this->setValidators(array(
      'user_id'     => new sfValidatorChoice(array('choices' => array($this->getObject()->get('user_id')), 'empty_value' => $this->getObject()->get('user_id'), 'required' => false)),
      'balance'     => new sfValidatorNumber(array('required' => false)),
      'last_payday' => new sfValidatorPass(array('required' => false)),
    ));

    $this->widgetSchema->setNameFormat('user_info[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'UserInfo';
  }

}
