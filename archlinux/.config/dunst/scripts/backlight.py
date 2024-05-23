import subprocess


class Backlight:
    def __init__(self):
        self.brightness = self.get_brightness()

    def get_brightness(self):
        max_brightness_path = "/sys/class/backlight/intel_backlight/max_brightness"
        current_brightness_path = "/sys/class/backlight/intel_backlight/brightness"

        try:
            with open(max_brightness_path, "r") as max_brightness_file, open(
                current_brightness_path, "r"
            ) as current_brightness_file:
                max_brightness = int(max_brightness_file.read())
                current_brightness = int(current_brightness_file.read())
                brightness = (current_brightness * 100) // max_brightness

                return brightness
        except Exception as error:
            print(error)


class Notification:
    def __init__(self, backlight):
        self.backlight = backlight
        self.icon = self.set_icon()
        self.bar = self.set_bar()

    def set_icon(self):
        brightness = int(self.backlight.brightness)

        if brightness > 66:
            return "display-brightness-symbolic"
        elif brightness > 33:
            return "display-brightness-medium-symbolic"
        elif brightness > 1:
            return "display-brightness-low-symbolic"
        else:
            return "display-brightness-off-symbolic"

    def set_bar(self):
        brightness = int(self.backlight.brightness)

        if brightness >= 100:
            complete_space = "━" * 32
            remaining_space = ""
        else:
            complete_space = "━" * (brightness // 3)
            remaining_space = "┉" * (32 - (brightness // 3))

        return {"complete": complete_space, "remaining": remaining_space}

    def show(self):
        try:
            subprocess.run(
                [
                    "dunstify",
                    "-a",
                    "oneline",
                    "-u",
                    "low",
                    "-i",
                    self.icon,
                    "-h",
                    "string:x-dunst-stack-tag:backlight",
                    self.bar["complete"],
                    self.bar["remaining"]
                    + " "
                    + str(self.backlight.brightness).rjust(4)
                    + "%",
                ]
            )
        except Exception as error:
            subprocess.run(
                [
                    "dunstify",
                    "-a",
                    "oneline",
                    "-u",
                    "medium",
                    "-i",
                    "dialog-error-symbolic",
                    "-h",
                    "string:x-dunst-stack-tag:volume",
                    "Error: " + str(error),
                ]
            )
            print("Error: ", error)


def main():
    backlight = Backlight()
    notification = Notification(backlight)
    notification.show()


if __name__ == "__main__":
    main()
