import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_2/domain/models/todo.dart';
import 'package:todo_app_2/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // L O A D
  Future<void> loadTodos() async {
    // fetch list of todos from repo
    final todoList = await todoRepo.getTodos();

    // emit the fetched list as the new state
    emit(todoList);
  }

  // A D D
  Future<void> addTodo(String text) async {
    // create a new todo with unique Id
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
      isCompleted: false, //changes done
    );

    // save the new todo to repo
    await todoRepo.addTodo(newTodo);

    // re-load
    loadTodos();
  }

  // D E L E T E
  Future<void> deleteTodo(Todo todo) async {
    // delete the provided todo from repo
    await todoRepo.deleteTodo(todo);

    // re-load
    loadTodos();
  }

  // T O G G L E
  Future<void> toggleCompletion(Todo todo) async {
    // toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    // update the todo in repo with new completion status
    await todoRepo.updateTodo(updatedTodo);

    // re-load
    loadTodos();
  }
}
