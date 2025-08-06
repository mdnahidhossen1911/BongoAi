# BangoAI - Personal AI Chat Assistant App

**Note:** This project is currently under construction. Features and functionalities are being developed and may change over time.

BangoAI is a smart AI chat assistant app that supports both Bengali and English languages. Built with Flutter, it uses **OpenRoute API** for map and routing features, with Supabase as backend, Google Sign-In for authentication, and offline data handled using sqflite.


## Features

- AI-powered conversation interface  
- Bengali and English language support  
- Google Sign-In authentication  
- Supabase backend for cloud data & real-time sync  
- Offline-first support using sqflite  
- Map & direction-based features using **OpenRoute API**  
- MVVM architecture using Provider  
- Responsive & clean Flutter UI  



## Tech Stack

- Flutter (Dart)  
- Provider (State Management)  
- Supabase (Backend & Auth)  
- sqflite (Local storage)  
- Google Sign-In (Authentication)  
- **OpenRoute API** (Map & Routes)  



## Environment Variables (.env)

Create a `.env` file in your project root with the following:

~~~
GOOGLESIGNID='YOUR_GOOGLE_SIGN_IN_ID'
SUPABASEURL='YOUR_SUPABASE_PROJECT_URL'
ANOKEY='YOUR_SUPABASE_ANON_KEY''
OPENROUTE_API_KEY=your_openroute_api_key
~~~

## Installation & Setup

1. Clone the repository:
   ~~~
   git clone https://github.com/mdnahidhossen1911/BongoAi.git
   ~~~
   
2. Install dependencies:

3. Create and configure `.env` file as described above.

4. Run the app:

## Figma Design

You can preview the UI/UX design here:  
Figma Link: [https://www.figma.com/design/mHZHv81LsBEw84uTGchZiq/BangoAi?node-id=0-1&t=pyq5defVUEdiO9SA-1](https://www.figma.com/design/mHZHv81LsBEw84uTGchZiq/BangoAi?node-id=0-1&t=pyq5defVUEdiO9SA-1)


## Folder Structure (MVVM)

~~~
lib/
│
├── data/ # API, DB services (Supabase, sqflite)
├── models/ # Data models
├── viewmodels/ # Business logic
├── views/ # UI screens
├── utils/ # Constants, helpers
├── main.dart # Entry point
~~~





