pragma solidity 0.6.2;

import '@openzeppelin/contracts/access/AccessControl.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20Capped.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol';

contract TaalswapToken is Context, AccessControl, ERC20Capped, ERC20Pausable {

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
//    address public distributionContractAddress;
    uint256 constant TOTAL_CAP = 100000000 * 1 ether;       // 100 Million

//    constructor(address _distributionContract)
    constructor()
        ERC20("TaalswapToken", "TAL")
        ERC20Capped(TOTAL_CAP)
        public {
            _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
            _setupRole(PAUSER_ROLE, _msgSender());

//            distributionContractAddress = _distributionContract;
//            _mint(distributionContractAddress, 1000000 * (10 ** uint256(decimals())));
            _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
        }

    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "TaalswapToken: must have pauser role to pause");
        _pause();
    }

    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "TaalswapToken: must have pauser role to unpause");
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20Capped, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "TaalswapToken: token transfer while paused");

        if (from == address(0)) { // When minting tokens
            require(totalSupply().add(amount) <= cap(), "TaalswapToken: cap exceeded");
        }
    }
}
