import sys
import yaml

pre_commit = sys.argv[1]
try:
    with open(pre_commit, 'r') as file:
        yaml.safe_load(file)
except Exception as e:
    print(f"Error en {pre_commit}: {e}")
    sys.exit(1)