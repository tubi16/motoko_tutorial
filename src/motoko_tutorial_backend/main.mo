<<<<<<< HEAD
actor {
  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
};
=======
import Bool "mo:base/Bool";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Map "mo:base/HashMap";
import Iter "mo:base/Iter";
// ToDo Project

actor Assitant {
  type ToDo = {
    description : Text;
    completed : Bool;
  };

  //Hashmap
  func natHash(n: Nat) : Hash.Hash {
    Text.hash(Nat.toText(n))
  };

  var todos = Map.HashMap<Nat, ToDo>(0, Nat.equal, natHash);
  var nextId : Nat = 0;

  public query func getTodos() : async [ToDo] {
    Iter.toArray(todos.vals());
  };

  //ID ToDo ataması - sorgu ve tanımlama
  public query func addTodo(description: Text) : async Nat {
    let id = nextId;
    todos.put(id, {description = description; completed = false});
    nextId += 1;
    id
  };

  //update ataması
  public func completeToDo(id: Nat): async () {
    ignore do ? {
      let description = todos.get(id)!.description;
      todos.put(id, {description; completed = true});
    }
  };

  public query func showTodos() : async Text {
    var output : Text = "\n___To-Dos___";
    for (todo: ToDo in todos.vals()) {
      output #= "\n" # todo.description;
      if (todo.completed) {output #= "+"};
    };
    output # "\n"
  };

  public func clearCompleted() : async () {
    todos := Map.mapFilter<Nat, ToDo, ToDo>(todos, Nat.equal, natHash,
    func(_, todo) {if (todo.completed) null else ?todo});
  };
}
>>>>>>> 99861bf (Motoko n Rust Projects)
