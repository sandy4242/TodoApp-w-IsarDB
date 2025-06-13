import '../models/todo.dart';

abstract class TodoRepo {
  //list of todos
  Future<List<Todo>> getTodos();
  //add a new todo
  Future<void> addTodo(Todo newTodo);

  //updating an existing todo
  Future<void> updateTodo(Todo todo);

  //delete a todo
  Future<void> deleteTodo(Todo todo);
}
