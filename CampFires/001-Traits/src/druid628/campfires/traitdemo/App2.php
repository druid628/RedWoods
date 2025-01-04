<?PHP

namespace druid628\campfires\traitdemo;

use druid628\campfires\traitdemo\User;
use druid628\campfires\traitdemo\SecurityTrait;

class App2 extends User
{

    use SecurityTrait;

    /**
     * @overload
     * @return string
     */
    public function getToken()
    {
        $token = $this->encrypt($this->username, $this->generateSalt());

        return $token;
    }

}
