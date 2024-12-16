# Stage 1 : Environment Stage
FROM golang:1.22.5 as base
WORKDIR /app
COPY . .
RUN go mod download
COPY . .
RUN go build -o main .

# Final Stage - Distroless Image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]