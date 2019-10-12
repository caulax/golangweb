FROM golang:1.13.1-alpine3.10 as builder
WORKDIR /app
COPY src/ .
RUN go build -o main . 


FROM alpine:3.10  
WORKDIR /app/
COPY --from=builder /app/main . 
CMD ["./main"]
