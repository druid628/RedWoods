<?php

namespace DruiD628\Traits;

use \Exception;

trait MagicGetSetTrait
{
    use GetSetTrait;

    /**
     * Magic
     *
     * @param string $method
     * @param array  $arguments
     *
     * @return mixed
     * @throws \Exception
     */
    public function __call($method, $arguments)
    {
        $verb = substr($method, 0, 3);
        if (in_array($verb, array('set', 'get'))) {
            $name = lcfirst(substr($method, 3));
        }
        if (method_exists($this, $verb)) {
            if (property_exists($this, $name)) {
                return call_user_func_array(array($this, $verb), array_merge(array($name), $arguments));
            } else {
                throw new Exception("Variable ($name) Not Found");
            }
        }
        throw new Exception("No Method ($method) exists on ".get_class($this));
    }

}