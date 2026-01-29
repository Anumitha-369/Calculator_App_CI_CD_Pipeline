# Use lightweight Nginx image
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy your calculator app to nginx web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80for the application to be accessible as container port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]





