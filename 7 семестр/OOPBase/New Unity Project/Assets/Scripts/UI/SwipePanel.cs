using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class SwipePanel : MonoBehaviour
{

    [Header("Rect transform to swipe")]
    [SerializeField] private RectTransform rt;

    [SerializeField] private bool IsHideOnStart;

    [SerializeField] private bool RightLeftSwipe = true;

    /// <summary>
    /// ������� 
    /// </summary>
    [SerializeField] private RectTransform hidePosition, showPosition;
    [SerializeField] private float movingTime = 0.3f;


    /// <summary>
    /// ����, �� ������� �� ����� ��������� ������ 
    /// (�� ����� �� ����� �������������)
    /// </summary>
    [SerializeField] private RectTransform DeadZone;


    /// <summary>
    /// ���� � ������� ����� �������� ����� (���� null, �� �� ����� �������� �� ����� ������)
    /// </summary>
    [SerializeField] private RectTransform SwipeZone;


    /// <summary>
    /// ����� �� �������� (� �� �� ���� ��� �� �������)
    /// </summary>
    public bool EnableSwiping;
    public bool Test;


    private bool lockSwiping;




    /// <summary>
    /// ��������� ������� ������ ��� ������ ������
    /// </summary>
    Vector2 startPanelPosition = Vector2.zero;



    /// <summary>
    /// ������ ����������?
    /// </summary>
    private bool isSwiping = false;

    /// <summary>
    /// ������ ������ ��������?
    /// </summary>
    private bool isHide;

    /// <summary>
    /// ��������� ������� ������
    /// </summary>
    Vector2 startSwipePisition = Vector2.zero;

    /// <summary>
    /// ��������� ������� ������ ���� �� ������� ����
    /// </summary>
    private bool startDeadZone;

    /// <summary>
    /// �������� ������� ������
    /// </summary>
    Vector2 endSwipePosition = Vector2.zero;
    /// <summary>
    /// ������������ ������� ������ (������� ��������)
    /// </summary>
    Vector2 tapPosition = Vector2.zero;

    private void Start()
    {

        if (rt == null)
        {
            Debug.Log($"Swipe panel RT is null in {this.name} - Try to GetComponent");
            TryGetComponent<RectTransform>(out rt);
        }

        if (!RightLeftSwipe)
        {
            Debug.LogError("����� ������ ���� ��� �� �������!!!");
        }

        CalculateDistance();

        if (IsHideOnStart)
        {
            Hide();
        }
        else
        {
            Show();
        }
    }


    private void CalculateDistance()
    {
        if (RightLeftSwipe)
        {

            distanceToSwipe = Screen.width * percOfScreen;

        }
        else
        {

            distanceToSwipe = Screen.height * percOfScreen;

        }
    }



    private void Update()
    {

        if (!EnableSwiping || lockSwiping) return;
        if (Input.touchCount > 0)
        {
            // ���� ����� ��������� � ����� �������, �� ������� ������
            if (Input.GetTouch(0).phase == TouchPhase.Moved && isSwiping)
            {
                tapPosition = Input.GetTouch(0).position;
                //Debug.Log($"X - {tapPosition.x}");
                //Debug.Log($"Y - {tapPosition.y}");
                if (!startDeadZone)
                {
                    if (RightLeftSwipe)
                    {
                        if(rt) rt.position = new Vector2(startPanelPosition.x - (startSwipePisition.x - tapPosition.x), rt.position.y);
                    }
                    else
                    {
                        if (rt) rt.position = new Vector2(rt.position.x, startPanelPosition.y - (startSwipePisition.y - tapPosition.y));
                    }
                }


            }
            // ����� ����� ������ �������
            else if (Input.GetTouch(0).phase == TouchPhase.Began)
            {
                // ������ �������


                // ��������� ��������� ������� ������
                startSwipePisition = Input.GetTouch(0).position;

                if (!isSwipeZone())
                {
                    ResetSwipe();
                    return;
                }

                isSwiping = true;

                tapPosition = Input.GetTouch(0).position;
                // � ��������� ������� ������
                startPanelPosition = rt.position;

                // ����������� ���� �� ��� ������� ����
                CheckDeadZone();

            }
            // ����� ����� ����������
            else if ((Input.GetTouch(0).phase == TouchPhase.Canceled ||
                Input.GetTouch(0).phase == TouchPhase.Ended
                ) && isSwiping)
            {
                // ����� ��������� �����
                tapPosition = Input.GetTouch(0).position;

                OnEndSwipeMethod();
                ResetSwipe();
            }

        }



    }

    ///////////////////////////////// �������� /////////////////////////////////

    public delegate void onSwipe();

    /// <summary>
    /// ����������, ���� ������������ �������� � ���� �����������
    /// </summary>
    public onSwipe onSwipeShow;

    /// <summary>
    /// ����������, ���� ������������ �������� � ���� �����������
    /// </summary>
    public onSwipe onSwipeHide;


    private float distanceToSwipe;

    [Header("Percent of Screen to Swipe (0 - 1)")]
    /// <summary>
    /// �� ������� ��������� �� �������� ������ ����� �������� ����� 0 - 1
    /// </summary>
    [SerializeField] private float percOfScreen;





    private bool isSwipeZone()
    {


        if (SwipeZone == null) return true;

        if (RectTransformUtility.RectangleContainsScreenPoint(SwipeZone, startSwipePisition))
        {
            return true;
        }
        else return false;


    }

    private void CheckDeadZone()
    {
        if (DeadZone == null)
        {
            startDeadZone = false;
            return;
        }



        if (RectTransformUtility.RectangleContainsScreenPoint(DeadZone, startSwipePisition))
        {
            startDeadZone = true;
        }
        else
        {
            startDeadZone = false;
        }

        
    }





    /// <summary>
    /// ����� ������ - ������������ �������� � ����� ���������
    /// </summary>
    private void OnEndSwipeMethod()
    {
        endSwipePosition = tapPosition;

        float distance;

        if (RightLeftSwipe)
        {
            distance = Mathf.Abs(startSwipePisition.x - endSwipePosition.x);
        }
        else
        {
            distance = Mathf.Abs(startSwipePisition.y - endSwipePosition.y);
        }




        if (distance >= distanceToSwipe)
        {
            if (isHide)
            {
                Show();
                onSwipeShow?.Invoke();
            }
            else
            {
                Hide();
                onSwipeHide?.Invoke();
            }
        }
        else
        {
            if (isHide)
            {
                Hide();
                onSwipeShow?.Invoke();
            }
            else
            {
                Show();
                onSwipeHide?.Invoke();
            }
        }


    }



    public void Show()
    {
        lockSwiping = true;

        isHide = false;
        if(rt) rt.DOMove(showPosition.position, CalculateTime()).OnComplete(() =>
        {
            lockSwiping = false;

        });
    }

    public void Hide()
    {
        lockSwiping = true;

        isHide = true;
        if (rt) rt.DOMove(hidePosition.position, CalculateTime()).OnComplete(() =>
        {
            lockSwiping = false;

        });
    }

    private float CalculateTime()
    {

        float perc = 100;
        if (RightLeftSwipe)
        {



            // ������� ����� ������
            float alldistance = Mathf.Abs(hidePosition.position.x - showPosition.position.x);

            // ������� ��������� �������� ������ 
            float distance;

            if (isHide)
            {
                distance = rt.position.x - hidePosition.position.x;
            }
            else
            {
                distance = rt.position.x - showPosition.position.x;
            }

            distance = Mathf.Abs(distance);

            perc = distance * 100 / alldistance;



        }
        else
        {
            // ������� ����� ������
            float alldistance = Mathf.Abs(hidePosition.position.y - showPosition.position.y);

            // ������� ��������� �������� ������ 
            float distance;

            if (isHide)
            {
                distance = rt.position.y - hidePosition.position.y;
            }
            else
            {
                distance = rt.position.y - showPosition.position.y;
            }

            distance = Mathf.Abs(distance);

            perc = distance * 100 / alldistance;


        }

        perc /= 100;

        var res = movingTime * perc;

        return res;

    }

    /// <summary>
    /// ��������� ���� ����������
    /// </summary>
    private void ResetSwipe()
    {
        startSwipePisition = Vector2.zero;

        endSwipePosition = Vector2.zero;

        tapPosition = Vector2.zero;

        startPanelPosition = Vector2.zero;

        isSwiping = false;
    }




}
