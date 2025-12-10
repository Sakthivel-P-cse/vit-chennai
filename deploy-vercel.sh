#!/bin/bash

# Automated Vercel Deployment Script
# This script will guide you through deploying to Vercel

echo "🚀 GLYTCH Farming Dashboard - Vercel Deployment"
echo "================================================"
echo ""

# Check if vercel is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Vercel CLI not found. Installing locally..."
    npx vercel --version &> /dev/null
    if [ $? -ne 0 ]; then
        echo "❌ Error: Cannot run Vercel CLI"
        echo "Please install manually: npm i -g vercel"
        exit 1
    fi
    VERCEL_CMD="npx vercel"
else
    VERCEL_CMD="vercel"
fi

echo "✅ Vercel CLI ready"
echo ""

# Check if .env.local exists
if [ ! -f .env.local ]; then
    echo "❌ Error: .env.local not found!"
    echo "Please create .env.local with your Firebase credentials"
    exit 1
fi

echo "✅ Environment file found"
echo ""

# Read environment variables
echo "📋 Reading Firebase credentials from .env.local..."
source .env.local

# Create .env.production for Vercel
cat > .env.production << EOF
VITE_FIREBASE_API_KEY=$VITE_FIREBASE_API_KEY
VITE_FIREBASE_AUTH_DOMAIN=$VITE_FIREBASE_AUTH_DOMAIN
VITE_FIREBASE_PROJECT_ID=$VITE_FIREBASE_PROJECT_ID
VITE_FIREBASE_STORAGE_BUCKET=$VITE_FIREBASE_STORAGE_BUCKET
VITE_FIREBASE_MESSAGING_SENDER_ID=$VITE_FIREBASE_MESSAGING_SENDER_ID
VITE_FIREBASE_APP_ID=$VITE_FIREBASE_APP_ID
EOF

echo "✅ Production environment file created"
echo ""

echo "🔐 You will need to login to Vercel in your browser"
echo "Press Enter to continue..."
read

# Login to Vercel
echo "Logging in to Vercel..."
$VERCEL_CMD login

if [ $? -ne 0 ]; then
    echo "❌ Login failed"
    exit 1
fi

echo ""
echo "✅ Login successful"
echo ""

# Deploy to Vercel
echo "🚀 Deploying to Vercel..."
echo ""
$VERCEL_CMD --prod --yes \
    --build-env VITE_FIREBASE_API_KEY="$VITE_FIREBASE_API_KEY" \
    --build-env VITE_FIREBASE_AUTH_DOMAIN="$VITE_FIREBASE_AUTH_DOMAIN" \
    --build-env VITE_FIREBASE_PROJECT_ID="$VITE_FIREBASE_PROJECT_ID" \
    --build-env VITE_FIREBASE_STORAGE_BUCKET="$VITE_FIREBASE_STORAGE_BUCKET" \
    --build-env VITE_FIREBASE_MESSAGING_SENDER_ID="$VITE_FIREBASE_MESSAGING_SENDER_ID" \
    --build-env VITE_FIREBASE_APP_ID="$VITE_FIREBASE_APP_ID"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment successful!"
    echo ""
    echo "📝 IMPORTANT: Add your Vercel domain to Firebase authorized domains:"
    echo "   1. Go to https://console.firebase.google.com"
    echo "   2. Select your project: $VITE_FIREBASE_PROJECT_ID"
    echo "   3. Go to Authentication → Settings → Authorized domains"
    echo "   4. Add your Vercel domain (shown in the URL above)"
    echo ""
    echo "🔑 Test Login Credentials:"
    echo "   District Officer: demo.district@glytch.local / Demo@9999"
    echo "   Village Officer: village.rampur@glytch.gov.in / Village@1234"
else
    echo ""
    echo "❌ Deployment failed"
    exit 1
fi
