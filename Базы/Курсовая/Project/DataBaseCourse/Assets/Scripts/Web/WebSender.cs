using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using UnityEngine;
using UnityEngine.Networking;

public class WebSender : MonoBehaviour
{


    [SerializeField] private string[] urlsToCheckConnection;

    [SerializeField] private string serverURL = "http://localhost/";

    public void PostQueryOnServer(string postData, string url, Action<string> callback)
    {
        StartCoroutine(Download(postData, url, (data) =>
        {
            
            if (data != null)
            {
                string result = System.Text.Encoding.UTF8.GetString(data);
                callback.Invoke(result);
            }
            else
            {
                callback.Invoke(null);
            }

        }));

    }

    public void GetFile(string url, Action<byte[]> callback)
    {
        StartCoroutine(DownloadFile(url, (data) =>
        {
            if (data != null)
            {
                //string result = System.Text.Encoding.UTF8.GetString(data);
                callback.Invoke(data);
            }
            else
            {
                callback.Invoke(null);
            }

        }));

    }



    IEnumerator Download(string postData, string url, Action<byte[]> callback)
    {

        UnityWebRequest www = new UnityWebRequest(url);
        www.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(postData));
        www.downloadHandler = new DownloadHandlerBuffer();
        www.uploadHandler.contentType = "application/x-www-form-urlencoded";
        www.method = UnityWebRequest.kHttpVerbPOST;

        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
            callback.Invoke(null);
        }
        else
        {
            callback.Invoke(www.downloadHandler.data);
        }
    }


    IEnumerator DownloadFile(string url, Action<byte[]> callback)
    {

        UnityWebRequest www = new UnityWebRequest(url);
        www.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(url));
        www.downloadHandler = new DownloadHandlerBuffer();
        www.uploadHandler.contentType = "application/x-www-form-urlencoded";
        www.method = UnityWebRequest.kHttpVerbGET;

        yield return www.SendWebRequest();

        if (www.result != UnityWebRequest.Result.Success)
        {
            Debug.Log(www.error);
            callback.Invoke(null);
        }
        else
        {
            callback.Invoke(www.downloadHandler.data);
        }
    }




    public void CheckInternetConnection(Action<ConnectionResult> callback)
    {
        StartCoroutine(CheckInternetConnectionCoroutine(callback));
    }

    IEnumerator CheckInternetConnectionCoroutine(Action<ConnectionResult> callback)
    {
       
        {
            UnityWebRequest www = UnityWebRequest.Get(serverURL);


            yield return www.SendWebRequest();

            if (www.result == UnityWebRequest.Result.Success)
            {
                callback.Invoke(ConnectionResult.success);
                yield break;
            }

        }
 
        foreach (var url in urlsToCheckConnection)
        {
            UnityWebRequest www = UnityWebRequest.Get(url);


            yield return www.SendWebRequest();

            if (www.result == UnityWebRequest.Result.Success)
            {
                callback.Invoke(ConnectionResult.ServerCrushed);
                yield break;
            }
        }

        
        callback.Invoke(ConnectionResult.noInternet);



    }


    public enum ConnectionResult
    {
        noInternet,
        ServerCrushed,
        success,
    }

}