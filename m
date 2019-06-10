Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7BC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F300720859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSr6jecz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbfFJGwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:52:50 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:19131
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387614AbfFJGwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pIy+Lu+QiE84DSAFluruY04JqyYl8Dom0hWUDAd8EU=;
 b=jSr6jeczeMblWDlrDnolgYHs3i7bD0cTna73LBV67twgMAtsGTaVcwW+bnG+YAAhN6W4de9ty8A74FEZiAmnnQWDWA5vZhXHT0fadV7KHVFNxXf7VVRk9fGBxWPKzoNniJytOMTZ8YSkOrgnOHtV/srsewYWylW0nV3WZiyfFC0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6079.eurprd04.prod.outlook.com (20.179.25.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Mon, 10 Jun 2019 06:52:44 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9891:c973:a697:3c7b]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9891:c973:a697:3c7b%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 06:52:44 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
Thread-Topic: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD
 controller.
Thread-Index: AQHVG4YPzgz12rGdtU+X64LQwj+FpKaOii2AgAEWlQCAAE43gIAEbGOAgAAQjCCAAA1RAIAAAJmw
Date:   Mon, 10 Jun 2019 06:52:44 +0000
Message-ID: <VI1PR04MB5327D364DC5930C3A954AA6A8B130@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
 <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
 <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
 <BYAPR07MB470965B3CBCB58E1C7B1253FDD130@BYAPR07MB4709.namprd07.prod.outlook.com>
 <VI1PR04MB532797447E56454C0E2D3F668B130@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <BYAPR07MB470915AB1D833EC1CEA5C8D7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB470915AB1D833EC1CEA5C8D7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d75e7d6-16e5-4b77-54a5-08d6ed703da5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6079;
x-ms-traffictypediagnostic: VI1PR04MB6079:
x-microsoft-antispam-prvs: <VI1PR04MB6079EE3E3275F15532D48C378B130@VI1PR04MB6079.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(3846002)(4326008)(6116002)(86362001)(74316002)(476003)(6436002)(486006)(446003)(54906003)(55016002)(316002)(5660300002)(25786009)(11346002)(26005)(68736007)(7416002)(44832011)(110136005)(71200400001)(71190400001)(9686003)(76116006)(229853002)(53936002)(8676002)(33656002)(305945005)(2501003)(73956011)(2906002)(7736002)(66556008)(14454004)(64756008)(66446008)(52536014)(102836004)(76176011)(66946007)(6246003)(99286004)(81166006)(81156014)(478600001)(66476007)(8936002)(186003)(6506007)(66066001)(7696005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6079;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UAg5V8Rf7jkmeEwLQsgXif9rYgMIJrVLSzdAQGErNH2dl9p8ON0wVNeVSrl5Qa/gysuNsADmPQUwRMJoi5U0QmLjN9Wh0PewwEFJI6CMZypOGu3XjrOuE1BaFdLRf3e1ig1DcGu0MwkueBgPXmkiioxHFbtrRTnj3fpGw1rEWOJLvKJc/DX+45ymsOaA5QR/tpGUsqNWKZ3cD21O7VR3RhnK5wB2ZVpgWGgx8Gy6sQBjBaCm2y4af7v9K34sl+Kfx4NRijmlGTmaZcHBIn9pEp01yaieh5PlLFWGHKEmN0ya0f/pFMpsrFkJkx/xNkPRxjk3KJuqADW4RCDapV2VNCh6IGg+TsGTAYaxl9Yyz304162yrJ+C8H2q833oar/OTaZogjQDp34a2RIkI+RDt/gpGp/R5cTV4PcI2pY/3Ys=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d75e7d6-16e5-4b77-54a5-08d6ed703da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 06:52:44.4589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peter.chen@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQogDQo+ID4+ICAtIHJlZy1uYW1lcyAtIHJlZ2lzdGVyIG1lbW9yeSBhcmVhIG5hbWVzOg0KPiA+
PiAgICAgICAgICJ4aGNpIiAtIGZvciBIT1NUIHJlZ2lzdGVycyBzcGFjZQ0KPiA+PiAgICAgICAg
ICJkZXYiIC0gZm9yIERFVklDRSByZWdpc3RlcnMgc3BhY2UNCj4gPj4gICAgICAgICAib3RnIiAt
IGZvciBPVEcvRFJEIHJlZ2lzdGVycyBzcGFjZQ0KPiA+PiAgLSBjb21wYXRpYmxlOiBTaG91bGQg
Y29udGFpbjoNCj4gPj4gICAgICAgICAiY2Rucyx1c2IzLTEuMC4wIiAtIGZvciAweDAwMDI0NTAy
IGNvbnRyb2xsZXIgdmVyc2lvbg0KPiA+PiAgICAgICAgICJjZG5zLHVzYjMtMS4wLjEiIC0gZm9y
IDB4MDAwMjQ1MDkgY29udHJvbGxlciB2ZXJzaW9uDQo+ID4+ICAgICAgICAgImNkbnMsdXNiMy0x
LjAuMiIgLSBmb3IgMHgwMDAyNDUwQyBjb250cm9sbGVyIHZlcnNpb24NCj4gPj4gICAgICAgICAi
Y2Rucyx1c2IzLTEuMC4zIiAtIGZvciAweDAwMDI0NTBkIGNvbnRyb2xsZXIgdmVyc2lvbg0KPiA+
DQo+ID5JZiB0aGUgdmFsdWUgY2FuIGJlIHJlYWQgZnJvbSByZWdpc3Rlciwgd2h5IHdlIHN0aWxs
IG5lZWQgZGlmZmVyZW50IGNvbXBhdGlibGVzPw0KPiBXZSBkb24ndCBuZWVkIGl0LiBJIGxlZnQg
aXQgb25seSAgYXMgaW5mb3JtYXRpb24gdGhhdCBjZG5zMyBjb250cm9sbGVyIGV4aXN0IGluIDQg
ZGlmZmVyZW50DQo+IHZlcnNpb24uDQo+IA0KDQpTbywgeW91IHdpbGwgaGF2ZSBvbmx5IG9uZSBj
b21wYXRpYmxlIGF0IGJvdGggZHJpdmVyIGFuZCBiaW5kaW5nIGRvYywgZWcgImNkbnMsIHVzYjMi
Pw0KQW5kIHlvdSBtYXkgbW92ZSB0aGUgY29udHJvbGxlciBpbmZvcm1hdGlvbiBpbnRvIHRoZSBk
cml2ZXIsIGFuZCBoYXZlIGEgTUFDUk8gZm9yIGl0Pw0KDQo+ID4+IE1heWJlIEkgc2hvdWxkIGFk
ZCBhbHNvIHNvbWV0aGluZyBmb3IgdXNiMl9waHkgaW4gZHQtYmluZGluZyBhbmQgaW4gZHJpdmVy
ID8NCj4gPj4NCj4gPg0KPiA+VGhlIFBIWSBkcml2ZXIgaXMgbG9jYXRlZCBhdDogZHJpdmVycy9w
aHkvY2FkZW5jZS9waHktY2FkZW5jZS1zaWVycmEuYy4NCj4gPldpbGwgd2UgbmVlZCBhbm90aGVy
IG9uZSBmb3IgVVNCMiBQSFk/DQo+IA0KPiBBcyBJIGtub3cgc2llcnJhIHBoeSBpcyBVU0IzLjAg
cGh5Lg0KPiBBbHNvIEkga25vdyB0aGF0IHdlIGhhdmUgdG9yZW50IHBoeSBkcml2ZXIgZm9yIDIu
MC4gSXQncyByZWFkeSBidXQgaXMgaGFzIG5vdCB5ZXQgaW4NCj4ga2VybmVsLg0KPiBTbyBJIGFz
c3VtZSB0aGF0IEkgc2hvdWxkIGNoYW5nZQ0KPiAgICAgICAgICAgICAgIHBoeXMgPSA8JnVzYjNf
cGh5PjsNCj4gICAgICAgICAgICAgICBwaHktbmFtZXMgPSAiY2RuczMsdXNicGh5IjsNCj4gDQo+
IHdpdGg6DQo+ICAgICAgICAgICAgICAgICAgcGh5cyA9IDwmdXNiMl9waHk+LCA8JnVzYjNfcGh5
PjsNCj4gICAgICAgICAgICAgICAgICBwaHktbmFtZXMgPSAiY2RuczMsdXNicGh5MiIsICJjZG5z
Myx1c2JwaHkzIjsNCj4gDQogDQpZZXMsIEkgdGhpbmsgc28uDQoNClBldGVyDQo=
