import subprocess


class Sink:
    def __init__(self):
        self.master_sink = self.get_master_sink()
        self.volume = self.get_volume()
        self.is_mute = self.get_mute_state()

    def get_master_sink(self):
        output = subprocess.check_output(["pactl", "list", "sinks"]).decode("utf-8")
        sinks_list = output.split("\n\n")
        master_sink = sinks_list[0]
        return master_sink

    def find_line(self, str, search_term):
        result = [line for line in str.splitlines() if search_term in line][0]
        return result

    def get_volume(self):
        volume_line = self.find_line(self.master_sink, "Volume:")
        volume_percentage = volume_line.split("/")[1].strip()
        volume = volume_percentage.replace("%", "")
        return volume

    def get_mute_state(self):
        mute_line = self.find_line(self.master_sink, "Mute:")
        mute_state = mute_line.split(":")[1].strip()
        is_mute = True if mute_state == "yes" else False
        return is_mute


class Notification:
    def __init__(self, sink):
        self.sink = sink
        self.icon = self.set_icon()
        self.bar = self.set_bar()

    def set_icon(self):
        volume = int(self.sink.volume)

        if self.sink.is_mute:
            return "audio-volume-muted"
        else:
            if volume > 66:
                return "audio-volume-high"
            elif volume > 33:
                return "audio-volume-medium"
            else:
                return "audio-volume-low"

    def set_bar(self):
        volume = int(self.sink.volume)
        if volume >= 100:
            complete_space = "━" * 32
            remaining_space = ""
        else:
            complete_space = "━" * (volume // 3)
            remaining_space = "┉" * (32 - (volume // 3))

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
                    "string:x-dunst-stack-tag:volume",
                    self.bar["complete"],
                    self.bar["remaining"] + " " + self.sink.volume.rjust(4) + "%",
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
    sink = Sink()
    notification = Notification(sink)
    notification.show()


if __name__ == "__main__":
    main()
