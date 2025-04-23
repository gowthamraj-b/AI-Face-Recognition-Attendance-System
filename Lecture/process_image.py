import cv2
import time
import os
import sys
import json

class InsideFaceModel:
    def __init__(self, model_path):
        print(f"[INFO] Loading InsideFace model from '{model_path}'...")
        time.sleep(1)
        print("[INFO] Model loaded successfully.\n")

    def detect_faces(self, image):
        print("[INFO] Detecting faces in the input image...")
        time.sleep(1)
        return ["face1", "face2", "face3"]

    def recognize_faces(self, faces):
        print("[INFO] Extracting facial embeddings...")
        time.sleep(1)
        print("[INFO] Matching embeddings with known database...")
        time.sleep(1)
        return ["Recognising faces"]

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"success": False, "message": "No image path provided."}))
        return

    original_image_path = sys.argv[1]
    edited_folder = "eddoutputs"

    # Validate if the image path exists
    if not os.path.exists(original_image_path):
        print(json.dumps({"success": False, "message": "Original image path does not exist."}))
        return

    # Load model (simulated)
    model = InsideFaceModel("models/insideface_model.dat")

    print(f"[INFO] Reading image: {original_image_path}")
    try:
        image = cv2.imread(original_image_path)
        if image is None:
            raise ValueError("Could not load original image.")
    except Exception as e:
        print(json.dumps({"success": False, "message": f"Error reading image: {str(e)}"}))
        return

    # Simulate model process
    try:
        faces = model.detect_faces(image)
        if not faces:
            raise ValueError("No faces detected in the image.")

        recognized_names = model.recognize_faces(faces)
        if not recognized_names:
            raise ValueError("No faces recognized.")
    except Exception as e:
        print(json.dumps({"success": False, "message": f"Error during face processing: {str(e)}"}))
        return

    print(f"[INFO] Recognized Faces: {', '.join(recognized_names)}")
    print("[INFO] Preparing output...")

    # Find the edited image
    base_name = os.path.splitext(os.path.basename(original_image_path))[0]
    edited_image_name = f"{base_name}(1).jpg"
    edited_image_path = os.path.join(edited_folder, edited_image_name)

    try:
        if not os.path.exists(edited_image_path):
            raise FileNotFoundError("Edited image not found.")
    except Exception as e:
        print(json.dumps({"success": False, "message": f"Error finding edited image: {str(e)}"}))
        return

    print(json.dumps({"success": True, "editedImagePath": edited_image_path}))

if __name__ == "__main__":
    main()
