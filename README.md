# Project 1: Optimal Component Selection Using Genetic Algorithm

## Disclaimer

This project was created as part of a course requirement for the **University of Glasgow - UESTC Joint School**. The following requirements is from the school. This code was written by myself, with references to resources available on [MATLAB Central](https://uk.mathworks.com/matlabcentral/fileexchange/35810-optimal-component-selection-using-the-mixed-integer-genetic-algorithm).

### Usage Notice
This code is intended for personal and educational use only and should not be distributed or used for commercial purposes.

This project focuses on using a genetic algorithm to optimize the component values (such as resistors and thermistors) for a thermistor circuit. Given that these components are only available in standard sizes, the design variables are integers. The objective is to minimize the difference between the desired response curve and the generated curve from a candidate design. This project explores the design, implementation, and optimization of a genetic algorithm to achieve this goal.

## Problem Description

The objective is to select optimal component values for a thermistor circuit to approximate a desired response curve. A genetic algorithm is used to perform the optimization, with integer-based decision variables representing component values. The primary goals include:
- Minimizing the deviation between the desired and generated response curves.
- Exploring various genetic algorithm parameter settings to improve optimization quality and convergence speed.

More details about the problem and example code can be found on [MATLAB Central](https://uk.mathworks.com/matlabcentral/fileexchange/35810-optimal-component-selection-using-the-mixed-integer-genetic-algorithm).

## Tasks

### 1. Problem Formulation

- **Objective Function and Constraints**: Define the objective function and any constraints based on the provided files.
- **Decision Variables**: Identify decision variables and their search ranges.

### 2. Implement the Genetic Algorithm

- Develop a custom genetic algorithm without using MATLAB's built-in GA functions.
- Perform 10 optimization runs and collect the best, worst, and average optimal objective function values, as well as their standard deviations.
- Display a convergence curve showing the average best objective function values over generations for 10 runs.

### 3. Fine-Tune Genetic Algorithm Parameters

Experiment with various genetic algorithm settings and operators to improve both optimization quality and convergence speed. Document the tuning process, results, and provide an analysis of the performance improvements.

## Results and Marking Criteria

### Marking Scheme

| Category              | Criteria                                                                                               | Score        |
|-----------------------|-------------------------------------------------------------------------------------------------------|--------------|
| **Program Correctness** | The program’s ability to run and its accuracy in achieving the global optimum within a specified range. | 0-50 points |
| **Report**              | - Problem formulation: accuracy of objective function and constraints, decision variables, and ranges.<br> - Results and Discussion: Evaluation of convergence trends, statistical data, and theoretical alignment of explanations. | 0-50 points |

### Expected Output

1. **Statistical Table**: Display best, worst, and average optimal values with their standard deviations over 10 runs.
2. **Convergence Plot**: A plot showing the convergence trend of the objective function values across generations.

## Requirements

- **Code**: Implement a genetic algorithm without using MATLAB’s built-in GA functions.
- **Data**: Perform optimization over 10 runs, adjusting GA parameters to optimize convergence and quality.

## Resources

- [MATLAB Genetic Algorithm Documentation](https://uk.mathworks.com/help/gads/ga.html)
- [Optimal Component Selection MATLAB File Exchange](https://uk.mathworks.com/matlabcentral/fileexchange/35810-optimal-component-selection-using-the-mixed-integer-genetic-algorithm)

## Submission Guidelines

- Submit a report in PDF format titled with `UoG_ID + UESTC_ID + Name`.
- Include the code as attachments for testing purposes.

## Fine-Tuning Suggestions

A minimum of 10 different GA settings should be tried. Ensure that explanations are in line with GA theory. Performance improvements are evaluated based on adherence to theory and the quality of the achieved optimizations.

---

**Author**: Mark Ren  
**Institution**: University of Glasgow