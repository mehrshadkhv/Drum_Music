<div dir="rtl" align="right">

[English](README.md) | [فارسی](README.fa.md)

# درام موزیک (Drum Music)

<div dir="ltr" align="left">

[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.44.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%5E3.12.0-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green)](LICENSE)

</div>

یک اپ سادهٔ درام با Flutter: روی صفحه بزنید تا صداهای کوبه‌ای داخل برنامه پخش شوند و ریتم بسازید. برنامه یک صفحه، شش ناحیهٔ لمس و یک تصویر درام روی پس‌زمینهٔ زرد کهربایی دارد.

## اسکرین‌شات‌ها

| صفحهٔ درام |
| :---: |
| <img src="Assets/screenshots/drum-music.png" width="200" alt="صفحهٔ درام موزیک با تصویر درام روی پس‌زمینهٔ زرد کهربایی"/> |

اسکرین‌شات فعلی در پوشهٔ `assets/screenshots/` قرار دارد. اگر صفحهٔ جدیدی به برنامه اضافه شد، تصویرش را در همین پوشه بگذارید و به جدول اضافه کنید. برای نمایش اسکرین‌شات در README نیازی به ثبت آن در `pubspec.yaml` نیست.

## قابلیت‌های اصلی

- شش ناحیهٔ لمس در یک شبکهٔ دو ستونه و سه ردیفه؛ هر ناحیه یک فایل WAV متفاوت را پخش می‌کند.
- ساخت یک پخش‌کنندهٔ مستقل برای هر ضربه، تا صداها بتوانند هم‌زمان پخش شوند و ضربهٔ جدید جای صدای قبلی را نگیرد.
- قرار داشتن صداها و تصویر داخل برنامه؛ برای نواختن نیازی به حساب کاربری، بک‌اند یا درخواست شبکه نیست.
- حفظ نسبت ابعاد تصویر درام با `BoxFit.contain` و قرار گرفتن ناحیه‌های لمس داخل `SafeArea`.
- آزاد کردن پخش‌کننده‌ها بعد از پایان صدا و هنگام اجرای `dispose` صفحهٔ درام.

ناحیه‌های لمس بر اساس شبکهٔ صفحه هستند، نه مرز دقیق اجزای درام در تصویر. ردیف بالا فایل‌های `h1.wav` و `h2.wav`، ردیف وسط فایل‌های `c1.wav` و `c2.wav` و ردیف پایین فایل‌های `k1.wav` و `k2.wav` را پخش می‌کند.

نسخهٔ فعلی قابلیت ضبط، مترونوم، Sequencer، تنظیم حجم صدا یا ذخیرهٔ الگوی ریتم ندارد.

## ابزارها و معماری

### پکیج‌ها

وابستگی‌های مستقیم در `pubspec.yaml` این‌ها هستند:

- **Flutter SDK:** فریم‌ورک برنامه و ویجت‌های Material.
- **`audioplayers: ^6.8.1`:** پخش فایل‌های صوتی داخل پروژه با `AudioPlayer` و `AssetSource`.
- **`cupertino_icons: ^1.0.8`:** در وابستگی‌ها وجود دارد، اما صفحهٔ فعلی از آن استفاده نمی‌کند.
- **`flutter_test` (از SDK، وابستگی توسعه):** ابزارهای تست Flutter.
- **`flutter_lints: ^6.0.0` (وابستگی توسعه):** قوانین Lint که در `analysis_options.yaml` فعال شده‌اند.

برنامه از پکیج جداگانه‌ای برای State Management، شبکه، دیتابیس یا ذخیره‌سازی محلی استفاده نمی‌کند. پکیج‌هایی مثل `http` و `path_provider` به‌صورت وابستگی غیرمستقیم در `pubspec.lock` دیده می‌شوند، اما کد برنامه مستقیماً از آن‌ها استفاده نمی‌کند. `build_runner` هم در وابستگی‌ها نیست و مرحله‌ای برای تولید کد وجود ندارد.

### ساختار پروژه

<div dir="ltr" align="left">

```text
drum_music/
├── lib/
│   └── main.dart          # Entry point, app widget, drum screen, audio lifecycle
├── assets/
│   ├── images/
│   │   └── drum.png       # Drum-kit illustration
│   ├── sounds/
│   │   ├── h1.wav
│   │   ├── h2.wav
│   │   ├── c1.wav
│   │   ├── c2.wav
│   │   ├── k1.wav
│   │   └── k2.wav
│   └── screenshots/
│       └── drum-music.png # README screenshot
├── android/              # Android host project
├── web/                  # Flutter web host files
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
├── .gitattributes
├── README.md
├── README.fa.md
└── LICENSE
```

</div>

این پروژه فعلاً یک اپ تک‌فایلی با ساختار ویجت‌محور است؛ نه Clean Architecture، نه MVVM و نه ساختار feature-first. تابع `main()` ویجت `Application` را اجرا می‌کند. این ویجت یک `MaterialApp` می‌سازد و `DrumPage` را به‌عنوان صفحهٔ اصلی نمایش می‌دهد.

`DrumPage` یک `StatefulWidget` است. کلاس `_DrumPageState` فهرست `AudioPlayer`های فعال را نگه می‌دارد و مسئول پخش صدا و آزاد کردن منابع است. State داخل خود ویجت مدیریت می‌شود؛ BLoC، Provider یا Riverpod وجود ندارد و رابط کاربری هم با `setState` به‌روزرسانی نمی‌شود. صفحه با `Stack`، `Positioned.fill`، `Column`، `Row`، `Expanded` و ناحیه‌های شفاف `GestureDetector` ساخته شده است.

نام پکیج `drum_music` و نسخهٔ آن `1.0.0+1` است. توضیح فایل manifest هنوز متن پیش‌فرض `"A new Flutter project."` است و مقدار `publish_to: 'none'` دارد؛ این مخزن یک اپلیکیشن است، نه پکیجی که در pub.dev منتشر شود.

## راه‌اندازی

### ۱. نصب پیش‌نیازها

[Flutter](https://docs.flutter.dev/install) و Git را نصب کنید. محدودیت نسخهٔ Dart در `pubspec.yaml` برابر `^3.12.0` است، یعنی از نسخهٔ `3.12.0` تا قبل از `4.0.0`. فایل lock ثبت‌شده هم Flutter نسخهٔ `3.44.0` یا بالاتر را لازم دارد؛ بنابراین از Flutter SDKای استفاده کنید که هر دو شرط را داشته باشد.

برای اندروید، Android Studio و Android SDK را نصب کنید و یک شبیه‌ساز یا گوشی آماده داشته باشید. پروژهٔ اندروید Java 17 را هدف می‌گیرد؛ وضعیت ابزارهای Java و Android را با Flutter Doctor بررسی کنید. برای نسخهٔ وب هم از مرورگری استفاده کنید که نصب Flutter شما پشتیبانی می‌کند.

<div dir="ltr" align="left">

```bash
flutter --version
flutter doctor
```

</div>

فعلاً فقط پروژه‌های میزبان Android و web در مخزن وجود دارند. پروژه‌های میزبان iOS، Linux، macOS و Windows اضافه نشده‌اند.

### ۲. کلون کردن مخزن

<div dir="ltr" align="left">

```bash
git clone https://github.com/mehrshadkhv/Drum_Music.git drum_music
cd drum_music
```

</div>

**حروف بزرگ و کوچک در مسیر assetها:** مسیر پوشه‌های صدا و تصویر در Git فعلاً به‌صورت `Assets/Sounds/` و `Assets/Images/` ثبت شده، اما `pubspec.yaml` و `lib/main.dart` از مسیرهای حروف کوچک استفاده می‌کنند. در ویندوز ممکن است این تفاوت به چشم نیاید، ولی روی فایل‌سیستم حساس به بزرگی و کوچکی حروف، نام‌ها باید با کد یکسان باشند. اگر مسیرهای ثبت‌شده در نسخه‌ای که کلون کرده‌اید هنوز حروف بزرگ دارند، قبل از اجرا آن‌ها را اصلاح کنید:

<div dir="ltr" align="left">

```bash
mkdir -p assets
git mv Assets/Images assets-images-case-tmp
git mv assets-images-case-tmp assets/images
git mv Assets/Sounds assets-sounds-case-tmp
git mv assets-sounds-case-tmp assets/sounds
```

</div>

نام‌های موقت باعث می‌شوند تغییر نامی که فقط در بزرگی و کوچکی حروف تفاوت دارد، در ویندوز هم انجام شود. این دستورها تغییر نام assetها را stage می‌کنند؛ اگر مسیرهای ثبت‌شده قبلاً اصلاح شده‌اند، این مرحله را رد کنید. درخت پروژهٔ بالا مسیرهای حروف کوچک مورد انتظار برنامه را نشان می‌دهد.

### ۳. نصب وابستگی‌ها

<div dir="ltr" align="left">

```bash
flutter pub get
```

</div>

نیازی به API Key، فایل محیطی، سرویس بک‌اند یا دستور تولید کد نیست. پوشه‌های asset مورد استفادهٔ برنامه از قبل در `pubspec.yaml` ثبت شده‌اند.

### ۴. اجرای برنامه

شبیه‌ساز اندروید را روشن کنید یا گوشی را وصل کنید، سپس دستورهای زیر را اجرا کنید:

<div dir="ltr" align="left">

```bash
flutter devices
flutter run
```

</div>

برای اجرای نسخهٔ وب در Chrome:

<div dir="ltr" align="left">

```bash
flutter run -d chrome
```

</div>

برای امتحان کردن شش صدا، روی نیمهٔ چپ یا راست هر ردیف صفحه بزنید. تصویر درام فقط پس‌زمینه است؛ ناحیه‌های لمس همان شبکه‌ای هستند که بالاتر توضیح داده شد.

### ۵. بررسی کد

<div dir="ltr" align="left">

```bash
flutter analyze
```

</div>

پکیج `flutter_test` برای اضافه کردن تست در دسترس است. در درخت کاری فعلی فایل تستی وجود ندارد، بنابراین این README ادعای پاس شدن مجموعهٔ تست‌ها را ندارد.

## آمار زبان‌های مخزن در GitHub

فایل `.gitattributes` پوشه‌های میزبان پلتفرم‌های Flutter را با `linguist-vendored` و فایل‌های Dart تولیدشده، یعنی `*.g.dart` و `*.freezed.dart`، را با `linguist-generated` علامت می‌زند. در نتیجه، کدهای پیش‌فرض پلتفرم‌ها و کدهای تولیدشده وارد محاسبهٔ زبان‌های مخزن نمی‌شوند و کد Dart نوشته‌شده برای برنامه در آمار دیده می‌شود. این قواعد فایلی را حذف نمی‌کنند و روی build اثری ندارند؛ GitHub بعد از commit و push تغییرات آن‌ها را اعمال می‌کند.

## مجوز

پروژه با [مجوز MIT](LICENSE) منتشر شده است. حق نشر © ۲۰۲۶ متعلق به مهرشاد خداویردی‌زاده (Mehrshad Khodavirdizadeh) است.

</div>
