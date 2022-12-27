using System.Collections;
using System.Collections.Generic;
using System;

[Serializable]
public class User
{
    public int userID;
    public string username;
    public string password;
    public int raiting;

    public delegate void OnUserUpdateInfo();

}

[Serializable]
public class Answer
{
    public string answerText;
    public int question_id;
    public int user_id;
}

[Serializable]
public class CompleteData
{
    public int task_id;
    public int user_id;
    public string mark;
    public string date;
    public string completeDate;

}
[Serializable]
public class File
{
    public string file;
    public string date;
    public string comment;
    public int user_id;
    public int task_id;
    public int file_id;

}
[Serializable]
public class Question
{
    public string question_text;
    public int question_id;
    public int task_id;
    public int user_id;
}
[Serializable]
public class Subject
{
    public int subject_id;
    public string theme_name;
    //{\"subject_id\":null,\"theme_name\":null},
}
[Serializable]
public class Task
{

    public int task_id;
    public string task_name;
    public string characteristic;
    public int subject_id;
    public string task_date;

}


