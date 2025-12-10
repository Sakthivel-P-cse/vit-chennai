# Vercel Deployment Guide for GLYTCH Farming Dashboard

## Prerequisites
1. Install Vercel CLI: `npm i -g vercel`
2. Create a Vercel account at https://vercel.com

## Deployment Steps

### Option 1: Deploy via Vercel CLI (Recommended)

1. **Login to Vercel**
   ```bash
   vercel login
   ```

2. **Deploy to Vercel**
   ```bash
   vercel
   ```
   - Follow the prompts
   - Choose project name: `glytch-farming-dashboard`
   - Select settings (use defaults)

3. **Deploy to Production**
   ```bash
   vercel --prod
   ```

### Option 2: Deploy via GitHub (Automatic)

1. **Connect Repository to Vercel**
   - Go to https://vercel.com/new
   - Import your GitHub repository: `Sakthivel-P-cse/vit-chennai`
   - Vercel will auto-detect Vite configuration

2. **Configure Environment Variables**
   Add these in Vercel Dashboard → Project Settings → Environment Variables:
   ```
   VITE_FIREBASE_API_KEY=<your-api-key>
   VITE_FIREBASE_AUTH_DOMAIN=<your-auth-domain>
   VITE_FIREBASE_PROJECT_ID=<your-project-id>
   VITE_FIREBASE_STORAGE_BUCKET=<your-storage-bucket>
   VITE_FIREBASE_MESSAGING_SENDER_ID=<your-sender-id>
   VITE_FIREBASE_APP_ID=<your-app-id>
   ```

3. **Deploy**
   - Click "Deploy"
   - Vercel will build and deploy automatically

## Important Notes

### Firebase Configuration
⚠️ **You MUST add environment variables in Vercel Dashboard** for the app to work:
- Go to your project → Settings → Environment Variables
- Add all `VITE_FIREBASE_*` variables from your `.env.local` file
- Deploy again after adding variables

### Domain Configuration
- Default domain: `your-project.vercel.app`
- Custom domain: Configure in Vercel Dashboard → Domains

### Build Settings (Auto-detected)
- Framework: Vite
- Build Command: `npm run build`
- Output Directory: `dist`
- Install Command: `npm install`

## Post-Deployment

1. **Test the deployment**
   ```
   https://your-project.vercel.app
   ```

2. **Login Credentials**
   - District Officer: `demo.district@glytch.local` / `Demo@9999`
   - Village Officer: `village.rampur@glytch.gov.in` / `Village@1234`

3. **Monitor Logs**
   - View build logs in Vercel Dashboard
   - Check runtime logs for any issues

## Troubleshooting

### Build Fails
- Check that all dependencies are in `package.json`
- Verify Node.js version compatibility

### App Loads but Firebase Fails
- Verify environment variables are set correctly in Vercel
- Check Firebase project settings (authorized domains)
- Add your Vercel domain to Firebase authorized domains:
  - Firebase Console → Authentication → Settings → Authorized domains
  - Add: `your-project.vercel.app`

### Routes Don't Work (404 on Refresh)
- Already configured in `vercel.json` with rewrites
- All routes will redirect to `index.html` for client-side routing

## Quick Deploy Command

```bash
# Install Vercel CLI globally
npm i -g vercel

# Login
vercel login

# Deploy
vercel --prod
```

## Continuous Deployment

Once connected to GitHub:
- Every push to `main` branch → automatic deployment to production
- Pull requests → preview deployments
- Vercel will show preview URLs in GitHub PR comments
