import 'package:bin_rashid_task_app/data/models/product_model.dart'; // Import the ProductModel class.
import 'package:flutter/material.dart'; // Import Flutter's material design widgets.

class ProductItemView extends StatelessWidget {
  // Product model and an optional onTap callback for handling user interaction
  final ProductModel model;
  final GestureTapCallback? onTap;

  const ProductItemView({
    super.key,
    required this.model, // The product data to display
    required this.onTap, // The callback function when the item is tapped
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Execute the onTap function when the item is tapped
      child: Container(
        margin: const EdgeInsets.all(10.0), // Set margin around the container
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the container
          border: Border.all(
              color: Colors.grey), // Grey border around the container
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Grey shadow with some opacity
              spreadRadius: 2, // Spread of the shadow
              blurRadius: 5, // Blur effect for the shadow
              offset: const Offset(0, 3), // Positioning of the shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Padding inside the container
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the start
            children: [
              const SizedBox(height: 10), // Vertical spacing
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Space between the image and text
                children: [
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        model.image, // Load and display the product image
                        fit: BoxFit.cover, // Cover the space proportionally
                        height: 150, // Set fixed height for the image
                        width: 150, // Set fixed width for the image
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.5, // Width for the title text
                    child: Text(
                      model.title, // Display the product title
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall, // Use headline style
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5), // Vertical spacing
              Text(
                '\$${model.price}', // Display the product price
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.green), // Green color for the price
              ),
              const SizedBox(height: 5), // Vertical spacing
              Text(
                model.category, // Display the product category
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color:
                        Colors.lightBlue), // Light blue color for the category
              ),
              const SizedBox(height: 10), // Vertical spacing
              Text(
                model.description, // Display the product description
                maxLines: 3, // Limit description to 3 lines
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium, // Use body text style
              ),
            ],
          ),
        ),
      ),
    );
  }
}
