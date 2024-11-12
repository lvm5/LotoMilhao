//
//  Ads.swift
//  LotoMilhao
//
//  Created by Leandro Morais on 12/11/24.
//

//import GoogleMobileAds
//import SwiftUI

//struct Ads: UIViewRepresentable {
//    let adSize: GADAdSize
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator()
//    }
//    
//    func makeUIView(context: Context) -> GADBannerView {
//        let bannerView = GADBannerView(adSize: adSize)
//        bannerView.adUnitID = "ca-app-pub-7697234866802757/2322005105"  // Substitua pelo seu Ad Unit ID
//        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
//        bannerView.delegate = context.coordinator
//        bannerView.load(GADRequest())
//        return bannerView
//    }
//    
//    func updateUIView(_ uiView: GADBannerView, context: Context) {
//        // Atualizações caso precise recarregar o anúncio ou modificar propriedades
//    }
//    
//    // Coordinator para lidar com eventos do GADBannerView
//    class Coordinator: NSObject, GADBannerViewDelegate {
//        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
//            print("Banner carregado com sucesso.")
//        }
//        
//        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//            print("Falha ao carregar o banner: \(error.localizedDescription)")
//        }
//        
//        func bannerViewDidRecordClick(_ bannerView: GADBannerView) {
//            print("Banner clicado.")
//        }
//        
//        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//            print("Banner vai apresentar tela completa.")
//        }
//        
//        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//            print("Tela completa do banner será fechada.")
//        }
//        
//        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//            print("Tela completa do banner fechada.")
//        }
//    }
//}


import GoogleMobileAds
import SwiftUI

struct NativeAdView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> GADNativeAdView {
        // Configura a visualização nativa do anúncio (Native Ad View)
        let nativeAdView = GADNativeAdView()
        
        // Configuração dos elementos (exemplo de título e imagem principal)
        let mediaView = GADMediaView()
        nativeAdView.mediaView = mediaView
        
        let headlineView = UILabel()
        nativeAdView.headlineView = headlineView

        // Carregamento do anúncio com GADAdLoader
        let adLoader = GADAdLoader(adUnitID: "ca-app-pub-7697234866802757/2322005105", // Substitua pelo seu ID
                                   rootViewController: UIApplication.shared.windows.first?.rootViewController,
                                   adTypes: [.native],
                                   options: nil)
        
        adLoader.delegate = context.coordinator
        adLoader.load(GADRequest())
        
        // Adiciona os elementos na visualização principal
        nativeAdView.addSubview(mediaView)
        nativeAdView.addSubview(headlineView)
        
        return nativeAdView
    }

    func updateUIView(_ uiView: GADNativeAdView, context: Context) {
        // Atualização da visualização do anúncio, caso necessário
    }

    class Coordinator: NSObject, GADNativeAdLoaderDelegate, GADNativeAdDelegate {
        func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
            guard let nativeAdView = adLoader.delegate as? GADNativeAdView else { return }
            
            // Configura o NativeAdView com dados do anúncio recebido
            (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
            nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
            
            print("Anúncio Nativo carregado com sucesso.")
        }

        func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
            print("Falha ao carregar o anúncio nativo: \(error.localizedDescription)")
        }
    }
}
