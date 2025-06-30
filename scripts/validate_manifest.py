import sys
import yaml


def validate(manifest_path):
    try:
        with open(manifest_path, 'r') as file:
            yaml.safe_load(file)
    except Exception as e:
        print(f"Error en {manifest_path}: {e}")
        sys.exit(1)


if __name__ == "__main__":
    pre_commit = sys.argv[1]
    validate(pre_commit)