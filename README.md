
# 🌀 Development of Fault Type Classifier for Renewable-integrated Power Networks  

---

## 📖 Project Overview  

The rapid integration of **renewable energy sources (RES)** such as solar and wind is transforming modern power systems. These sources, connected via **power electronic converters**, change the nature of fault currents — making conventional fault classification techniques unreliable.  

This project develops an **adaptive fault type classification method** capable of operating accurately in **renewable-integrated grids**. Using **sequence current angle analysis**, the method identifies different fault types while remaining robust under converter-driven dynamics and varying fault resistances.  

---

## 🎯 Objectives  

1. **Develop a fault type classification technique** suitable for non-homogeneous systems, including converter-interfaced renewable power (CIRP) connections.  
2. **Design an adaptive classifier** that utilizes only local voltage and current measurements.  
3. **Validate the classifier** through simulation studies on standard test systems with renewable integration.  

---

## 🧠 Motivation  

Traditional fault classifiers assume synchronous generator behavior, relying on predictable sequence current/voltage angle relationships.  
However, renewable converters alter these dynamics due to:  
- Limited fault current contribution  
- Control-dependent responses  
- Non-uniform network impedance  

These issues lead to **misclassification of faults** and unreliable protection. The proposed method addresses this gap using a **sequence current angle-based approach** that adapts to renewable behavior.  

---

## ⚙️ Methodology  

The method computes the **phase angle difference (δ⁺ᴵ)** between the **positive-sequence fault current (Iₐ₁)** and **negative-sequence fault current (Iₐ₂)**:  

\[
\delta⁺ᴵ = \angle Iₐ₂ - \angle Iₐ₁
\]

Different fault types exhibit **distinct δ⁺ᴵ signatures**, which form the basis for classification.  
Implementation was carried out in **PSCAD (for system modeling)** and **MATLAB (for signal analysis and classification)**.

### 🧩 Steps
1. Model power systems (both conventional and renewable-integrated) in PSCAD.  
2. Generate fault current data for various fault types (AG, BCG, CA, etc.).  
3. Import fault data into MATLAB for computation of sequence components and δ⁺ᴵ.  
4. Determine fault type based on δ⁺ᴵ zone thresholds (e.g., AG ≈ 0°, BCG ≈ 180°, CA ≈ −60°).  

---

## 🧪 Simulation Setup  

- **Software:** PSCAD, MATLAB  
- **Systems Studied:**  
  - Conventional source-based network  
  - Renewable-integrated network (solar PV + wind farm)  
- **Fault Types:** AG,BG,CG,ABG,CAG,BCG,CA,AB,BC,ABC/ABCG


---



## 🔧 Hardware Implementation  

A **hardware prototype** was developed to validate the proposed technique using interfaced renewable sources.  
Measurement and control units were integrated with Arduino-based acquisition and MATLAB post-processing to verify simulation findings.



---

## 🧾 Summary  

This project successfully demonstrates that **sequence current angle-based classification** can accurately identify fault types in renewable-integrated power networks. The technique’s adaptability and simplicity make it promising for **real-time relay protection** in modern grids with increasing renewable penetration.
