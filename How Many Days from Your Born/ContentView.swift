//
//  ContentView.swift
//  How Many Days from Your Born
//
//  Created by Fırat Sarar on 29.01.2026.
//

import SwiftUI

struct ContentView: View {
    @State var dogumTarihi = Date()
    @State private var katilinanOlaylar: [String] = []
    @State private var sonuc: Int = 0
    
    struct tarihiOlay {
        let yil: Int
        let olay: String
    }
    
    let dunyaGundemi = [
        1919: "Milli Mücadele başladı: Atatürk Samsun'a çıktı.",
        1920: "Ankara'da Türkiye Büyük Millet Meclisi (TBMM) açıldı.",
        1923: "Cumhuriyet ilan edildi, Türkiye Devleti resmen kuruldu.",
        1933: "Türkiye'de Üniversite Reformu yapıldı.",
        1934: "Soyadı Kanunu kabul edildi; kadınlara seçme ve seçilme hakkı verildi.",
        1938: "Türkiye Cumhuriyeti'nin kurucusu Mustafa Kemal Atatürk vefat etti.",
        1945: "İkinci Dünya Savaşı sona erdi; Türkiye, Birleşmiş Milletler kurucu üyesi oldu.",
        1950: "Türkiye'de çok partili dönemde ilk demokratik seçimler yapıldı.",
        1952: "Türkiye, NATO'ya (Kuzey Atlantik Antlaşması Örgütü) üye oldu.",
        1960: "Türkiye'de 27 Mayıs askeri darbesi gerçekleşti.",
        1963: "Türkiye ile Avrupa Ekonomik Topluluğu arasında Ankara Anlaşması imzalandı.",
        1969: "Apollo 11 Ay'a iniş yaptı; insanoğlu ilk kez Ay'a ayak bastı.",
        1974: "Kıbrıs Barış Harekatı gerçekleştirildi.",
        1980: "Türkiye'de 12 Eylül askeri darbesi yaşandı.",
        1983: "Turgut Özal dönemi başladı, Türkiye ekonomisinde dışa açılma süreci hızlandı.",
        1992: "Türkiye'nin ilk özel televizyon kanalları yaygınlaşmaya başladı.",
        1996: "Türkiye ile Avrupa Birliği arasında Gümrük Birliği Anlaşması yürürlüğe girdi.",
        1999: "Büyük Marmara Depremi yaşandı; Türkiye AB adaylık statüsü kazandı.",
        2001: "Türkiye tarihinin en büyük ekonomik krizlerinden birini yaşadı.",
        2002: "Türkiye Milli Takımı, Dünya Kupası'nda dünya üçüncüsü oldu.",
        2005: "Türk Lirası'ndan altı sıfır atıldı; Yeni Türk Lirası (YTL) kullanılmaya başlandı.",
        2011: "Suriye iç savaşı başladı, Türkiye'ye büyük bir göç dalgası yöneldi.",
        2013: "Gezi Parkı olayları Türkiye gündemine damga vurdu.",
        2016: "15 Temmuz hain darbe girişimi halkın direnciyle engellendi.",
        2018: "Türkiye, Cumhurbaşkanlığı Hükümet Sistemi'ne resmen geçiş yaptı.",
        2020: "Dünya genelinde COVID-19 pandemisi ilan edildi; sokağa çıkma yasakları başladı.",
        2022: "İngiltere Kraliçesi II. Elizabeth vefat etti; 70 yıllık bir dönem kapandı.",
        2023: "Kahramanmaraş merkezli büyük depremler yaşandı; Cumhuriyetin 100. yılı kutlandı.",
        2024: "Türkiye'nin ilk astronotu Alper Gezeravcı uzaya çıktı.",
        2025: "Yapay zeka asistanları Türkiye'de günlük hayatın ayrılmaz bir parçası oldu.",
        2026: "Senin bu harika Swift uygulaman uygulama mağazalarında yayına girdi!"
    ]
    func hesapla() {
        let takvim = Calendar.current
        
        let suan = Date()
        
        let fark = takvim.dateComponents([Calendar.Component.day], from:dogumTarihi, to:suan)
        if let gunSayisi = fark.day {
            sonuc = gunSayisi
        }
    }
    
    func olaylariGetir() {
        let calendar = Calendar.current
        let dogumYili = calendar.component(.year, from: dogumTarihi)
        let buYil = calendar.component(.year, from: Date())
        
        var geciciListe: [String] = []
        for yil in dogumYili...buYil {
            if let olay = dunyaGundemi[yil] {
                geciciListe.append("\(yil): \(olay)")
            }
        }
        katilinanOlaylar = geciciListe
    }
    
    var body: some View {
        ScrollView {
            VStack { // 1. Her şeyi bu parantez içine alıyoruz
                Text("Doğduğundan beri kaç gün geçti?")
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 50)
                
                VStack(spacing: 16) {
                    Text("Doğum Tarihini Seç")
                        .font(.headline)

                    DatePicker(
                        "",
                        selection: $dogumTarihi,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .labelsHidden().datePickerStyle(.automatic)

                    Button("Hesapla") {
                        hesapla()
                        olaylariGetir()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(24)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .scaleEffect(1.3)

                                
                if sonuc > 0 {
                    Text("Resmen \(sonuc / 365) yaşındasın ve doğduğundan beri \(sonuc) gün geçmiş! Vay be, zaman çok çabuk geçiyor. Hadi doğduğundan beri neler olduğuna bir göz atalım.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    if !katilinanOlaylar.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Senin zaman tünelin")
                                .font(.headline)
                                .padding(.top)
                            ForEach(katilinanOlaylar, id: \.self) { olay in
                                HStack(alignment: .top) {
                                    Image(systemName: "calendar.badge.clock")
                                        .foregroundColor(.blue)
                                    Text(olay)
                                        .font(.callout)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal)
                                Divider()
                            }
                        }
                        .padding()
                    }
                }
            } // 2. VStack burada bitmeli
        } // 3. Body burada bitmeli}
    }
}

#Preview {
    ContentView()
}
