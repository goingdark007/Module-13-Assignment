# 💚 BMI Calculator App (Flutter)

A beautifully designed **BMI (Body Mass Index) Calculator App** built using **Flutter**, offering multiple height/weight unit options, category detection, error handling, and a clean UI experience.

---

## ✨ Features

- 🔢 Supports **multiple height units**
  - `CM`, `Meter`, `Feet + Inch`
- ⚖️ Supports **multiple weight units**
  - `KG`, `LB`
- 📐 Accurate BMI calculation with categorized results:
  - Underweight 😵
  - Normal 😃
  - Overweight 😓
  - Obese 😣
- 🎨 Modern and clean UI with customized input fields
- 🧹 Clear button to reset all inputs
- ❌ Error handling using SnackBars
- 🌿 Green-themed interface
- 📱 Fully responsive layout with `SegmentedButton`

---

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point
├── pages/
│   └── calculator_page.dart     # BMI calculator screen + logic
└── utilities/
    └── app_input_field_widget.dart  # Custom styled text input widget
```

---

## 🖥️ UI Preview

| BMI Input Screen | Results Section |
|:----------------:|:----------------:|
| <img width="360" height="800" alt="Screenshot_20251115_134744" src="https://github.com/user-attachments/assets/0467be1a-d1ec-4f8c-ad68-8d446a795b68" /> | <img width="360" height="800" alt="Screenshot_20251115_134758" src="https://github.com/user-attachments/assets/13b82c39-6db4-45f6-9b5c-88b36651cff2" />


---

## 🛠️ How It Works

### ✔️ BMI Formula

```
BMI = weight(kg) / height(m)^2
```

### ✔️ Category Logic

| BMI Range | Category |
|----------|-----------|
| < 18.5 | Underweight 😵 |
| 18.5 – 24.9 | Normal 😃 |
| 25 – 29.9 | Overweight 😓 |
| ≥ 30 | Obese 😣 |

Colors automatically match the category:
- 🔵 Underweight  
- 🟢 Normal  
- 🟠 Overweight  
- 🔴 Obese  

---

## 🧩 Key Components

### 🔹 `AppInputField`
A reusable widget with:
- Custom styling  
- Border highlights  
- Number-only input  
- Auto-hide keyboard on outside tap  

### 🔹 `BMICalculator` Page
Handles:
- Input validation  
- Unit conversions:  
  - `CM → Meter`  
  - `Feet/Inch → Meter`  
  - `Pounds → KG`  
- BMI calculation  
- Category + color assignment  

---

## 🚀 Installation & Usage

1. Clone repo:
```bash
git clone https://github.com/yourusername/bmi_calculator.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

---

## 👨‍💻 Author

**Your Name**  
💼 GitHub: https://github.com/goingdark007  
📧 Email: nhasanr18@gmail.com  

---

## 📄 License

This project is licensed under the **MIT License**.

---

⭐ *If you like this project, please give it a star!*  
