### Automated Test System for AQ-G25x Protection Relays
## Project Overview
This repository houses the Automated Test System designed for the thorough testing and evaluation of AQ-G25x protection relays manufactured by Arcteq Oy. The project was undertaken by Mohamed Mahmud Ali during his practical training period. It encompasses the development and implementation of a sophisticated testing framework using a Jenkins Pipeline to manage and automate tasks across various testing stages.


## System Description
This automated test system is specifically tailored for AQ-G25x relays which play a crucial role in various electrical infrastructure components such as motors, generators, distribution lines, and substations. The system incorporates several high-level technological solutions and tools to facilitate and ensure accurate and efficient testing processes.

## Components
- Jenkins Pipeline: Orchestrates and automates the testing process, providing a structured sequence of actions which includes building, testing, and deploying stages.
- Robot Framework: Utilized for writing high-level, keyword-driven test cases that are easy to create, read, and maintain.
- Python Scripts: Enhance the testing logic and provide custom test functionalities, used extensively for scripting within the Robot Framework.
- SikuliX: Integrates image recognition powered scripting to simulate user interaction with graphical user interfaces.
- LabJack: Hardware interface used to simulate and control electronic signals for testing relay functionalities.
- Relay Boards: Used alongside LabJack to extend the number of outputs and inputs available during testing.
## Tools
- Git: For version control, ensuring all changes are tracked, allowing for rollback and collaboration.
- CAD Software: Employed for designing the schematics of the project's hardware setup.
- Blender: Used for 3D modeling of test setups and rack designs to provide a visual representation of physical configurations.
## Objectives
- Create a network using HP-aruba to communciate with front and back panels of the DUT.
- Create test cases for different modules of the DUTs.
- Automated Testing: Streamline the testing process to enhance the efficiency and reproducibility of tests.
- Efficient Build Process: Ensure the reliability of builds through automation.
- Deployment Preparation: Automate the configuration and packaging of software components for deployment.
- Artifact Archiving: Systematically store all relevant test artifacts for future reference and analysis.
- Detailed Reporting and Documentation: Generate comprehensive reports detailing the outcomes and insights from each test stage.
- Create a I/O schematics of the project.
## SYSTEM WORK FLOW 

<div>
   <p>
    At the core of the system is the Jenkins Pipeline, which automates sequential and parallel tasks, ensuring that every aspect of the software and hardware interaction is consistent and repeatable. The pipeline is configured to trigger automatically under specific conditions—such as new code commits or scheduled intervals—thereby supporting continuous integration and testing practices. Once triggered, the pipeline orchestrates a series of actions: it sets up the testing environment, deploys the necessary testing scripts, executes these scripts, and then collates and presents the results.

The testing scripts themselves are primarily written using the Robot Framework, a powerful tool for automation that allows for writing clear, concise, and understandable test cases. This framework is particularly suited for acceptance testing and acceptance test-driven development (ATDD). It utilizes a keyword-driven approach to describe test scenarios, which can be easily understood even by those not deeply familiar with programming. The keywords abstract complex code into user-friendly terms, making the scripts maintainable and scalable.

In conjunction with the Robot Framework, Python scripts are employed to handle more complex logic and interactions. These scripts perform tasks such as data manipulation, setup configurations, and direct hardware interfacing with the protection relays. For interface simulation and control, tools like SikuliX are used. SikuliX integrates screen-based visual recognition with automated GUI operations, enabling the system to interact with the graphical user interfaces of the tools and devices involved in the testing setup.

Hardware interfacing is another critical component of the automated system. Devices like LabJack and relay boards are used to simulate and control electrical signals and power flows, mimicking real-world electrical disturbances and conditions. This setup ensures that the AQ-G257 relays are tested under conditions that closely resemble their operational environments.

The culmination of this orchestrated effort is a robust, reliable, and highly efficient testing system that not only reduces the time required for testing but also significantly enhances the accuracy and reliability of the tests. By integrating hardware and software testing within a unified framework, the project delivers a comprehensive assessment of the protection relays’ performance, ensuring they meet all specified requirements and behave as expected in the field.

This automated test system not only represents a technical advancement in the field of electrical engineering but also serves as a model for future automation projects aiming to enhance reliability and efficiency through innovative technology integration. effectively.
  </p>
  <p style="float:right; margin: 10px;">
    <img src="3D%20design/rack_design.png" alt="Front View of 3D Design" title="Front View" width="300"/>
  </p>
</diV>



