# A/B Testing — Hypothesis Testing in Python (Task 11)

## 📌 Project Overview
This project performs an A/B test to evaluate whether a Test version of a marketing strategy leads to a statistically significant change in business revenue compared to a Control version.

The analysis focuses on revenue impact using hypothesis testing and business-driven decision-making.

---

## 🛠 Tools & Technologies
- Python (Jupyter Notebook)
- pandas, numpy
- scipy (Welch’s T-Test)
- matplotlib

---

## 📊 Dataset
The dataset represents a marketing funnel with the following metrics:
- Impression — Number of users who viewed the ad
- Click — Number of users who clicked
- Purchase — Number of purchases
- Earning — Revenue generated

A Control and Test group was created to simulate a real-world A/B testing environment.

---

## 🔬 Methodology
1. Assigned observations to Control and Test groups
2. Defined hypotheses and significance level (α = 0.05)
3. Calculated mean revenue for each group
4. Performed Welch’s T-Test to compare group performance
5. Computed a 95% confidence interval for revenue difference
6. Visualized revenue distributions using boxplots
7. Made a data-driven business recommendation

---

## 📈 Key Results
- No statistically significant difference in revenue between Control and Test groups
- P-value > 0.05
- Confidence interval includes zero, indicating uncertainty in business impact

---

## 💼 Business Recommendation
The Test version does not show a meaningful revenue improvement over the Control version. It is recommended to refine the experiment or test alternative strategies before full rollout.

---

## 👤 Author
**Trisha**  
Aspiring Business & Data Analyst

