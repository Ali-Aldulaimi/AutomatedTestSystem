Automated Test System for AQ-G257 Protection Relays
Project Overview
This repository houses the Automated Test System designed for the thorough testing and evaluation of AQ-G257 protection relays manufactured by Arcteq Oy. The project was undertaken by Mohamed Mahmud Ali during his practical training period. It encompasses the development and implementation of a sophisticated testing framework using a Jenkins Pipeline to manage and automate tasks across various testing stages.


System Description
This automated test system is specifically tailored for AQ-G257 relays which play a crucial role in various electrical infrastructure components such as motors, generators, distribution lines, and substations. The system incorporates several high-level technological solutions and tools to facilitate and ensure accurate and efficient testing processes.

Components
Jenkins Pipeline: Orchestrates and automates the testing process, providing a structured sequence of actions which includes building, testing, and deploying stages.
Robot Framework: Utilized for writing high-level, keyword-driven test cases that are easy to create, read, and maintain.
Python Scripts: Enhance the testing logic and provide custom test functionalities, used extensively for scripting within the Robot Framework.
SikuliX: Integrates image recognition powered scripting to simulate user interaction with graphical user interfaces.
LabJack: Hardware interface used to simulate and control electronic signals for testing relay functionalities.
Relay Boards: Used alongside LabJack to extend the number of outputs and inputs available during testing.
Tools
Git: For version control, ensuring all changes are tracked, allowing for rollback and collaboration.
CAD Software: Employed for designing the schematics of the project's hardware setup.
Blender: Used for 3D modeling of test setups and rack designs to provide a visual representation of physical configurations.
Objectives
Automated Testing: Streamline the testing process to enhance the efficiency and reproducibility of tests.
Efficient Build Process: Ensure the reliability of builds through automation.
Deployment Preparation: Automate the configuration and packaging of software components for deployment.
Artifact Archiving: Systematically store all relevant test artifacts for future reference and analysis.
Detailed Reporting and Documentation: Generate comprehensive reports detailing the outcomes and insights from each test stage.
Installation and Usage
Instructions for setting up the test environment, running tests, and interpreting results are provided in specific documentation within the repository. These instructions cover the necessary software installations, hardware setup, and step-by-step guides for utilizing the test system effectively.

Contributing
Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request for review. For detailed guidelines, refer to the CONTRIBUTING.md file.
