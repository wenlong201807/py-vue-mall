import os


def user_directory_path(instance, filename):
    return os.path.join(instance.username, "avatar", filename)
