import os
import tempfile
import pytest
from scripts.validate_manifest import validate


def create_temp_yaml(content):
    """
    Crea un archivo temporal YAML con el contenido proporcionado.
    Devuelve la ruta al archivo temporal.
    """
    fd, path = tempfile.mkstemp(suffix='.yaml')
    # Escribe el contenido en el archivo temporal
    with os.fdopen(fd, 'w') as tmp:
        tmp.write(content)
    return path


def test_validate_valid_yaml():
    """
    Prueba que un manifiesto YAML válido no genera errores ni termina el proceso.
    """
    valid_yaml = """
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-pod
    """
    # Crea un archivo temporal con YAML válido
    path = create_temp_yaml(valid_yaml)
    try:
        # No debe lanzar SystemExit
        validate(path)
    finally:
        # Elimina el archivo temporal
        os.remove(path)


def test_validate_invalid_yaml():
    """
    Prueba que un manifiesto YAML inválido provoca SystemExit.
    """
    invalid_yaml = """
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-pod
      invalid: [unclosed_list
    """
    # Crea un archivo temporal con YAML inválido
    path = create_temp_yaml(invalid_yaml)
    with pytest.raises(SystemExit):
        validate(path)
    # Elimina el archivo temporal
    os.remove(path)


def test_validate_nonexistent_file():
    """
    Prueba que al pasar un archivo inexistente se lanza SystemExit.
    """
    with pytest.raises(SystemExit):
        validate('no_such_file.yaml')
