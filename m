Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77558C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1BF2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lv2BXBi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGIDML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:12:11 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:57543
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbfGIDMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCMrM2Uv0R2x9cnwd0wu9DHuztZGyrynfqub8t/rcXQ=;
 b=Lv2BXBi4l1HmnrkZ4qnoERGhZwMGMmPEXlGseI1WJy1J2FjRwIHhFJovUvKGYDaDJHhVhG3hCwKWZHbJcxzdoojQ0EHx1WjAw768McXwWscFOBvx8uFQtktruHhQmHzAFByayKs4yONuIlxab3ZX/vKDmMJDG2Jke2FQvU/TRPg=
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com (20.176.236.27) by
 DB7PR04MB4444.eurprd04.prod.outlook.com (52.135.137.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 03:11:23 +0000
Received: from DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e5ec:7366:aeae:1a21]) by DB7PR04MB5195.eurprd04.prod.outlook.com
 ([fe80::e5ec:7366:aeae:1a21%4]) with mapi id 15.20.2052.019; Tue, 9 Jul 2019
 03:11:23 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Leo Li <leoyang.li@nxp.com>
Subject: RE: [EXT] Re: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
Thread-Topic: [EXT] Re: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
Thread-Index: AQHVBYyobLWsdGwT6EecAzQIJ3ESO6a8LqwAgAXGa2A=
Date:   Tue, 9 Jul 2019 03:11:23 +0000
Message-ID: <DB7PR04MB5195F5731555285623955738E2F10@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190508105755.5881-1-wen.he_1@nxp.com>
 <1562322724.4291.5.camel@pengutronix.de>
In-Reply-To: <1562322724.4291.5.camel@pengutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70ef37af-c237-41c6-414e-08d7041b1f81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4444;
x-ms-traffictypediagnostic: DB7PR04MB4444:
x-microsoft-antispam-prvs: <DB7PR04MB444430E49B72FCD8BDFD5778E2F10@DB7PR04MB4444.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(13464003)(51914003)(199004)(189003)(8676002)(2201001)(11346002)(6436002)(81156014)(4326008)(81166006)(86362001)(476003)(229853002)(6246003)(8936002)(9686003)(446003)(33656002)(316002)(25786009)(486006)(53936002)(55016002)(7696005)(6506007)(99286004)(68736007)(102836004)(53546011)(76176011)(52536014)(14454004)(71190400001)(64756008)(66476007)(66066001)(186003)(3846002)(14444005)(2501003)(66446008)(5660300002)(66556008)(110136005)(26005)(6116002)(256004)(74316002)(73956011)(66946007)(478600001)(76116006)(2906002)(305945005)(71200400001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4444;H:DB7PR04MB5195.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VPR4oXA4J+FY+OBSgreB8Mk3XN52fWL5JnrGU6FpAwAuWFcb8Vh6FtsJqD2Aa1++d3d+4tsUkOy9ecT3OkAr+QNO54Gv/FfJa2gXDTdCNPRJxXkU5xFxEgdfe9TQhMC2kPbphAD6IeUtVBWwNjgMGXtpXXjgY1D2AGjwUNtq9bbTPuKjB0z5YnJte+uTmy/y9s7VXsOGcgcZJEJ7vrjMUwigdlgFPS4Mtt5vrJh0qPfxrQQf+4B76MlUPZvLFu2t7pr90LHJKni5SX4UQPtY+xJjJoqrj15sL0oZnNxpI0PuoZdulwXQHovEzD5ANNLM2gdXcAqnfwRp0C1K+oaFfGoakdsHw6eIwxavueBxBKpsgIZorcatRDBBldNIpQhIILzuVbW3I4q6EcpDBqLgdBLNtdXDzoSlNexbpMAFY9s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ef37af-c237-41c6-414e-08d7041b1f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 03:11:23.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wen.he_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4444
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOeW5tDfmnIg15pelIDE4OjMyDQo+
IFRvOiBXZW4gSGUgPHdlbi5oZV8xQG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBMZW8gTGkgPGxl
b3lhbmcubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFt2MV0gZ3B1OiBpcHUtdjM6
IGFsbG93IHRvIGJ1aWxkIHdpdGggQVJDSF9MQVlFUlNDQVBFDQo+IA0KPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gDQo+IEhpIFdlbiwNCj4gDQo+IE9uIFdlZCwgMjAxOS0wNS0wOCBhdCAxMDo1NiAr
MDAwMCwgV2VuIEhlIHdyb3RlOg0KPiA+IFRoZSBuZXcgTFMxMDI4QSBEUCBkcml2ZXIgY29kZSBj
YXVzZXMgYSBsaW5rIGZhaWx1cmUgd2hlbiBEUk1fSU1YDQo+ID4gYnVpbHQtaW4sIGJ1dCBwbGF0
Zm9ybSBpcyBBUkNIX0xBWUVSU0NBUEU6DQo+ID4NCj4gPiBkcml2ZXJzL2dwdS9kcm0vaW14L2lw
dXYzLWNydGMuYzo1MTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgaXB1X3ByZ19lbmFibGUn
DQo+ID4gZHJpdmVycy9ncHUvZHJtL2lteC9pcHV2My1jcnRjLmM6NTI6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8NCj4gYGlwdV9kY19lbmFibGUnDQo+ID4gZHJpdmVycy9ncHUvZHJtL2lteC9pcHV2
My1jcnRjLmM6NTM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYGlwdV9kY19lbmFibGVfY2hh
bm5lbCcNCj4gPiBkcml2ZXJzL2dwdS9kcm0vaW14L2lwdXYzLWNydGMuYzo1NDogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgaXB1X2RpX2VuYWJsZScNCj4gPiBkcml2ZXJzL2dwdS9kcm0vaW14L2lw
dXYzLWNydGMubzogSW4gZnVuY3Rpb24gYGlwdV9jcnRjX21vZGVfc2V0X25vZmINCj4gPg0KPiA+
IEFkZGluZyBhIEtjb25maWcgZGVwZW5kZW5jeSBhbGxvdyB0byBidWlsZCBpZiBBUkNIX0xBWUVS
U0NBUEUgaXMgZW5hYmxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVf
MUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9pcHUtdjMvS2NvbmZpZyB8IDIg
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvaXB1LXYzL0tjb25maWcgYi9kcml2ZXJz
L2dwdS9pcHUtdjMvS2NvbmZpZw0KPiA+IGluZGV4IGZlNmY4YzViNDQ0NS4uNTFlYTg4YzQ0MGRm
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2lwdS12My9LY29uZmlnDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvaXB1LXYzL0tjb25maWcNCj4gPiBAQCAtMSw2ICsxLDYgQEANCj4gPiAgY29u
ZmlnIElNWF9JUFVWM19DT1JFDQo+ID4gICAgICAgdHJpc3RhdGUgIklQVXYzIGNvcmUgc3VwcG9y
dCINCj4gPiAtICAgICBkZXBlbmRzIG9uIFNPQ19JTVg1IHx8IFNPQ19JTVg2USB8fCBBUkNIX01V
TFRJUExBVEZPUk0gfHwNCj4gQ09NUElMRV9URVNUDQo+ID4gKyAgICAgZGVwZW5kcyBvbiBTT0Nf
SU1YNSB8fCBTT0NfSU1YNlEgfHwgQVJDSF9NVUxUSVBMQVRGT1JNIHx8DQo+ID4gKyBDT01QSUxF
X1RFU1QgfHwgQVJDSF9MQVlFUlNDQVBFDQo+ID4gICAgICAgZGVwZW5kcyBvbiBEUk0gfHwgIURS
TSAjIGlmIERSTT1tLCB0aGlzIGNhbid0IGJlICd5Jw0KPiA+ICAgICAgIHNlbGVjdCBCSVRSRVZF
UlNFDQo+ID4gICAgICAgc2VsZWN0IEdFTkVSSUNfQUxMT0NBVE9SIGlmIERSTQ0KPiA+IC0tDQo+
ID4gMi4xNy4xDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCwgYnV0IHRoaXMgZG9lcyBu
b3Qgc2VlbSByaWdodC4NCj4gaXB1djMtY3J0Yy5jIGlzIHBhcnQgb2YgRFJNX0lNWCwgd2hpY2gg
YWxyZWFkeSBkZXBlbmRzIG9uIElNWF9JUFVWM19DT1JFLg0KPiBIb3cgZGlkIHlvdSBtYW5hZ2Ug
dG8gbWFrZSBpdCB0cnkgdG8gY29tcGlsZSBpbXhkcm0/DQo+IA0KDQpUaGFua3MgZm9yIHRoZSBy
ZXZpZXcsIFBoaWxpcHAsDQoNCk5YUCBMUzEwMjhBIHBsYXRmb3JtIHVzZSBzYW1lIERpc3BsYXkg
SVAgd2l0aCBJTVg4LCBzbyB0aGV5IGhhdmUgdXNlIHNhbWUgZGlzcGxheQ0KdHJhbnNtaXQgY29u
dHJvbGxlciBkcml2ZXJzLCBjb25maWcgJ0RSTV9JTVgnIGlzIHVzZWQgdG8gc3VwcG9ydCBkcm0g
Y29tbW9uIGRyaXZlcnMNCm9uIHRoZSBOWFAgSS5NWCBhbmQgTFMxMDI4QSwgZGlzcGxheSB0cmFu
c21pdCBjb250cm9sbGVyIGlzIGNvbWluZyB0byBwbGFuIHVwc3RyZWFtLiAgDQoNCkFjdHVhbGx5
LCB3ZSBoYXZlIGRvbmUgY29tcGlsZSBvZiB0aGUgaW14ZHJtIG9uIExTMTAyOEEgQlNQIHJlbGVh
c2UuDQoNCj4gU2luY2UgTFMxMDI4QSBkb2VzIG5vdCBoYXZlIHRoZSBJUFV2Mywga2VlcGluZyB0
aGlzIHVuZGVyIENPTVBJTEVfVEVTVA0KPiBzaG91bGQgYmUgY29ycmVjdC4NCg0KQWx0aG91Z2gg
TFMxMDI4QSBkb2VzIG5vdCBoYXZlIHRoZSBJUFZ2MywgYnV0IERSTV9JTVggZGVwZW5kcyBvbiBp
dCwgTFMxMDI4QSBkaXNwbGF5DQpUcmFuc21pdCBjb250cm9sbGVyIGRyaXZlcnMgYWxzbyBkZXBl
bmRzIG9uIERSTV9JTVgsIHNvIHdlIG5lZWQgYWRkIHRoaXMgZGVwZW5kZW5jeSB0bw0Kc29sdmUg
dGhlIGNvbXBpbGUgaXNzdWUuDQoNCkJlc3QgUmVnYXJkcywNCldlbg0KDQo+IA0KPiByZWdhcmRz
DQo+IFBoaWxpcHANCg==
