# eVaga Mobile 📱⚖️

**eVaga Mobile** je mobilna aplikacija razvijena u Flutter-u koja omogućava praćenje težine u realnom vremenu preko WebSocket konekcije sa elektronskim vagama. Aplikacija je dizajnirana za jednostavno i intuitivno korišćenje u industrijskim i komercijalnim okruženjima.

## ✨ Karakteristike

- 📊 **Praćenje težine u realnom vremenu** - Kontinuirano prikazivanje trenutne težine
- 🌐 **WebSocket konekcija** - Brza i pouzdana komunikacija sa hardverskim vagama
- 📱 **Responsive dizajn** - Prilagođava se portret i landscape orijentaciji
- 🎨 **Moderna UI** - Elegantan dizajn sa profesionalnom color shemom
- ⚡ **Brza povezivost** - Trenutno povezivanje i praćenje stanja konekcije
- 🛡️ **Error handling** - Pouzdano rukovanje greškama i prekidima konekcije

## 🛠️ Tehnologije

- **Flutter** (SDK ^3.9.0)
- **Dart** programming language
- **WebSocket komunikacija** (web_socket_channel ^3.0.3)
- **Network info** (network_info_plus ^7.0.0)
- **Material Design 3** UI framework

## 📋 Preduslovi

Pre pokretanja aplikacije, uverite se da imate instaliran:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (verzija 3.9.0 ili novija)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code sa Flutter ekstenzijama
- Android emulator ili fizički uređaj za testiranje

## 🚀 Instalacija

1. **Klonirajte repozitorijum:**

   ```bash
   git clone https://github.com/LakishaDev/eVagaMobile.git
   cd eVagaMobile
   ```

2. **Instalirajte dependencies:**

   ```bash
   flutter pub get
   ```

3. **Pokrenite aplikaciju:**
   ```bash
   flutter run
   ```

## ⚙️ Konfiguracija

### WebSocket Server

Aplikacija se povezuje na WebSocket server na adresi `ws://10.0.0.155:8080`. Da biste promenili adresu servera:

1. Otvorite fajl `lib/widgets/emitovanje_tezine.dart`
2. Pronađite liniju:
   ```dart
   channel = IOWebSocketChannel.connect('ws://10.0.0.155:8080');
   ```
3. Zamenite IP adresu sa adresom vašeg servera

### Ikone aplikacije

Aplikacija koristi custom ikone definisane u `flutter_launcher_icons.yaml`. Da biste promenili ikone:

1. Zamenite `assets/icon/icon.png` sa vašom ikonom
2. Pokrenite:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

## 📖 Korišćenje

1. **Pokretanje aplikacije** - Otvorite aplikaciju na vašem mobilnom uređaju
2. **Povezivanje sa vagom** - Pritisnite "+" dugme u gornjem desnom uglu za povezivanje
3. **Praćenje težine** - Trenutna težina će se prikazivati u centralnom delu ekrana
4. **Status konekcije** - Aplikacija prikazuje status konekcije (povezan, povezuje se, greška, itd.)

### Status indikatori

- **Povezan** ✅ - Uspešno povezano sa vagom
- **Povezuje se** 🔄 - U procesu povezivanja
- **Nije povezan** ❌ - Nema konekcije
- **Greška** ⚠️ - Greška u komunikaciji

### Specijalni prikazi

- **PREOPTEREĆENJE** - Kada je težina veća od maksimalne nosivosti vage
- **VAGA U MINUSU** - Kada vaga pokazuje negativne vrednosti
- **---** - Početno stanje pre povezivanja

## 🏗️ Arhitektura projekta

```
lib/
├── main.dart                 # Entry point aplikacije
├── models/
│   └── status_konekcije.dart # Model za status WebSocket konekcije
├── screens/
│   └── pocetna.dart         # Glavni ekran aplikacije
└── widgets/
    ├── emitovanje_tezine.dart    # Widget za WebSocket komunikaciju
    └── trenutna_tezina.dart      # Widget za prikaz trenutne težine
```

### Ključne komponente

- **PocetnaEkran** - Glavni screen sa app bar-om i osnovnim layout-om
- **TrenutnaTezina** - Kontejner za prikaz trenutne težine
- **EmitovanjeTezine** - Handles WebSocket komunikaciju i parsing podataka
- **StatusKonekcije** - Enum za različita stanja konekcije

## 🎨 Design System

Aplikacija koristi custom Material Design 3 temu sa:

- **Primarna boja**: `#2E5D58` (tamno zelena)
- **Sekundarna boja**: `#C68642` (braon akcenat)
- **Background**: `#A8C8A2` (pastelna zelena)
- **Surface**: `#CBCFBB` (svetlo bež)
- **Font**: Poppins (body), RobotoMono (display)

## 🧪 Testiranje

Pokrenite unit testove:

```bash
flutter test
```

Pokrenite widget testove:

```bash
flutter test test/widget_test.dart
```

## 📱 Build za produkciju

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🐛 Troubleshooting

### Česti problemi:

1. **WebSocket konekcija ne radi**:

   - Proverite da li je server pokrenut na zadatoj IP adresi
   - Uverite se da ste na istoj mreži kao server
   - Proverite firewall postavke

2. **Aplikacija se ne pokreće**:

   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

3. **Build greške**:
   - Uverite se da je Flutter SDK najnovija verzija
   - Proverite da li su svi dependencies kompatibilni

## 🤝 Doprinos

Doprinos projektu je dobrodošao! Molimo:

1. Fork-ujte repozitorijum
2. Kreirajte feature branch (`git checkout -b feature/nova-funkcionalnost`)
3. Commit-ujte promene (`git commit -m 'Dodaje novu funkcionalnost'`)
4. Push na branch (`git push origin feature/nova-funkcionalnost`)
5. Otvorite Pull Request

## 📄 Licenca

Ovaj projekat je licenciran pod MIT licencom. Vidite [LICENSE](LICENSE) fajl za detalje.

## 📞 Kontakt

**Razvojni tim:**

- GitHub: [@LakishaDev](https://github.com/LakishaDev)
- Email: [lakishadev](lazar.cve@gmail.com)

## 🙏 Zahvalnice

- Flutter tim za odličan framework
- Dart tim za programski jezik
- Svi koji su doprineli open-source bibliotekama korišćenim u projektu

---

**eVaga Mobile** - Vaš pouzdani partner za digitalno merenje! ⚖️✨
