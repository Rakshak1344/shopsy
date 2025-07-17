# Shopsy

- An assignment from PocketFM, prototype for a small online store's mobile interface.

---
Objectives:
- Product list from local JSON file
- View product details
- Add to cart
- Cart screen with total price and item removal
---
- Requirements:
- No API needed, use mock JSON
- Maintain cart state in memory
- Optional: Save cart using local storage
  Evaluation Focus: List rendering, shared state, navigation flow
  Expected Duration: 5-6 hours

## 1. Setup

Before you begin, ensure you have the necessary tools installed on your system.

### **Install FVM (Flutter Version Manager)**

FVM allows you to manage multiple Flutter SDK versions on your machine.

```bash
curl -fsSL [https://fvm.app/install.sh](https://fvm.app/install.sh) | bash
```

### **Activate Global Dart Packages**

Activate `melos` for managing multi-package repositories.

```bash
fvm use --force
fvm flutter pub global activate melos
```

### **Bootstrap and Generate Files**

Run these commands to link all local packages and generate necessary files.

```bash
melos bs
melos gen
```
Run the project

---
# Architecture:
The Shopsy application follows a layered architecture designed for scalability, maintainability, and a clear separation of concerns. The data flows unidirectionally, ensuring a predictable state management and data synchronization process.

The architecture is composed of the following layers:

### 1. UI Layer
-   **Responsibility**: To render the user interface.
-   **Mechanism**: It listens to a `Stream` of `State` objects. Whenever a new state is emitted, the UI layer rebuilds immediately to reflect the changes. This ensures that the UI is always a direct representation of the application's current state.

### 2. State Management
-   **Responsibility**: To manage the application's state and notify the UI of any updates.
-   **Technology**: It utilizes Riverpod's `StateNotifier`.
-   **Mechanism**: The `StateNotifier` is updated with the latest data from the `LocalDB`. It then emits a new state object, which is picked up by the listening UI layer. This update happens as soon as the local database changes, ensuring a reactive and efficient UI.

### 3. Service Layer
-   **Responsibility**: To handle business logic and process data.
-   **Mechanism**: The Service layer is responsible for appending processed data to the persistent `LocalDB`. It acts as an intermediary between the data sources and the local database.

### 4. Local Data Repository
-   **Responsibility**: To store processed data in a persistent local database, making it available for offline use and providing a single source of truth for the application's state.
-   **Technology**: The implementation uses the `hive` database.
-   **Mechanism**: It stores the data provided by the Service layer. Any changes in this repository trigger the update flow that ultimately reaches the UI.

### 5. Network Repository (Remote Data Access)
-   **Responsibility**: To fetch data from all external sources. This layer is considered the ultimate source of truth from which the local data is synchronized.
-   **Components**:
-   **Custom API Server**: For fetching data from a backend server.
-   **Other External Sources**: Can be any other third-party API or data source.

---
