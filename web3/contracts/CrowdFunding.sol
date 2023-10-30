// SPDX-License-Identifier: UNLICENSED

// --------------------------------------------------------------
// @title: CrowdFunding Smart Contract
// @author: Pema Wangchuk
// @dev: This is a crowdfunding smart contract implemented in Solidity programming language.
// 
// Introduction:
// --------------------------------------------------------------
// Crowdfunding is a method of raising capital through collective efforts, made by friends,
// family, customers, and individual investors. This smart contract aims to automate
// this process on the Ethereum blockchain.
// 
// Main Features:
// --------------------------------------------------------------
// 1. Allows the creation of a new fundraising campaign.
// 2. Securely handles donations towards campaigns.
// 3. Keeps track of each donor and the donations made.
// 4. Allows the campaign owner to collect the donations.
//
// Workflow:
// --------------------------------------------------------------
// 1. A user can create a new campaign by providing details like title, description, target amount, and deadline.
// 2. People can donate Ether to these campaigns.
// 3. The smart contract automatically sends the donated amount to the campaign owner.
// 4. Anyone can fetch the list of all campaigns or details of a single campaign, including the list of donors.
//
// Limitations:
// --------------------------------------------------------------
// 1. The smart contract currently doesn't support refunds if a campaign does not meet its goal.
// 2. All campaigns are public and anyone can donate.
//
// Future Enhancements:
// --------------------------------------------------------------
// 1. Implement a refund mechanism for failed campaigns.
// 2. Introduce various types of campaigns, like private campaigns, milestone-based campaigns, etc.
// --------------------------------------------------------------

pragma solidity 0.8.20;


contract CrowdFunding {
    // @dev Struct to store the details of each campaign.
    struct Campaign {
        address owner;           // @dev The address of the campaign owner.
        string title;            // @dev The title of the campaign.
        string description;      // @dev The description of the campaign.
        uint256 target;          // @dev The fundraising target in wei.
        uint256 deadline;        // @dev The deadline timestamp.
        uint256 amountCollected; // @dev The total amount collected so far.
        string image;            // @dev An optional image URL for the campaign.
        address[] donators;      // @dev A list of addresses that have donated.
        uint256[] donations;     // @dev A list of amounts donated by each donor.
    }

    // @dev A mapping from campaign IDs to Campaign structs.
    mapping(uint256 => Campaign) public campaigns;

    // @dev The number of campaigns created so far.
    uint256 public numberOfCampaigns = 0;

    // @dev Function to create a new campaign.
    // @params _owner The address of the campaign owner.
    // @params _title The title of the campaign.
    // @params _description The description of the campaign.
    // @params _target The fundraising target in wei.
    // @params _deadline The deadline timestamp.
    // @params _image An optional image URL for the campaign.
    // @return The ID of the created campaign.
    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256) {
        // @dev Check if the deadline is in the future.
        require(_deadline > block.timestamp, "The deadline should be a date in the future.");

        Campaign storage campaign = campaigns[numberOfCampaigns];

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    // @dev Function to donate to a specific campaign.
    // @params _id The ID of the campaign to donate to.
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        require(sent, "Failed to send Ether");

        campaign.amountCollected += amount;
    }

    // @dev Function to get the list of donors for a campaign.
    // @params _id The ID of the campaign.
    // @return A list of donor addresses and amounts.
    function getDonators(uint256 _id) public view returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    // @dev Function to get all campaigns.
    // @return An array of all Campaign structs.
    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for(uint i = 0; i < numberOfCampaigns; i++) {
            allCampaigns[i] = campaigns[i];
        }

        return allCampaigns;
    }
}
