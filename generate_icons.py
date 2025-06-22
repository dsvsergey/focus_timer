#!/usr/bin/env python3
"""
Script to generate app icons from a source image for all platforms.
Requires PIL (Pillow): pip install Pillow
"""

from PIL import Image
import os


def create_macos_icons(source_path, output_dir):
    """Create app icons in different sizes for macOS."""

    # macOS icon sizes
    sizes = [
        (16, "app_icon_16.png"),
        (32, "app_icon_32.png"),
        (64, "app_icon_64.png"),
        (128, "app_icon_128.png"),
        (256, "app_icon_256.png"),
        (512, "app_icon_512.png"),
        (1024, "app_icon_1024.png"),
    ]

    return generate_icons(source_path, output_dir, sizes, "macOS")


def create_ios_icons(source_path, output_dir):
    """Create app icons for iOS."""

    # iOS icon sizes
    sizes = [
        (20, "Icon-App-20x20@1x.png"),
        (40, "Icon-App-20x20@2x.png"),
        (60, "Icon-App-20x20@3x.png"),
        (29, "Icon-App-29x29@1x.png"),
        (58, "Icon-App-29x29@2x.png"),
        (87, "Icon-App-29x29@3x.png"),
        (40, "Icon-App-40x40@1x.png"),
        (80, "Icon-App-40x40@2x.png"),
        (120, "Icon-App-40x40@3x.png"),
        (120, "Icon-App-60x60@2x.png"),
        (180, "Icon-App-60x60@3x.png"),
        (76, "Icon-App-76x76@1x.png"),
        (152, "Icon-App-76x76@2x.png"),
        (167, "Icon-App-83.5x83.5@2x.png"),
        (1024, "Icon-App-1024x1024@1x.png"),
    ]

    return generate_icons(source_path, output_dir, sizes, "iOS")


def create_android_icons(source_path):
    """Create app icons for Android."""

    # Android icon directories and sizes
    android_configs = [
        ("android/app/src/main/res/mipmap-mdpi", 48),
        ("android/app/src/main/res/mipmap-hdpi", 72),
        ("android/app/src/main/res/mipmap-xhdpi", 96),
        ("android/app/src/main/res/mipmap-xxhdpi", 144),
        ("android/app/src/main/res/mipmap-xxxhdpi", 192),
    ]

    success = True
    for output_dir, size in android_configs:
        sizes = [(size, "ic_launcher.png")]
        if not generate_icons(
            source_path, output_dir, sizes, f"Android {output_dir.split('/')[-1]}"
        ):
            success = False

    return success


def generate_icons(source_path, output_dir, sizes, platform_name):
    """Generate icons for a specific platform."""

    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)

    try:
        # Load source image
        source_img = Image.open(source_path)

        # Convert to RGBA if needed
        if source_img.mode != "RGBA":
            source_img = source_img.convert("RGBA")

        print(f"\n{platform_name} icons:")
        # Generate icons
        for size, filename in sizes:
            resized = source_img.resize((size, size), Image.Resampling.LANCZOS)
            output_path = os.path.join(output_dir, filename)
            resized.save(output_path, "PNG")
            print(f"  Generated: {filename} ({size}x{size})")

    except Exception as e:
        print(f"Error generating {platform_name} icons: {e}")
        return False

    return True


def create_base_icon():
    """Create a base timer icon if source image is not available."""
    from PIL import Image, ImageDraw

    # Create a 1024x1024 image with timer design
    size = 1024
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Background gradient (blue tones like in your image)
    center = size // 2

    # Main circle background
    margin = 60
    draw.ellipse(
        [margin, margin, size - margin, size - margin], fill=(46, 125, 154, 255)
    )  # #2E7D9A

    # Inner circle
    inner_margin = 150
    draw.ellipse(
        [inner_margin, inner_margin, size - inner_margin, size - inner_margin],
        fill=(164, 205, 215, 200),
    )  # Lighter blue

    # Timer segments (like clock face)
    segment_margin = 200
    segment_width = 40
    for i in range(12):
        angle = i * 30  # 360/12 = 30 degrees per segment
        if i % 3 == 0:  # Main segments (12, 3, 6, 9)
            # Draw thicker segments
            pass

    # Central timer symbol
    timer_margin = 300
    draw.ellipse(
        [timer_margin, timer_margin, size - timer_margin, size - timer_margin],
        fill=(255, 255, 255, 255),
    )

    # Save base icon
    img.save("base_timer_icon.png", "PNG")
    print("Created base timer icon: base_timer_icon.png")
    return "base_timer_icon.png"


if __name__ == "__main__":
    # Use the user's provided icon
    source_file = "assets/icons/v1.png"

    # Check if user's icon exists
    if not os.path.exists(source_file):
        print(f"User icon not found: {source_file}")
        print("Creating base icon instead...")
        source_file = create_base_icon()
    else:
        print(f"Using user's icon: {source_file}")

    # Check source image size
    try:
        with Image.open(source_file) as img:
            print(f"Source image: {img.size}")
    except Exception as e:
        print(f"Error reading source image: {e}")
        exit(1)

    success = True

    # Generate macOS icons
    macos_output = "macos/Runner/Assets.xcassets/AppIcon.appiconset/"
    if not create_macos_icons(source_file, macos_output):
        success = False

    # Generate iOS icons
    ios_output = "ios/Runner/Assets.xcassets/AppIcon.appiconset/"
    if not create_ios_icons(source_file, ios_output):
        success = False

    # Generate Android icons
    if not create_android_icons(source_file):
        success = False

    if success:
        print("\n✅ All icons generated successfully!")
        print(f"Source: {source_file}")
        print("Platforms: macOS, iOS, Android")
    else:
        print("\n❌ Some icons failed to generate!")
