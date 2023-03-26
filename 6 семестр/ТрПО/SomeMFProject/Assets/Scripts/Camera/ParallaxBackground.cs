using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParallaxBackground : MonoBehaviour
{
    [SerializeField] private Vector2 parallaxEffectMultiplier;
    [SerializeField] private bool infiniteHorizontal;
    [SerializeField] private bool infiniteVertical;


    [SerializeField] private Transform cameraTransform;
    private Vector3 lastCameraPosition;
    private float textureUnitSizeX;
    private float textureUnitSizeY;

    private void Start()
    {
        lastCameraPosition = cameraTransform.position;
        Sprite sprite = GetComponent<SpriteRenderer>().sprite;
        Texture2D texture = sprite.texture;
        textureUnitSizeX = texture.width / sprite.pixelsPerUnit;
        textureUnitSizeY = texture.height / sprite.pixelsPerUnit;
    }


    private void LateUpdate()
    {
        Vector3 deltaMovement = cameraTransform.position - lastCameraPosition;

        transform.position += new Vector3(deltaMovement.x * parallaxEffectMultiplier.x, deltaMovement.y * parallaxEffectMultiplier.y);
        lastCameraPosition = cameraTransform.position;

        if(Mathf.Abs(cameraTransform.position.x - transform.position.x) >= textureUnitSizeX)
        {
            float offsetPositionX = (cameraTransform.position.x - transform.position.x) % textureUnitSizeX;
            transform.position = new Vector3(cameraTransform.position.x + offsetPositionX, transform.position.y);
        }
        if (Mathf.Abs(cameraTransform.position.y - transform.position.y) >= textureUnitSizeY)
        {
            float offsetPositionY = (cameraTransform.position.y - transform.position.y) % textureUnitSizeY;
            transform.position = new Vector3(cameraTransform.position.y + offsetPositionY, transform.position.y);
        }
    }




}
