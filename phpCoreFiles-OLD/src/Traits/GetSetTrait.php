<?php

namespace DruiD628\Traits;


trait GetSetTrait
{
    /**
     *
     * standard getter
     *
     * @param string $fieldName
     * @throws \Exception
     *
     * @return mixed
     */
    public function get($fieldName)
    {
        if (!property_exists($this, $fieldName)) {
            throw new \Exception("Variable ($fieldName) Not Found");
        }

        return $this->$fieldName;
    }

    /**
     * standard setter
     *
     * @param string $fieldName
     * @param mixed $value
     * @throws \Exception
     *
     * @return boolean
     */
    public function set($fieldName, $value)
    {
        if (!property_exists($this, $fieldName)) {
            throw new \Exception("Variable ($fieldName) Not Found");
        }

        $this->$fieldName = $value;
        return true;
    }

}