<?php

namespace DruiD628\Traits;

trait CLITrait
{

    /**
     *
     * tests to see if class is being executed from command line
     *
     * @return boolean
     */
    public function isCli()
    {
        return php_sapi_name() === "cli";
    }

    /**
     * Generates a humorous error message formed similar to the old
     * DOS style errors
     *
     * @param String $errorType - self explanitory e.g. Syntax
     * @param String $message - explination error
     * @param String $correction - what you should have put
     *
     * @return string
     */
    public function formatErrorDOS($errorType, $message, $correction)
    {
        $errorType = strtoupper($errorType);
        return <<<EOF
################
##
## $errorType ERROR: $message
##
################
\n\n\t\t$errorType: $correction \n\n
Bad command or file name.\nC:\>_\n
EOF;

    }
}