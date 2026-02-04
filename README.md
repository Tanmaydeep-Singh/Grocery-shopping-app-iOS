# Grocery-shopping-app-iOS

## Resources

**Figma (UI Design)**
[https://www.figma.com/design/II22ejWe7w3oo9XPrpEEoh/Online-Groceries-App-UI--Community-?node-id=1-2&p=f](https://www.figma.com/design/II22ejWe7w3oo9XPrpEEoh/Online-Groceries-App-UI--Community-?node-id=1-2&p=f)

**Postman (API Testing)**
[https://www.postman.com/grey-star-714241/api-testing/request/gv4754p/get-all-products](https://www.postman.com/grey-star-714241/api-testing/request/gv4754p/get-all-products)

**Swift UI Guidelines**
[https://google.github.io/swift/](https://google.github.io/swift/)

---

## Git Workflow Rules (Mandatory)

We follow a **simple Git Flow** to keep the codebase clean and stable.

---

### 1️⃣ Clone the Repository

```bash
git clone <repository-url>
cd Grocery-shopping-app-iOS
```

---

### 2️⃣ Branch Structure

| Branch                   | Purpose                            |
| ------------------------ | ---------------------------------- |
| `main`                   | Production-ready, stable code only |
| `dev`                    | Active development branch          |
| `your-name` | Individual feature or fix          |

⚠️ **Never commit directly to `main` or `dev`.**

---

### 3️⃣ Create a New Branch

Always create a branch from `dev`.

```bash
git checkout dev
git pull origin dev
git checkout -b your-name/feature-name
```

**Examples**

```bash
git checkout -b tanmay
```

---

### 4️⃣ Work & Commit Changes

Make small, meaningful commits.

```bash
git status
git add .
git commit -m "DEV: added login screen UI"
```

---

### 5️⃣ Push Your Branch

```bash
git push origin your-name/feature-name
```

Then create a **Pull Request → dev branch**.

---

### 6️⃣ Merging Rules

* ✅ Feature branches → `dev`
* ✅ `dev` → `main` (only after testing)
* ❌ No direct pushes to `main`

---

## Git Commit Message Rules

All commits **must start with a commit key**.

### Commit Keys Table

| Key    | Meaning                          | Example                            |
| ------ | -------------------------------- | ---------------------------------- |
| `DEV`  | New feature or development       | `DEV: added product list screen`   |
| `FIX`  | Bug fix                          | `FIX: crash on app launch`         |
| `UI`   | UI changes only                  | `UI: updated button spacing`       |
| `API`  | API integration or changes       | `API: integrated get products API` |
| `REF`  | Refactoring (no behavior change) | `REF: cleaned up ViewModel logic`  |
| `DOC`  | Documentation changes            | `DOC: updated README`              |
| `TEST` | Tests added or updated           | `TEST: added unit tests for cart`  |

📌 **Bad commit message**

```
updated code
```

✅ **Good commit message**

```
FIX: resolved empty product list issue
```

---

## Swift Variable Declaration Guidelines

Follow **clear, readable, and safe Swift practices**.

---

### Constants vs Variables

* Use `let` whenever the value does **not change**
* Use `var` only when mutation is required

```swift
let appName = "Grocery App"
var cartItemCount = 0
```

---

### Naming Rules

* Use **camelCase**
* Names must be **descriptive**
* Avoid single-letter variables (except loops)

❌ Bad

```swift
var x = 10
let d = "data"
```

✅ Good

```swift
var totalPrice = 10
let productName = "Apple"
```

---

### Optional Handling

Avoid force unwraps (`!`).

❌ Bad

```swift
let name = user.name!
```

✅ Good

```swift
if let name = user.name {
    print(name)
}
```

or

```swift
let name = user.name ?? "Guest"
```

---

### Boolean Naming

Booleans should read naturally.

```swift
let isLoggedIn = true
let hasItemsInCart = false
```

---

### File Responsibility Rule

* **One View → One Screen**
* **One ViewModel → One View**
* Keep API logic **out of Views**

---

## Final Notes

* Keep PRs small and focused
* Follow naming conventions strictly
* If unsure → ask before pushing

Happy coding 🚀
