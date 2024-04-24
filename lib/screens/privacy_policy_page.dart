import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),

      body:const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
           child:  SingleChildScrollView(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Comprehensive Privacy Policy Statement:\n      Welcome to Central Pay Finance Technology Private Limited. This Privacy Policy elucidates the intricate details surrounding the collection, processing, and utilization of personal information when you engage with our diverse range of services and explore our digital footprint, predominantly encapsulated within the confines of our website (www.centralpay.com).\n\n Dynamic Policy Updates: \n      In our steadfast commitment to maintaining transparency and adhering to the highest standards of data protection, Central Pay reserves the prerogative to periodically review, revise, and refine this Privacy Policy. Amendments, should they transpire, will be diligently reflected on our website, with the date stamp of the latest revision conspicuously displayed atop the page. Continuation of your interaction with Central Pay's services or digital interfaces subsequent to such modifications implicitly signifies your concurrence and acquiescence to the revised terms and conditions stipulated herein. \n\n Nuanced Data Collection Practices:\n      When you embark on your journey of availing Central Pay's spectrum of services, entailing the acquisition of a line of credit through our platform or affiliated merchant portals, an extensive array of personal information is meticulously collated. This repository encompasses a myriad of identifiers, including but not limited to your nomenclature, electronic mail address, mobile telephony digits, Permanent Account Number (PAN), and the geographical coordinates of your domicile. Augmenting this cache, supplementary data may be requisitioned to facilitate the authentication of your identity and the expeditious adjudication of your creditworthiness.\n\nMultifaceted Utilization of Personal Information:\n      Central Pay deploys the harvested trove of personal data for multifarious purposes, delineating an expansive gamut of functionalities. These encompass the indispensably mandatory credit reporting obligations mandated by regulatory authorities, further disseminated to our esteemed partner banking institutions instrumental in the seamless provisioning of the line of credit. Concurrently, an intricate surveillance mechanism is invoked to monitor the contours of your interaction with Central Pay's digital ecosystem and the affiliated merchant interfaces, thereby facilitating data-driven insights and the orchestration of tailored services conducive to optimizing user experiences.\n\nAugmented Data Sourcing Ecosystem:\n      Supplementing our internally sourced data reservoirs, Central Pay actively engages with a network of third-party intermediaries, encompassing identity verification consortiums and credit reporting agencies, to augment the depth and breadth of our data analytics framework. This synergistic alliance fortifies our capacity to scrutinize, analyze, and discern nuanced patterns embedded within the labyrinthine tapestry of user data, thereby fortifying our propensity to render informed credit assessments and decisively adjudicate upon creditworthiness.\n\nIntricacies of Mobile Application Data Collection:\n      Delving into the realm of our mobile application, a labyrinth of data collection mechanisms is meticulously orchestrated to ensure the precise calibration of our credit risk assessment algorithms and the expeditious facilitation of Know Your Customer (KYC) procedures. Metadata pertaining to installed applications, coupled with granular device telemetry encompassing the OS version, unique device identifiers, and an amalgamation of permissions, inclusive of but not limited to camera, microphone, and storage access, constitute the fulcrum of our data ingestion pipeline.\n\nDiscerning the Role of Cookies and Data Retention:\n      The omnipresence of cookies, seamlessly integrated within our digital fabric, serve as the veritable linchpin anchoring our marketing endeavors and the relentless pursuit of enhancing user experiences. The tenure of data retention is contingent upon the chronology of account activation, interwoven with the intricate web of legal obligations, dispute resolution imperatives, and the overarching need to enforce contractual agreements.\n\nPermutations of Data Sharing:\n      Central Pay, in alignment with the dictums of regulatory frameworks and propelled by the exigencies of operational exigencies, orchestrates a nuanced exchange of data with a heterogenous consortium of stakeholders, spanning partner banking institutions, merchants, vendors, and regulatory entities. This data omnium-gatherum, fortified by the scaffolds of data security agreements, underpins our commitment to fostering a culture of data stewardship and preserving the sanctity of user privacy.\n\nRescinding the Vestiges of Consent:\n      Empowering users with the volition to discern, deliberate, and dissent, Central Pay accords due reverence to the cardinal principles of data sovereignty. Users, ensconced within the sacrosanct precincts of their volition, are vested with the prerogative to rescind consent for the ongoing collection and processing of personal data. Notwithstanding, it's imperative to acknowledge that the annulment of consent or the peremptory deletion of accounts may bear consequential ramifications vis-a-vis the continuity of service provision.\n\nEternal Vigilance, Uncompromising Security:\n      At the helm of Central Pay's operational matrix lies an unassailable bulwark of security safeguards, meticulously calibrated to shield the sanctity of personal information from the encroachments of malevolent entities and nefarious actors. A tapestry of administrative, technical, and physical safeguards",
                        style:TextStyle(
        
                        ) ,
                        ),
                      )
                    ],
                  ),
                )
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}