Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DE62086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="snNBZEVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfDACiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:38:21 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:7813
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbfDACiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0JeOXOb1lHwH4C2ma6RIV1pvcPr6qJkW2Wh2lVos5Q=;
 b=snNBZEVUCV9m6jB7pF2J7RpsLcLgAA1e2nkP1aVAFu7yT/Psa7LY5X22Y4GNw5IG6q9SnVNZReic1QB6nL6Bej+YJfkakIiAcavouEPO8FpcbFpFv2hQntVbqDNsC/n0ACTl/ZPQcnO8nWDD30R55bRCbciHUblf2vLnhWcikyQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 02:38:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 02:38:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Topic: [PATCH V5 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHU3TgMmDp2QtLWCEidsBGFRWrSFKYmrWlg
Date:   Mon, 1 Apr 2019 02:38:11 +0000
Message-ID: <DB3PR0402MB391688AEF1B5EEEFE07315EEF5550@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1556a323-40b2-4c68-5389-08d6b64b1584
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-microsoft-antispam-prvs: <DB3PR0402MB37396CBEB9368282019E9B45F5550@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(74316002)(26005)(305945005)(14454004)(44832011)(2501003)(53936002)(53546011)(256004)(55016002)(478600001)(6246003)(7736002)(186003)(9686003)(7416002)(97736004)(52536014)(2906002)(6116002)(3846002)(81156014)(2201001)(8936002)(71200400001)(8676002)(6436002)(6506007)(110136005)(68736007)(106356001)(316002)(4326008)(66066001)(71190400001)(99286004)(81166006)(105586002)(11346002)(86362001)(102836004)(476003)(486006)(33656002)(76176011)(5660300002)(7696005)(446003)(229853002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hANLxGNK7FDNyMQmJJeKozHHOL29/tIP8m5bVEBcysc6iaUtu2gf/I5GJK777rDeYjXJOUX6VT+DuMQhLLRJgAZXCtF4BJKc2hLblwbAEKmbQp3UudsnCh31TlGrllxHX+qApyFF9eHv5uEB9g04qCAipA9J50j5B8v6bW+ZM6HqXmi5nuPRyPFJ+1xcDmoGBh4riYYEbsxYsZBndOsGNzthfn4ze0askw3lnFdVtBFvIMQO1C3O+pjLH7+JAYLFV/lAaHZ6eFv5Qz6aieIGp+RkYMewxS65tNm3Revvp84J0+KrmR6UmOPEsctOCqRGd/Zjn3WFOdQX3aUNicIlEG4NTdoaLeq3obLv2ftm20tcjIh8w3u9+kTHT+eaSusHww7/oTAKAkBJrmiAcRfdC0X2PjiNBHhUT6Bc5lVml80=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1556a323-40b2-4c68-5389-08d6b64b1584
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 02:38:11.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nIFttYWlsdG86QW5zb24uSHVhbmdAbnhw
LmNvbV0NCj4gU2VudDogMjAxOcTqM9TCMTjI1SAxMToxMA0KPiBUbzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+IGEuenVtbW9AdG93ZXJ0ZWNoLml0OyBhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNv
bTsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxp
bmFyby5vcmc7IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcnRjQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIFY1IDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgZ2VuZXJhbCBp
bnRlcnJ1cHQgc3VwcG9ydA0KPiANCj4gQWRkIHNjdSBnZW5lcmFsIGludGVycnVwdCBmdW5jdGlv
biBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiBSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gLS0t
DQo+IENoYW5nZXMgc2luY2UgVjQ6DQo+IAktIGFkZCBtdSBhbGlhc2UgaW5mbyBhbmQgZXhhbXBs
ZSBpbiBiaW5kaW5nIGRvYy4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICB8IDI5ICsrKysrKysrKysrKysrKysrLS0NCj4gLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVz
Y2FsZS9mc2wsc2N1LnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+IGluZGV4IDcyZDQ4MWMuLjVkN2RiYWIgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxl
L2ZzbCxzY3UudHh0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+IEBAIC0yMiw5ICsyMiwxMSBAQCBSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KPiAgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgLSBjb21wYXRpYmxlOglzaG91
bGQgYmUgImZzbCxpbXgtc2N1Ii4NCj4gIC0gbWJveC1uYW1lczoJc2hvdWxkIGluY2x1ZGUgInR4
MCIsICJ0eDEiLCAidHgyIiwgInR4MyIsDQo+IC0JCQkgICAgICAgInJ4MCIsICJyeDEiLCAicngy
IiwgInJ4MyIuDQo+IC0tIG1ib3hlczoJTGlzdCBvZiBwaGFuZGxlIG9mIDQgTVUgY2hhbm5lbHMg
Zm9yIHR4IGFuZCA0IE1VIGNoYW5uZWxzDQo+IC0JCWZvciByeC4gQWxsIDggTVUgY2hhbm5lbHMg
bXVzdCBiZSBpbiB0aGUgc2FtZSBNVSBpbnN0YW5jZS4NCj4gKwkJCSAgICAgICAicngwIiwgInJ4
MSIsICJyeDIiLCAicngzIjsNCj4gKwkJaW5jbHVkZSAiZ2lwMyIgaWYgd2FudCB0byBzdXBwb3J0
IGdlbmVyYWwgTVUgaW50ZXJydXB0Lg0KPiArLSBtYm94ZXM6CUxpc3Qgb2YgcGhhbmRsZSBvZiA0
IE1VIGNoYW5uZWxzIGZvciB0eCwgNCBNVSBjaGFubmVscyBmb3INCj4gKwkJcngsIGFuZCAxIG9w
dGlvbmFsIE1VIGNoYW5uZWwgZm9yIGdlbmVyYWwgaW50ZXJydXB0Lg0KPiArCQlBbGwgTVUgY2hh
bm5lbHMgbXVzdCBiZSBpbiB0aGUgc2FtZSBNVSBpbnN0YW5jZS4NCj4gIAkJQ3Jvc3MgaW5zdGFu
Y2VzIGFyZSBub3QgYWxsb3dlZC4gVGhlIE1VIGluc3RhbmNlIGNhbiBvbmx5DQo+ICAJCWJlIG9u
ZSBvZiBMU0lPIE1VMH5NNCBmb3IgaW14OHF4cCBhbmQgaW14OHFtLiBVc2Vycw0KPiBuZWVkDQo+
ICAJCXRvIG1ha2Ugc3VyZSB1c2UgdGhlIG9uZSB3aGljaCBpcyBub3QgY29uZmxpY3Qgd2l0aCBv
dGhlciBAQA0KPiAtMzQsNiArMzYsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgCQlDaGFu
bmVsIDEgbXVzdCBiZSAidHgxIiBvciAicngxIi4NCj4gIAkJQ2hhbm5lbCAyIG11c3QgYmUgInR4
MiIgb3IgInJ4MiIuDQo+ICAJCUNoYW5uZWwgMyBtdXN0IGJlICJ0eDMiIG9yICJyeDMiLg0KPiAr
CQlHZW5lcmFsIGludGVycnVwdCByeCBjaGFubmVsIG11c3QgYmUgImdpcDMiLg0KPiAgCQllLmcu
DQo+ICAJCW1ib3hlcyA9IDwmbHNpb19tdTEgMCAwDQo+ICAJCQkgICZsc2lvX211MSAwIDENCj4g
QEAgLTQyLDEwICs0NSwxOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgCQkJICAmbHNpb19t
dTEgMSAwDQo+ICAJCQkgICZsc2lvX211MSAxIDENCj4gIAkJCSAgJmxzaW9fbXUxIDEgMg0KPiAt
CQkJICAmbHNpb19tdTEgMSAzPjsNCj4gKwkJCSAgJmxzaW9fbXUxIDEgMw0KPiArCQkJICAmbHNp
b19tdTEgMyAzPjsNCj4gIAkJU2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L2ZzbCxtdS50eHQNCj4gIAkJZm9yIGRldGFpbGVkIG1haWxib3ggYmluZGluZy4NCj4g
DQo+ICtOb3RlOiBFYWNoIG11IHdoaWNoIHN1cHBvcnRzIGdlbmVyYWwgaW50ZXJydXB0IHNob3Vs
ZCBoYXZlIGFuIGFsaWFzDQo+ICtjb3JyZWN0bHkgbnVtYmVyZWQgaW4gImFsaWFzZXMiIG5vZGUu
DQo+ICtlLmcuDQo+ICthbGlhc2VzIHsNCj4gKwltdTEgPSAmbHNpb19tdTE7DQo+ICt9Ow0KPiAr
DQo+ICBpLk1YIFNDVSBDbGllbnQgRGV2aWNlIE5vZGU6DQo+ICA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+IEBAIC0xMjQs
NiArMTM1LDEwIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+IA0KPiAgRXhhbXBsZSAoaW14OHF4
cCk6DQo+ICAtLS0tLS0tLS0tLS0tDQo+ICthbGlhc2VzIHsNCj4gKwltdTEgPSAmbHNpb19tdTE7
DQo+ICt9Ow0KPiArDQo+ICBsc2lvX211MTogbWFpbGJveEA1ZDFjMDAwMCB7DQo+ICAJLi4uDQo+
ICAJI21ib3gtY2VsbHMgPSA8Mj47DQo+IEBAIC0xMzMsNyArMTQ4LDggQEAgZmlybXdhcmUgew0K
PiAgCXNjdSB7DQo+ICAJCWNvbXBhdGlibGUgPSAiZnNsLGlteC1zY3UiOw0KPiAgCQltYm94LW5h
bWVzID0gInR4MCIsICJ0eDEiLCAidHgyIiwgInR4MyIsDQo+IC0JCQkgICAgICJyeDAiLCAicngx
IiwgInJ4MiIsICJyeDMiOw0KPiArCQkJICAgICAicngwIiwgInJ4MSIsICJyeDIiLCAicngzIiwN
Cj4gKwkJCSAgICAgImdpcDMiOw0KPiAgCQltYm94ZXMgPSA8JmxzaW9fbXUxIDAgMA0KPiAgCQkJ
ICAmbHNpb19tdTEgMCAxDQo+ICAJCQkgICZsc2lvX211MSAwIDINCj4gQEAgLTE0MSw3ICsxNTcs
OCBAQCBmaXJtd2FyZSB7DQo+ICAJCQkgICZsc2lvX211MSAxIDANCj4gIAkJCSAgJmxzaW9fbXUx
IDEgMQ0KPiAgCQkJICAmbHNpb19tdTEgMSAyDQo+IC0JCQkgICZsc2lvX211MSAxIDM+Ow0KPiAr
CQkJICAmbHNpb19tdTEgMSAzDQo+ICsJCQkgICZsc2lvX211MSAzIDM+Ow0KPiANCj4gIAkJY2xr
OiBjbGsgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1jbGsiLCAiZnNsLHNjdS1j
bGsiOw0KPiAtLQ0KPiAyLjcuNA0KDQo=
