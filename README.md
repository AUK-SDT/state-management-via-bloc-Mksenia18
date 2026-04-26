# HTTP Cat Browser

Flutter app for browsing cat images by HTTP status code using the public
[HTTP Cat API](https://http.cat/).  
The project is refactored into layered architecture to keep UI, business logic,
and data access clearly separated.

## What the app does

- Loads a real cat image for an entered HTTP status code (100-599).
- Validates status codes and handles not-found API responses.
- Lets users save/remove favorite cats.
- Provides a separate favorites screen to review saved items.

## New Feature Added

This project adds a **Favorites feature** with:

- a new screen: `FavoritesScreen`
- new business logic:
  - toggle favorite state
  - load favorite list
  - determine whether current cat is favorited

## API Used

- **HTTP Cat**: https://http.cat/
- Example request: `https://http.cat/404`

## Project Structure

Main code lives in `lib/features/http_cat/`:

- `presentation/`  
  UI widgets, BLoC, and user interaction handling.
- `domain/`  
  Entities, repository contracts, and use-cases (business logic).
- `data/`  
  Repository implementation, remote data source (API), local data source
  (in-memory favorites), and models/DTOs.

## Where Business Logic Is Located

- Use-cases in `lib/features/http_cat/domain/usecases/`:
  - `GetCatByStatusCode`
  - `GetFavoriteCats`
  - `ToggleFavoriteCat`
- BLoC orchestration in
  `lib/features/http_cat/presentation/bloc/cat_bloc.dart`

## How to Run

1. Install Flutter (stable channel).
2. In project root, run:

   ```bash
   flutter pub get
   flutter run
   ```

3. Enter an HTTP status code in the app and load the cat image.

## Notes About API Keys

HTTP Cat does not require an API key.  
If you integrate a key-based API later, keep secrets outside the repository
and add local config files (for example `.env`) to `.gitignore`.
