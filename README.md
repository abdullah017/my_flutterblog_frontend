# my_blogapp_frontend

A Flutter Blog App for abdullahtas.dev

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## PACKAGE

### TR Kullanılan Paketler

| **Paket**                      | **Açıklama**                                                                                         |
|--------------------------------|------------------------------------------------------------------------------------------------------|
| `get: ^4.6.5`                   | State management, dependency injection ve route management çözümleri sunan Flutter için GetX paketinin bir parçasıdır. |
| `get_storage`                  | GetX tarafından sağlanan basit anahtar-değer depolama çözümü.                                       |
| `graphql_flutter: ^5.1.2`      | Flutter için bir GraphQL istemcisi; GraphQL API'leriyle etkileşim kurmanıza olanak tanır.            |
| `flutter_quill`                | Flutter için zengin metin editörü ve metin formatlama kütüphanesi.                                   |
| `image_picker`                 | Flutter uygulamalarında galeriden veya kameradan görüntü seçmek için kullanılan bir eklenti.          |
| `fl_chart`                     | Çeşitli türlerde grafikler oluşturmak için Flutter için bir grafik kütüphanesi.                      |
| `another_flushbar`             | Özelleştirilebilir flushbar bildirimleri göstermek için kullanılan bir paket.                        |
| `flutter_screenutil`           | Ekran ve yazı boyutunu uyarlamak için kullanılan bir Flutter eklentisi.                              |
| `dartz`                        | Dart için fonksiyonel programlama araçları sunar.                                                   |
| `flutter_dotenv: ^5.1.0`       | `.env` dosyasından ortam değişkenlerini Dart'ın ortam değişkenlerine yükler.                        |
| `cached_network_image: ^3.4.1` | Flutter'da ağ üzerinden görüntü yüklemek ve önbelleğe almak için kullanılan bir kütüphane.            |
| `flutter_html`                 | HTML içeriğini Flutter uygulamalarında render etmek için kullanılan bir paket.                      |
| `equatable`                    | Dart nesnelerinde değer eşitliğini basitleştiren bir paket.                                        |
| `webview_flutter`              | Flutter uygulamalarında yerel WebView kullanarak web içeriğini gömmenizi sağlar.                     |
| `url_launcher`                 | URL'leri tarayıcıda veya diğer uygulamalarda başlatmak için kullanılan bir Flutter eklentisi.       |
| `flutter_linkify`              | Metindeki URL'leri tıklanabilir bağlantılara dönüştürmek için kullanılan bir paket.                   |
| `flutter_staggered_grid_view: ^0.4.0` | Flutter için kademeli (staggered) grid view sağlayan bir paket.                                |
| `google_fonts`                 | Google Fonts'tan fontları kolayca kullanmanızı sağlayan bir Flutter paketi.                         |
| `intl: ^0.19.0`                | Dart ve Flutter için uluslararasılaştırma ve yerelleştirme olanakları sağlar.                        |
| `ionicons: ^0.2.2`              | Flutter için Ionicons ikon setini sağlayan bir paket.                                              |
| `animated_text_kit: ^4.2.2`     | Animasyonlu metin efektleri oluşturmak için kullanılan bir Flutter paketi.                           |




### EN Used Packages

| **Package**                           | **Description**                                                                                                 |
|---------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| `get: ^4.6.5`                          | A comprehensive solution for state management, dependency injection, and route management in Flutter apps.    |
| `get_storage`                          | A simple key-value storage solution provided by GetX.                                                          |
| `graphql_flutter: ^5.1.2`              | A GraphQL client for Flutter, enabling interaction with GraphQL APIs.                                         |
| `flutter_quill`                        | A rich text editor and text formatting library for Flutter.                                                    |
| `image_picker`                         | A plugin for selecting images from the gallery or camera in Flutter applications.                              |
| `fl_chart`                             | A charting library for creating various types of charts in Flutter.                                           |
| `another_flushbar`                     | A customizable flushbar notification package for Flutter.                                                      |
| `flutter_screenutil`                   | A Flutter plugin for adapting screen and font sizes to different screen dimensions.                            |
| `dartz`                                | Provides functional programming tools for Dart.                                                                |
| `flutter_dotenv: ^5.1.0`               | Loads environment variables from a `.env` file into Dart's environment variables.                               |
| `cached_network_image: ^3.4.1`         | A library for loading and caching network images in Flutter.                                                   |
| `flutter_html`                         | A package to render HTML content in Flutter applications.                                                      |
| `equatable`                            | Simplifies value equality in Dart objects.                                                                       |
| `webview_flutter`                      | Embeds web content into Flutter applications using a native WebView.                                           |
| `url_launcher`                         | A plugin for launching URLs in the browser or other applications.                                              |
| `flutter_linkify`                      | Converts URLs in text to clickable links in Flutter.                                                            |
| `flutter_staggered_grid_view: ^0.4.0`  | A package providing staggered grid views for Flutter.                                                          |
| `google_fonts`                         | Allows easy use of Google Fonts in Flutter applications.                                                        |
| `intl: ^0.19.0`                        | Provides internationalization and localization facilities, including date and number formatting.               |
| `ionicons: ^0.2.2`                      | A package providing Ionicons icon set for Flutter.                                                              |
| `animated_text_kit: ^4.2.2`             | A collection of animated text widgets for Flutter.                                                               |




### **Gelecek Özellikler (Future Features)**

1. **Yorum Sistemi (Comment System)**
   - **Açıklama:** Kullanıcıların yazılara yorum yapmasını ve etkileşimde bulunmasını sağlar.
   - **Description:** Allows users to comment on posts and interact with each other.

2. **Beğeni ve Paylaşım (Like and Share)**
   - **Açıklama:** Kullanıcıların yazıları beğenmesini ve sosyal medyada paylaşmasını teşvik eder.
   - **Description:** Encourages users to like posts and share them on social media platforms.

3. **Kategoriler ve Etiketler (Categories and Tags)**
   - **Açıklama:** Yazıları kategorilere ve etiketlere ayırarak düzenlemeyi kolaylaştırır.
   - **Description:** Facilitates organizing posts by categories and tags for easier navigation.

4. **Arama ve Filtreleme (Search and Filtering)**
   - **Açıklama:** Kullanıcıların istedikleri içerikleri kolayca bulmalarını sağlar.
   - **Description:** Enables users to easily find desired content through search and filtering options.

5. **Bildirimler (Notifications)**
   - **Açıklama:** Kullanıcıları önemli olaylar hakkında bilgilendirir.
   - **Description:** Notifies users about important events such as new comments, likes, or follows.

6. **Çoklu Dil Desteği (Multilanguage Support)**
   - **Açıklama:** Uygulamanızın birden fazla dilde kullanılabilmesini sağlar.
   - **Description:** Allows the application to be used in multiple languages for a wider audience.

7. **Offline Desteği (Offline Support)**
   - **Açıklama:** Kullanıcıların internet bağlantısı olmadığında bile uygulamayı kullanabilmelerini sağlar.
   - **Description:** Enables users to access and interact with the app even without an internet connection.

8. **Performans İyileştirmeleri (Performance Enhancements)**
   - **Açıklama:** Uygulamanızın hızını ve verimliliğini artırır.
   - **Description:** Improves the speed and efficiency of the application for a better user experience.

9. **Mobil Push Bildirimleri (Mobile Push Notifications)**
   - **Açıklama:** Kullanıcıları uygulama içi güncellemeler hakkında bilgilendirir.
   - **Description:** Informs users about in-app updates and activities through push notifications on mobile devices.

10. **Web Push Bildirimleri (Web Push Notifications)**
    - **Açıklama:** Web kullanıcılarını uygulama içi güncellemeler hakkında bilgilendirir.
    - **Description:** Notifies web users about in-app updates and activities through web push notifications.

---

### **Future Features**

1. **Comment System**
   - **Description:** Allows users to comment on posts and interact with each other.

2. **Like and Share**
   - **Description:** Encourages users to like posts and share them on social media platforms.

3. **Categories and Tags**
   - **Description:** Facilitates organizing posts by categories and tags for easier navigation.

4. **Search and Filtering**
   - **Description:** Enables users to easily find desired content through search and filtering options.

5. **Notifications**
   - **Description:** Notifies users about important events such as new comments, likes, or follows.

6. **Multilanguage Support**
   - **Description:** Allows the application to be used in multiple languages for a wider audience.

7. **Offline Support**
   - **Description:** Enables users to access and interact with the app even without an internet connection.

8. **Performance Enhancements**
   - **Description:** Improves the speed and efficiency of the application for a better user experience.

9. **Mobile Push Notifications**
   - **Description:** Informs users about in-app updates and activities through push notifications on mobile devices.

10. **Web Push Notifications**
    - **Description:** Notifies web users about in-app updates and activities through web push notifications.




## SS FOR WEB

<img width="1434" alt="Ekran Resmi 2024-10-13 01 14 39" src="https://github.com/user-attachments/assets/4319ccbb-f71d-47ac-a32f-2f746b426e38">

<img width="1434" alt="Ekran Resmi 2024-10-13 01 14 46" src="https://github.com/user-attachments/assets/fc854318-658a-4e5a-be87-0105242032f6">

<img width="1434" alt="Ekran Resmi 2024-10-13 01 15 06" src="https://github.com/user-attachments/assets/ba378f95-6bd8-47bc-b50d-1e88d9531658">

<img width="1434" alt="Ekran Resmi 2024-10-13 01 15 15" src="https://github.com/user-attachments/assets/46735757-2530-4da8-a0b4-720d1043e4f3">


## SS FOR MOBILE

<p float="left">
 <img width="400" height="1000" alt="Ekran Resmi 2024-10-13 01 14 39" src="https://github.com/user-attachments/assets/6a68aed6-6bc2-4882-84c8-1fa9962a8543">
  <img width="400" height="1000" alt="Ekran Resmi 2024-10-13 01 14 39" src="https://github.com/user-attachments/assets/571cfdfe-f48a-43b1-adb2-a0a30d0c91b3">
 <img width="400" height="1000" alt="Ekran Resmi 2024-10-13 01 14 39" src="https://github.com/user-attachments/assets/b5340afa-e0c9-4ff4-8d48-b5daeeb877c8">
   <img width="400" height="1000" alt="Ekran Resmi 2024-10-13 01 14 39" src="https://github.com/user-attachments/assets/08837ac8-f6ba-476e-9e1c-aea420607671">
</p>


