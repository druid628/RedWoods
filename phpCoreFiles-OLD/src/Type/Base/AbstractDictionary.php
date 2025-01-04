<?php

namespace DruiD628\Type\Base;

use DruiD628\Exceptions\InvalidKeyTypeException;
use DruiD628\Type\Base\Contracts\DictionaryInterface;

/**
 * Class AbstractDictionary
 * @package DruiD628\Type\Base
 */
class AbstractDictionary implements DictionaryInterface
{
    /** @var int $position position sentinel variable */
    protected $position;

    /** @var array $keys */
    protected $keys = [];

    /** @var array $values */
    protected $values = [];

    public function __construct($data = [])
    {
        $this->setData($data);
        $this->position = 0;
    }

    /**
     * @param $key
     * @param $value
     *
     * @return $this
     * @throws InvalidKeyTypeException
     */
    public function add($key, $value)
    {
        return $this->offsetSet($key, $value);
    }

    /**
     * @param $key
     * @param $value
     *
     * @return $this
     * @throws InvalidKeyTypeException
     */
    public function set($key, $value)
    {
        return $this->offsetSet($key, $value);
    }

    public function get($key)
    {
        return $this->offsetGet($key);
    }

    public function getKeys()
    {
        return $this->keys;
    }

    public function getValues()
    {
        return $this->values;
    }

    public function count(): int
    {
        return count($this->keys);
    }

    // Iterator
    public function rewind()
    {
        $this->position = 0;
    }

    public function valid()
    {
        return isset($this->keys[$this->position]);
    }

    public function key()
    {
        return array_keys($this->keys)[$this->position];
    }

    public function next()
    {
        ++$this->position;
    }

    // not part of Iterator
    public function prev()
    {
        --$this->position;
    }

    public function current()
    {
        return ($this->valid()) ? array_values($this->values)[$this->position] : false;
    }

    // ArrayAccess

    /**
     * @param mixed $offset
     * @return $this
     */
    public function offsetUnset($offset)
    {
        $offsetPosition = $this->getOffsetPosition($offset);

        unset($this->keys[$offsetPosition],
            $this->values[$offsetPosition]
        );

        return $this;
    }


    /**
     * Offset to set
     * @link https://php.net/manual/en/arrayaccess.offsetset.php
     * @param mixed $offset <p>
     * The offset to assign the value to.
     * </p>
     * @param mixed $value <p>
     * The value to set.
     * </p>
     * @return $this
     * @since 5.0.0
     * @throws InvalidKeyTypeException
     */
    public function offsetSet($offset, $value)
    {
        if (!$this->validateKey($offset)) {
            throw new InvalidKeyTypeException(sprintf("Invalid Key type (%s) for Dictionary", gettype($offset)));
        }

        if (!$this->offsetExists($offset)) {
            $this->keys[] = $offset;
        }

        $position                = $this->getOffsetPosition($offset);
        $this->values[$position] = $value;
        return $this;
    }

    /**
     * @return array
     */
    public function getData()
    {
        return array_combine($this->keys, $this->values);
    }

    /**
     * @param array $data
     *
     * @return $this
     * @throws InvalidKeyTypeException
     */
    public function setData($data = [])
    {
        $this->validateKeys($data);
        foreach ($data as $key => $value) {
            $this->add($key, $value);
        }

        return $this;
    }

    /**
     * @param mixed $offset
     * @return bool|mixed
     */
    public function offsetGet($offset)
    {
        if ($this->offsetExists($offset)) {
            $combined = $this->getData();

            return $combined[$offset];
        }

        return false;
    }

    /**
     * @param mixed $offset
     * @return bool
     */
    public function offsetExists($offset)
    {
        $flippedArray = array_flip($this->keys);

        return (isset($flippedArray[$offset]));
    }

    /**
     * @param $offset
     *
     * @return mixed
     */
    protected function getOffsetPosition($offset)
    {
        $reverseKeys = array_flip($this->keys);

        return ($this->offsetExists($offset)) ? $reverseKeys[$offset] : false;

    }

    /**
     * @param array $dataSet
     *
     * @return bool
     */
    protected function validateKeys(array $dataSet)
    {
        foreach (array_keys($dataSet) as $key) {
            if (!($this->validateKey($key))) {
                return false;
            }
        }

        return true;
    }

    /**
     * @param $key
     *
     * @return bool
     */
    protected function validateKey($key)
    {
        return is_string($key) || is_int($key);
    }

}