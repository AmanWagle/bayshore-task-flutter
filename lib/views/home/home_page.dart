import 'package:bayshore_task_frontend/view_model/auth_view_model.dart';
import 'package:bayshore_task_frontend/view_model/book_view_model.dart';
import 'package:bayshore_task_frontend/views/auth/login_page.dart';
import 'package:bayshore_task_frontend/views/books/book_form_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bayshore_task_frontend/views/home/components/book_grid.dart';
import 'package:bayshore_task_frontend/views/home/components/nav_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCriteria = 'Title';
  TextEditingController keywordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookViewModel>(context, listen: false).fetchBooks();
      Provider.of<AuthViewModel>(context, listen: false)
          .loadUserFromPreferences();
    });
  }

  // Trigger search action
  void onSearch() {
    final keyword = keywordController.text;
    if (keyword.isNotEmpty && selectedCriteria != null) {
      Provider.of<BookViewModel>(context, listen: false)
          .searchBooks(selectedCriteria!, keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          "Library Books",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Show the floating action button only if the user is not logged in or is a librarian
      floatingActionButton: authViewModel.user == null ||
              authViewModel.user?.role == "librarian"
          ? FloatingActionButton(
              onPressed: () {
                // Redirect to login page if user is not logged in or user is not librarian
                if (authViewModel.user == null &&
                    authViewModel.user?.role != "librarian") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                  return;
                }
                // Redirect ot book form page
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BookFormPage();
                }));
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: NavDrawer(user: authViewModel.user),
      body: Consumer<BookViewModel>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedCriteria,
                      items: ['Title', 'Author', 'Genre']
                          .map((criteria) => DropdownMenuItem<String>(
                                value: criteria,
                                child: Text(criteria),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCriteria = newValue;
                        });
                      },
                      hint: Text('Criteria'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          controller: keywordController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              context.read<BookViewModel>().fetchBooks();
                            }
                          },
                          onSubmitted: (_) => onSearch(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: onSearch,
                    ),
                  ],
                ),
              ),
              if (provider.isLoading)
                Center(child: CircularProgressIndicator()),
              if (provider.books.isEmpty)
                Center(child: Text("No books available")),
              Expanded(
                child: BookGrid(books: provider.books),
              ),
            ],
          );
        },
      ),
    );
  }
}
