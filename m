Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE268C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4019205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXxdMK8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEFIu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:50:57 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:29091
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfEFIu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oXaDylPAYgguXuOpuuI80qOsq24+BXni+j1MWNwDJc=;
 b=UXxdMK8ozvW7Svsn1v8xLgirgJ/mPkvfETAGRiYI0/NFT3FTm/3OfHm6cOOWU1X7Tgv6VfxXjxX1jjFOeUDJgVfssD2oIBcKPPkveY3H78hXVaBc1vRuT1acFdQgD9hqN52dV9Q3b5kwUUTfGvdt8y98qSUiAd7v8dOZEmK1S7Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5940.eurprd04.prod.outlook.com (20.178.114.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Mon, 6 May 2019 08:50:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:50:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Topic: [PATCH 1/4] dt-bindings: fsl: scu: add ocotp binding
Thread-Index: AQHVA0ZjnXjmGbRNIUCIpXt7yxOkeqZduNCggAARL5A=
Date:   Mon, 6 May 2019 08:50:51 +0000
Message-ID: <AM0PR04MB44815E080F8639F597BD085E88300@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
 <AM0PR04MB4211BC6C3321648BEB67927480300@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211BC6C3321648BEB67927480300@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0b814e2-5ca4-4192-bc7d-08d6d1fff1b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5940;
x-ms-traffictypediagnostic: AM0PR04MB5940:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB594017966AC9D6AAE349A62188300@AM0PR04MB5940.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(66446008)(6436002)(229853002)(66066001)(74316002)(66476007)(64756008)(66556008)(8676002)(2501003)(4326008)(186003)(7416002)(99286004)(52536014)(73956011)(55016002)(66946007)(6116002)(3846002)(9686003)(6306002)(76116006)(25786009)(14444005)(256004)(305945005)(71200400001)(71190400001)(5660300002)(6246003)(14454004)(53936002)(54906003)(11346002)(110136005)(316002)(86362001)(476003)(8936002)(446003)(68736007)(966005)(2201001)(7736002)(33656002)(2906002)(44832011)(478600001)(76176011)(81166006)(81156014)(7696005)(102836004)(26005)(6506007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5940;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZQs1Fs+/YM6l0s8sGNnqBshaH4l1mE8y8/MRsLxtnb6ZofpeDeX4PS+iPthzJh7AHy+dRPlMxNOYsm6SXdBoFaPiU1NciZ3CrN6TeDNM2XQtzALaH+0c/jRMRbLOw/4mKa6EXnEdLe0zFakGBNmqvk00gbACBAK4BNIa4smynNW7OKtnP1AP+taoe8fyPiLRc+KwbvKfIGa4ArMMEjDvRTYygcHr/V+es7+N/SrmNBDLH14pXQuhNW4mrcjgpRjAG8GNC32SSCaCQaS5imC4ek35j/yCI13lRIUGzSQejM6GJkWd7+AVDQl35D3PXXplYkiPUrPyf3leJ6RGi3p3ibbcDjEigfy++6E/5OfJr7nSnXZKBJVmG0O0OYuLIj3tUZEB2+GVrz1mMCYpxfozx8c6efIqCNWBGrWcIctGjQg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b814e2-5ca4-4192-bc7d-08d6d1fff1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:50:51.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWlzaGVuZywNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvNF0gZHQtYmluZGluZ3M6IGZz
bDogc2N1OiBhZGQgb2NvdHAgYmluZGluZw0KPiANCj4gPiBGcm9tOiBQZW5nIEZhbg0KPiA+IFNl
bnQ6IFN1bmRheSwgTWF5IDUsIDIwMTkgOToyOCBQTQ0KPiA+DQo+ID4gTlhQIGkuTVg4UVhQIGlz
IGFuIEFSTXY4IFNvQyB3aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiA+
IGNvbnRyb2xsZXIoU0NVKSwgdGhlIG9jb3RwIGNvbnRyb2xsZXIgaXMgYmVpbmcgY29udHJvbGxl
ZCBieSB0aGUgU0NVLA0KPiA+IHNvIExpbnV4IG5lZWQgdXNlIFJQQyB0byBTQ1UgZm9yIG9jb3Rw
IGhhbmRsaW5nLiBUaGlzIHBhdGNoIGFkZHMNCj4gPiBiaW5kaW5nIGRvYyBmb3IgaS5NWDggU0NV
IE9DT1RQIGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZh
bkBueHAuY29tPg0KPiA+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiA+
IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiA+IENjOiBBaXNoZW5n
IERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Pg0KPiA+IENjOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEFuc29u
IEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+IENjOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dCB8IDEzDQo+ID4gKysrKysrKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNj
dS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0DQo+ID4gaW5kZXggNWQ3ZGJhYmJiNzg0Li45Y2I3ZDUyYmRmMjYgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVl
c2NhbGUvZnNsLHNjdS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IEBAIC0xMDAsNiArMTAwLDEzIEBA
IElEIGluIGl0cyAiY2xvY2tzIiBwaGFuZGxlIGNlbGwuDQo+ID4gIFNlZSB0aGUgZnVsbCBsaXN0
IG9mIGNsb2NrIElEcyBmcm9tOg0KPiA+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhx
eHAtY2xvY2suaA0KPiA+DQo+ID4gK09DT1RQIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdl
IFByb3RvY29sDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICstIGNv
bXBhdGlibGU6CQlTaG91bGQgYmUgImZzbCxpbXg4cXhwLW9jb3RwIg0KPiA+ICstICNhZGRyZXNz
LWNlbGxzOglNdXN0IGJlIDEuIENvbnRhaW5zIGJ5dGUgaW5kZXgNCj4gPiArLSAjc2l6ZS1jZWxs
czoJCU11c3QgYmUgMS4gQ29udGFpbnMgYnl0ZSBsZW5ndGgNCj4gPiArDQo+IA0KPiBQbGVhc2Ug
cHV0IHRoaXMgdW5pbXBvcnRhbnQgb25lIHRvIHRoZSBsYXN0Lg0KDQpvay4gSSBqdXN0IGZvbGxv
d2VkIGFscGhhYmV0aWNhbCBvcmRlciBhcyBPQ09UUCwgUGluY3RybCwgUlRDIHNlcXVlbmNlLg0K
V2lsbCBtb3ZlIGl0IHRvIGxhc3QgaW4gVjIuDQoNCj4gQW5kIGl0J3MgYmV0dGVyIHRvIG1lbnRp
b24gdGhlIG9wdGlvbmFsIGNoaWxkIG5vZGVzIGZvciBkYXRhIGNlbGxzIGFzIEFib3ZlDQo+ICNh
ZGRyZXNzLWNlbGxzIGFuZCAjc2l6ZS1jZWxscyBhcmUgdXNlZCBmb3IgaXQuDQo+IEp1c3QgbGlr
ZToNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50
eHQNCj4gDQo+ID4gIFBpbmN0cmwgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9j
b2wNCj4gPiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4NCj4gPiBAQCAtMTc3LDYgKzE4NCwxMiBAQCBmaXJtd2FyZSB7DQo+
ID4gIAkJCS4uLg0KPiA+ICAJCX07DQo+ID4NCj4gPiArCQlvY290cDogaW14OHF4LW9jb3RwIHsN
Cj4gPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJCSNzaXplLWNlbGxzID0gPDE+
Ow0KPiANCj4gTm90IHN1cmUgaWYgaXQncyBhIGZyZWUgY2hvaWNlLCBidXQgQUZBSUsgd2UgdXN1
YWxseSB3cml0ZSAjYWRkcmVzcy1jZWxscyBhbmQNCj4gI3NpemUtY2VsbHMgdW5kZXIgY29tcGF0
aWJsZSBzdHJpbmcgYWNjb3JkaW5nIHRvIHRoZSBleGFtcGxlIGluIERUIHNwZWMgYW5kDQo+IGRv
Yy4NCg0KRml4IGluIFYyLg0KDQpUaGFua3MsDQpQZW5nDQoNCj4gaHR0cHM6Ly9lbGludXgub3Jn
L0RldmljZV9UcmVlX1VzYWdlDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9k
ZXZpY2V0cmVlLXNwZWNpZmljYXRpb24vcmVsZWFzZXMvdGFnL3YwLg0KPiAyDQo+IA0KPiBNYXli
ZSBSb2IgY2FuIGNvbW1lbnQgdG8gYXZvaWQgY29uZnVzaW5nLg0KPiANCj4gT3RoZXJ3aXNlLCB0
aGlzIHBhdGNoIHNlZW1zIGdvb2QgdG8gbWUuDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlzaGVu
Zw0KPiANCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1vY290cCI7DQo+ID4gKwkJ
fTsNCj4gPiArDQo+ID4gIAkJcGQ6IGlteDhxeC1wZCB7DQo+ID4gIAkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtc2N1LXBkIiwgImZzbCxzY3UtcGQiOw0KPiA+ICAJCQkjcG93ZXItZG9tYWlu
LWNlbGxzID0gPDE+Ow0KPiA+IC0tDQo+ID4gMi4xNi40DQoNCg==
