Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE098C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EB2217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nG1aL7Tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDKBhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:37:10 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:15333
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfDKBhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUSnFAadgMENmGGeXhWbvLhPyXS694ylRG5jNhCaBHk=;
 b=nG1aL7TutcAdfP+1QIdqa4AU5apkjLdlAQzM8kX2Qb7frpwJx2OH1gD7WhAfeT1OL41Ar6eJTqjaJuKMp6/xn63ORZ/ke9funzizsS7lcfWaWaRt136Ui2BfQkm9c6hmS2qS3PWOlcUkWn1+GiAa+T3XSnsRYFWUCy2u3TNovqY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Thu, 11 Apr 2019 01:37:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 01:37:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Topic: [PATCH V7 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHU7pEP/aWUWgl2+kGd1srtqLUIq6Y2L1kA
Date:   Thu, 11 Apr 2019 01:37:03 +0000
Message-ID: <DB3PR0402MB3916404D21CB977F3AA010C2F52F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 750d7cc9-50ab-40bf-a043-08d6be1e333a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB38830ECF1702B063346147A6F52F0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(13464003)(102836004)(3846002)(44832011)(6116002)(316002)(7416002)(76176011)(7696005)(14454004)(6246003)(106356001)(81156014)(8936002)(55016002)(9686003)(229853002)(8676002)(6506007)(99286004)(81166006)(53546011)(6436002)(105586002)(446003)(2501003)(26005)(14444005)(25786009)(256004)(476003)(5660300002)(86362001)(71190400001)(53936002)(68736007)(11346002)(71200400001)(66066001)(4326008)(508600001)(110136005)(7736002)(305945005)(186003)(74316002)(97736004)(486006)(2906002)(2201001)(52536014)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zWvkj2X7r1hoBJkacNcnJKBWdvrHcOU9WqQmX0HtNKeIiVL/70jhIYuIcgX4LvPpdTIKUNT6UGVgEaiR1g75/eOvQfI9hINEahk994FrxgQGsmJa45mGK/uyByjfjvCWbF1pAuE9jngfzZdHMQ6qWbJBlpC7tEGvj10Sko4X662fF1EP4syNKtvgeiqBBOG8UYGV8ywGdHb9daOq7pkIX/OWv9htE4tzibATvMlzzd1HTsQks/zE5ewHHhvrdfepBKiYRsX35qyGqY8cOvA/QNcH6pHZco9YgxP/TYobzrddzzmB9DcvDGKUtwKG+E+rjqoHMwfhmI7AzL2ajbS9FQZAB73cXFJq0Zr7RdXd7msTwmnqkTV5u5YeK25YmzuWIDz6/B4ub9Ko6VMBRsU0cU0GZwS5/0lkff/rlDRkdhE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750d7cc9-50ab-40bf-a043-08d6be1e333a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 01:37:03.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoJQ2FuIHlvdSBwaWNrIHVwIHRoaXMgcGF0Y2ggc2VyaWVzIGlmIG5vIGFkZGl0
aW9uYWwgY29tbWVudHM/IFdlIG5lZWQgdGhpcyBmZWF0dXJlIHRvIHN1cHBvcnQgbWFueSBtb2R1
bGVzIElSUSBmdW5jdGlvbiBpbmNsdWRpbmcgc3VzcGVuZC9yZXN1bWUsIHRoYW5rcy4gDQoNCkJl
c3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogMjAxOeW5tDTmnIg55pelIDEzOjAwDQo+IFRv
OiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gYS56dW1tb0B0b3dlcnRlY2guaXQ7IGFsZXhhbmRyZS5i
ZWxsb25pQGJvb3RsaW4uY29tOyBBaXNoZW5nIERvbmcNCj4gPGFpc2hlbmcuZG9uZ0BueHAuY29t
PjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgc2JveWRAa2VybmVsLm9yZzsgUGVuZw0KPiBGYW4g
PHBlbmcuZmFuQG54cC5jb20+OyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcnRj
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIFY3IDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgZ2Vu
ZXJhbCBpbnRlcnJ1cHQgc3VwcG9ydA0KPiANCj4gQWRkIHNjdSBnZW5lcmFsIGludGVycnVwdCBm
dW5jdGlvbiBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KPiBSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4N
Cj4gLS0tDQo+IE5vIGNoYW5nZXMuDQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dCAgfCAyOSArKysrKysrKysrKysrKysrKy0tDQo+IC0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiBpbmRleCA3MmQ0ODFjLi41ZDdkYmFiIDEw
MDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVz
Y2FsZS9mc2wsc2N1LnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiBAQCAtMjIsOSArMjIsMTEgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIC0gY29tcGF0aWJsZToJ
c2hvdWxkIGJlICJmc2wsaW14LXNjdSIuDQo+ICAtIG1ib3gtbmFtZXM6CXNob3VsZCBpbmNsdWRl
ICJ0eDAiLCAidHgxIiwgInR4MiIsICJ0eDMiLA0KPiAtCQkJICAgICAgICJyeDAiLCAicngxIiwg
InJ4MiIsICJyeDMiLg0KPiAtLSBtYm94ZXM6CUxpc3Qgb2YgcGhhbmRsZSBvZiA0IE1VIGNoYW5u
ZWxzIGZvciB0eCBhbmQgNCBNVSBjaGFubmVscw0KPiAtCQlmb3IgcnguIEFsbCA4IE1VIGNoYW5u
ZWxzIG11c3QgYmUgaW4gdGhlIHNhbWUgTVUgaW5zdGFuY2UuDQo+ICsJCQkgICAgICAgInJ4MCIs
ICJyeDEiLCAicngyIiwgInJ4MyI7DQo+ICsJCWluY2x1ZGUgImdpcDMiIGlmIHdhbnQgdG8gc3Vw
cG9ydCBnZW5lcmFsIE1VIGludGVycnVwdC4NCj4gKy0gbWJveGVzOglMaXN0IG9mIHBoYW5kbGUg
b2YgNCBNVSBjaGFubmVscyBmb3IgdHgsIDQgTVUgY2hhbm5lbHMgZm9yDQo+ICsJCXJ4LCBhbmQg
MSBvcHRpb25hbCBNVSBjaGFubmVsIGZvciBnZW5lcmFsIGludGVycnVwdC4NCj4gKwkJQWxsIE1V
IGNoYW5uZWxzIG11c3QgYmUgaW4gdGhlIHNhbWUgTVUgaW5zdGFuY2UuDQo+ICAJCUNyb3NzIGlu
c3RhbmNlcyBhcmUgbm90IGFsbG93ZWQuIFRoZSBNVSBpbnN0YW5jZSBjYW4gb25seQ0KPiAgCQli
ZSBvbmUgb2YgTFNJTyBNVTB+TTQgZm9yIGlteDhxeHAgYW5kIGlteDhxbS4gVXNlcnMNCj4gbmVl
ZA0KPiAgCQl0byBtYWtlIHN1cmUgdXNlIHRoZSBvbmUgd2hpY2ggaXMgbm90IGNvbmZsaWN0IHdp
dGggb3RoZXIgQEANCj4gLTM0LDYgKzM2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gIAkJ
Q2hhbm5lbCAxIG11c3QgYmUgInR4MSIgb3IgInJ4MSIuDQo+ICAJCUNoYW5uZWwgMiBtdXN0IGJl
ICJ0eDIiIG9yICJyeDIiLg0KPiAgCQlDaGFubmVsIDMgbXVzdCBiZSAidHgzIiBvciAicngzIi4N
Cj4gKwkJR2VuZXJhbCBpbnRlcnJ1cHQgcnggY2hhbm5lbCBtdXN0IGJlICJnaXAzIi4NCj4gIAkJ
ZS5nLg0KPiAgCQltYm94ZXMgPSA8JmxzaW9fbXUxIDAgMA0KPiAgCQkJICAmbHNpb19tdTEgMCAx
DQo+IEBAIC00MiwxMCArNDUsMTggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gIAkJCSAgJmxz
aW9fbXUxIDEgMA0KPiAgCQkJICAmbHNpb19tdTEgMSAxDQo+ICAJCQkgICZsc2lvX211MSAxIDIN
Cj4gLQkJCSAgJmxzaW9fbXUxIDEgMz47DQo+ICsJCQkgICZsc2lvX211MSAxIDMNCj4gKwkJCSAg
JmxzaW9fbXUxIDMgMz47DQo+ICAJCVNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWFpbGJveC9mc2wsbXUudHh0DQo+ICAJCWZvciBkZXRhaWxlZCBtYWlsYm94IGJpbmRpbmcu
DQo+IA0KPiArTm90ZTogRWFjaCBtdSB3aGljaCBzdXBwb3J0cyBnZW5lcmFsIGludGVycnVwdCBz
aG91bGQgaGF2ZSBhbiBhbGlhcw0KPiArY29ycmVjdGx5IG51bWJlcmVkIGluICJhbGlhc2VzIiBu
b2RlLg0KPiArZS5nLg0KPiArYWxpYXNlcyB7DQo+ICsJbXUxID0gJmxzaW9fbXUxOw0KPiArfTsN
Cj4gKw0KPiAgaS5NWCBTQ1UgQ2xpZW50IERldmljZSBOb2RlOg0KPiAgPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBAQCAt
MTI0LDYgKzEzNSwxMCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiANCj4gIEV4YW1wbGUgKGlt
eDhxeHApOg0KPiAgLS0tLS0tLS0tLS0tLQ0KPiArYWxpYXNlcyB7DQo+ICsJbXUxID0gJmxzaW9f
bXUxOw0KPiArfTsNCj4gKw0KPiAgbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAgew0KPiAgCS4u
Lg0KPiAgCSNtYm94LWNlbGxzID0gPDI+Ow0KPiBAQCAtMTMzLDcgKzE0OCw4IEBAIGZpcm13YXJl
IHsNCj4gIAlzY3Ugew0KPiAgCQljb21wYXRpYmxlID0gImZzbCxpbXgtc2N1IjsNCj4gIAkJbWJv
eC1uYW1lcyA9ICJ0eDAiLCAidHgxIiwgInR4MiIsICJ0eDMiLA0KPiAtCQkJICAgICAicngwIiwg
InJ4MSIsICJyeDIiLCAicngzIjsNCj4gKwkJCSAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4
MyIsDQo+ICsJCQkgICAgICJnaXAzIjsNCj4gIAkJbWJveGVzID0gPCZsc2lvX211MSAwIDANCj4g
IAkJCSAgJmxzaW9fbXUxIDAgMQ0KPiAgCQkJICAmbHNpb19tdTEgMCAyDQo+IEBAIC0xNDEsNyAr
MTU3LDggQEAgZmlybXdhcmUgew0KPiAgCQkJICAmbHNpb19tdTEgMSAwDQo+ICAJCQkgICZsc2lv
X211MSAxIDENCj4gIAkJCSAgJmxzaW9fbXUxIDEgMg0KPiAtCQkJICAmbHNpb19tdTEgMSAzPjsN
Cj4gKwkJCSAgJmxzaW9fbXUxIDEgMw0KPiArCQkJICAmbHNpb19tdTEgMyAzPjsNCj4gDQo+ICAJ
CWNsazogY2xrIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtY2xrIiwgImZzbCxz
Y3UtY2xrIjsNCj4gLS0NCj4gMi43LjQNCg0K
