abstract class TasksStates {}

class BoardInitialState extends TasksStates {}
class TasksDatabaseInitialized extends TasksStates {}
class InsertDataToTasksDatabaseState extends  TasksStates {}
class FetchDataState extends TasksStates {}
class SelectTaskState extends TasksStates {}
class MarkAsCompletedState extends TasksStates {}
