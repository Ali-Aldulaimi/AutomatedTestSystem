This repository contains several critical files that are instrumental in the automated testing of AQ-G25x protection relays using a Jenkins Pipeline and Robot Framework. Below are detailed descriptions of three key files: FuncsList.robot, Keywords.robot, and LabjackLib.py.

### 1. FuncsList.robot

FuncsList.robot is a Robot Framework resource file that serves as a central repository of reusable keywords and variables. It is designed to enhance modularity and reusability across various test suites.


Resource Management: Centralizes common settings, libraries, and variables, making them accessible to multiple test scripts.
Library Inclusions: Integrates external Python libraries such as LabjackLibrary.py and u3.py, facilitating direct hardware interaction through defined keywords.
Variable Definitions: Stores commonly used variables and constants that can be employed across different test scenarios to maintain consistency and reduce duplication.
### 2. Keywords.robot

Keywords.robot contains a comprehensive set of custom Robot Framework keywords that abstract complex operations into user-friendly terms. These keywords are specifically tailored to manage the operations of LabJack devices used in the testing environment.


Device Control Keywords: Includes commands such as Power On/Off DUT and Check Other DUTs Are Off, which control the power states of devices under test through the LabJack interface.
Input and Output Management: Facilitates checking and setting the digital I/O states, ensuring accurate setup and teardown actions for tests.
Parameterized Execution: Many keywords are designed to accept parameters, allowing for dynamic execution based on test requirements.
### 3. LabjackLib.py

LabjackLib.py is a custom Python library that provides an API for interacting with LabJack hardware. This library is crucial for executing low-level operations such as reading and writing to digital I/Os and managing device connectivity.


Hardware Interface Functions: Functions such as Open Labjack, Activate Relay, and DeActivate Relay directly interact with the LabJack hardware to control various electronic components.
Error Handling: Robust error management to handle and log connectivity issues or operational errors during hardware interaction.
Utility Functions: Includes helper functions to read input states and manage device states effectively, crucial for maintaining test integrity.
Usage
To utilize these files in your testing environment:

Integration: Ensure that all three files are included in the same working directory or properly referenced within your Robot Framework test suites.
Configuration: Modify the FuncsList.robot file to include any global variables or additional libraries as needed.
Execution: Reference Keywords.robot in your test cases to use the predefined keywords. Ensure LabjackLib.py is accessible to the Robot Framework environment for hardware interaction.
