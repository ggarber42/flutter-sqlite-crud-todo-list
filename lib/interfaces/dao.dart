import 'package:sqflite/sqflite.dart';

abstract class DAO<T> {
  void create(T t);
  Future<List<T>> readAll();
  Future<int> update(T t);
  Future<int> delete(int id);
}