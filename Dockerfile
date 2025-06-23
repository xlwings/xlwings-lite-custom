ARG XLWINGS_LITE_VERSION=latest

# Builder
FROM xlwings/xlwings-lite:${XLWINGS_LITE_VERSION} AS builder

# Install Python (required by register_pyodide_packages.py)
RUN apk add --no-cache python3

# Copy the desired packages into the Pyodide directory
COPY ./packages/* "/srv/static/vendor/pyodide/${PYODIDE_VERSION}/"

# Register the new packages in pyodide-lock.json
RUN python /scripts/register_pyodide_packages.py

# Don't include Python in final image
FROM xlwings/xlwings-lite:${XLWINGS_LITE_VERSION}
COPY --from=builder /srv /srv
