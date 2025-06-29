# Etapa de build
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --user --no-cache-dir -r requirements.txt

# Etapa final
FROM python:3.11-slim AS production

WORKDIR /app

# Copia dependencias instaladas por el usuario desde la etapa builder
COPY --from=builder /root/.local /root/.local

# Copia el código fuente
COPY app.py .
COPY templates/ templates/

ENV PATH=/root/.local/bin:$PATH

EXPOSE 5000

CMD ["python", "app.py"]