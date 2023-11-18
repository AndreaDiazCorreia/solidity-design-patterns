// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract EmergencyStop {

    bool isStopped = false;

    
    modifier stoppedInEmergency {
        require(!isStopped);
        _;
    }

   
    modifier onlyWhenStopped {
        require(isStopped);
        _;
    }

    
    modifier onlyAuthorized {
        // Agregar verificación de autorización del msg.sender aquí
        _;
    }

   
    function stopContract() public onlyAuthorized {
        isStopped = true;
    }

   
    function resumeContract() public onlyAuthorized {
        isStopped = false;
    }

    
    function deposit() public payable stoppedInEmergency {
        // Lógica de depósito aquí
    }

    
    function emergencyWithdraw() public onlyWhenStopped {
        // Lógica de retiro de emergencia aquí
    }
}
