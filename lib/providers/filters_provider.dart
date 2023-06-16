import 'package:flutter_meal_app/providers/meals_provider.dart';
import 'package:flutter_meal_app/screens/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state, //this copies the existing maps key value pair
      filter: isActive,
    };
  }
}

final filtersProvider =
StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      // Checking if the _selectedFilter is gluten free and whether the meal is gluten free
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});

/**
    The code you provided is using the Flutter Riverpod library to define a state notifier for managing filters in a Flutter meal app.

    Here's a breakdown of the code:

    The Filter enum defines different types of filters: gluten-free, lactose-free, vegetarian, and vegan.
    The FiltersNotifier class extends StateNotifier and manages the state of the filters. It initializes the state with all filters set to false.
    The setFilter method allows changing the state of a specific filter. When called, it updates the state by creating a new map with the existing key-value pairs copied using the spread operator (...state), and then updates the value of the specified filter.
    The filtersProvider is a StateNotifierProvider that provides an instance of FiltersNotifier and exposes the current state (Map<Filter, bool>) to the widgets that depend on it.
    Overall, this code sets up a state management system using Riverpod to handle filters in a Flutter meal app. It allows you to update and access the state of different filters from multiple widgets.
 */
