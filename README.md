# Demographic Pyramid of Chile (2000–2050)

This repository contains R code to build a **population pyramid** using Chilean demographic data provided by the [Instituto Nacional de Estadísticas (INE)](https://www.ine.gob.cl/estadisticas/sociales/demografia-y-vitales/proyecciones-de-poblacion).  
The graph highlights the structure of the Chilean population by age and sex, with a special focus on the youth segment (15–29 years old), comparing its evolution across three key years: **2000, 2025, and 2050**.

---

## 📊 About the Data
The dataset comes from INE’s official projections:  
**“Estimaciones y proyecciones de población 1992–2050 (base 2017)”**.  
It includes yearly estimates of population by **age**, **sex**, and **total population**.

In this project, the dataset is filtered and transformed to:
- Clean variable names and values.
- Convert age and year into numeric formats.
- Differentiate males and females.
- Calculate the **proportion of young people (15–29 years)** within the total population.

---

## 🧑‍💻 The R Script
The script included in this repository (`pyramid_chile.R`) performs the following steps:
1. **Load and clean the data**: removes totals, handles missing values, and converts text into numeric variables.
2. **Reshape the dataset**: makes it tidy and ready for visualization using `reshape2`.
3. **Calculate youth share**: computes the percentage of the population between 15–29 years old by sex and year.
4. **Create the pyramid plot** with `ggplot2`:
   - Bars represent male (left) and female (right) population counts.
   - Shaded area marks the 15–29 age range.
   - Labels indicate the percentage that youth represents in each year.
   - Three population pyramids are displayed side by side (2000, 2025, 2050).

---

## 📈 Example Output
Running the script will produce a figure similar to this:

> **Title**: *Pirámide Poblacional de Chile (2000–2050)*  
> **Subtitle**:  
> In 2000, young people (15–29) represented **24.8%** of the population.  
> In 2025, they are projected to represent **19.9%**.  
> By 2050, the proportion is expected to fall to **15.9%**.

The resulting plot visually illustrates the demographic transition of Chile, emphasizing the reduction in the share of youth over time.

---

## ▶️ How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/chile-demographic-pyramid.git
