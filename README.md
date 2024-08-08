# Bin Rashid Task App

This is a Flutter application for browsing and searching products, built using the BLoC pattern for state management. The app fetches data from a fake store API and displays a list of products, allowing users to search and view detailed information about each product.

## Features

- **Product Listing**: Fetches and displays a list of products from a remote API.
- **Search Functionality**: Allows users to search for products by title.
- **Product Details**: Displays detailed information about a selected product.
- **BLoC Pattern**: Implements state management using the BLoC pattern.

## Screenshots

### Home Screen
![Home Screen](screenshots/home_screen.png)

### Product Details
![Product Details](screenshots/product_details.png)

## Getting Started

### Prerequisites

- **Flutter**: Make sure you have Flutter installed. You can download it from [flutter.dev](https://flutter.dev/docs/get-started/install).

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/bin_rashid_task_app.git
    ```
2. **Navigate to the project directory**:
    ```bash
    cd bin_rashid_task_app
    ```
3. **Install dependencies**:
    ```bash
    flutter pub get
    ```
4. **Run the application**:
    ```bash
    flutter run
    ```

### Project Structure

e

lib/
│
├── data/
│ ├── models/
│ │ └── product_model.dart # Product model class
│ └── repos/
│ └── product_repo.dart # Repository class for fetching products
│
├── presentation/
│ ├── blocs/
│ │ └── products/
│ │ ├── products_bloc.dart # BLoC class for products
│ │ ├── products_event.dart # BLoC events
│ │ └── products_state.dart # BLoC states
│ └── ui/
│ ├── screens/
│ │ ├── home_screen.dart # Home screen displaying the product list
│ │ └── product_details_screen.dart # Screen for displaying product details
│ └── widgets/
│ └── product_item.dart # Widget for displaying individual product items
│
└── main.dart # Entry point of the application


### Dependencies

- **flutter_bloc**: For implementing the BLoC pattern.
- **freezed_annotation**: For creating immutable data classes and sealed unions.
- **http**: For making HTTP requests to the API.

### API

This app fetches product data from the [Fake Store API](https://fakestoreapi.com/).

### Contributing

Contributions are welcome! If you have suggestions or bug reports, please create an issue or submit a pull request.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Contact

For any inquiries or support, please contact [your.email@example.com](mailto:your.email@example.com).

