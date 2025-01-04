<?PHP

namespace druid628\campfires\traitdemo;

use druid628\campfires\traitdemo\User;
use druid628\campfires\traitdemo\SecurityTrait;

class App1 extends User
{
    use SecurityTrait;

    /**
     * @param string $token
     *
     * @return bool
     */
    public function isValid($token)
    {
        $username = $this->decrypt($token, $this->generateSalt());

        return ($username == $this->username);
    }


}


