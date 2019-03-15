Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4389C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AAD218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r5PrTcjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfCOHAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:00:54 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:10750
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfCOHAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxUqjOysIL4M/picgy/UN8gROgo5DYGjJ+VGCTNf6fA=;
 b=r5PrTcjNuY6mewnpupW9+bGg3/ZPCr73J78dcZUrBfkv1bGb5x+GSWLoyOI0HniR2XpaH42Ye9KhXVtZhudQKUBk8miIMMgsv0nqROuyGQgwB45/JljKCzmuAcxwJCc71OQ3ys2deg36sC8lpy73U8gFIGIYgc7BSf7m1DzbacY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3818.eurprd04.prod.outlook.com (52.134.71.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 07:00:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 07:00:46 +0000
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
Subject: RE: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Topic: [PATCH V4 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUycaIN7xFf3mk/UCK6kIxRpvqJqYMZgiA
Date:   Fri, 15 Mar 2019 07:00:46 +0000
Message-ID: <DB3PR0402MB391656F16EBB5C52E5C22DB1F5440@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72d69d0d-1424-408a-3683-08d6a913f303
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3818;
x-ms-traffictypediagnostic: DB3PR0402MB3818:
x-microsoft-antispam-prvs: <DB3PR0402MB3818AF09FBAC9FB3BD3029C0F5440@DB3PR0402MB3818.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(13464003)(199004)(7696005)(5660300002)(186003)(7416002)(99286004)(68736007)(25786009)(44832011)(76176011)(71190400001)(2501003)(476003)(97736004)(74316002)(256004)(52536014)(229853002)(53546011)(6506007)(102836004)(33656002)(53936002)(4326008)(55016002)(486006)(26005)(9686003)(6436002)(446003)(6246003)(305945005)(86362001)(81156014)(14454004)(105586002)(110136005)(8936002)(66066001)(71200400001)(11346002)(3846002)(478600001)(6116002)(7736002)(2906002)(81166006)(8676002)(106356001)(316002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3818;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K15tsMgncVrPGJ+TEoYi0ypcdz/qeYy5h6KcdtTc90tzIXW+885Nl+SgHmhsYNoeMK065erpLtq4IFNWzKueFazpQv3NSvR7lsgWv5TkkfRiP5IHZmdDBiQdWShjmlpP/pcbQB1s2GQfF2Mhv8ui3+SLbNcToRZWxlWgQDyyF8vC/vlUhcyPGjtV2GCArtvWz5uRHxawKlVaIj6pCfJ3k33d/nBRKXDbg6fqfRhFULRQzR+4yq9IIqBryolDtiXEXMm+jLckp+5KK7IlX1wsRcwRyEmuxi2gOSkdNhlRXJ5uRu06HOcjKRu3SCpz1gt0QUMQyGfa0V4RB4/TleQRTeNyaNwHF6NUFB9ACBg7SfgRTJVAlBVr2z6948uIE+uIIONb9oORZchHgugfmSq3JXnr/OQEbtxfaxVdrSi5Obg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d69d0d-1424-408a-3683-08d6a913f303
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 07:00:46.5340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nIFttYWlsdG86QW5zb24uSHVhbmdAbnhw
LmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMjHI1SAxNzoxOQ0KPiBUbzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+IGEuenVtbW9AdG93ZXJ0ZWNoLml0OyBhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNv
bTsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxp
bmFyby5vcmc7IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcnRjQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIFY0IDEvNF0gZHQtYmluZGluZ3M6IGZzbDogc2N1OiBhZGQgZ2VuZXJhbCBp
bnRlcnJ1cHQgc3VwcG9ydA0KPiANCj4gQWRkIHNjdSBnZW5lcmFsIGludGVycnVwdCBmdW5jdGlv
biBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSBWMzoNCj4gCS0gbWFrZSBnZW5lcmFsIE1VIGludGVycnVw
dCBjaGFubmVsIGFzIG9wdGlvbmFsOw0KPiAJLSByZW5hbWUgImdpMyIgdG8gImdpcDMiIGFjY29y
ZGluZyB0byBkcml2ZXIvZHRzIGNoYW5nZS4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICAgICAgfCAxOCArKysrKysrKysrKystLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gaW5kZXggNzJkNDgxYy4uNGE5YjlhYiAx
MDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVl
c2NhbGUvZnNsLHNjdS50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gQEAgLTIyLDkgKzIyLDExIEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAtIGNvbXBhdGlibGU6
CXNob3VsZCBiZSAiZnNsLGlteC1zY3UiLg0KPiAgLSBtYm94LW5hbWVzOglzaG91bGQgaW5jbHVk
ZSAidHgwIiwgInR4MSIsICJ0eDIiLCAidHgzIiwNCj4gLQkJCSAgICAgICAicngwIiwgInJ4MSIs
ICJyeDIiLCAicngzIi4NCj4gLS0gbWJveGVzOglMaXN0IG9mIHBoYW5kbGUgb2YgNCBNVSBjaGFu
bmVscyBmb3IgdHggYW5kIDQgTVUgY2hhbm5lbHMNCj4gLQkJZm9yIHJ4LiBBbGwgOCBNVSBjaGFu
bmVscyBtdXN0IGJlIGluIHRoZSBzYW1lIE1VIGluc3RhbmNlLg0KPiArCQkJICAgICAgICJyeDAi
LCAicngxIiwgInJ4MiIsICJyeDMiOw0KPiArCQlpbmNsdWRlICJnaXAzIiBpZiB3YW50IHRvIHN1
cHBvcnQgZ2VuZXJhbCBNVSBpbnRlcnJ1cHQuDQo+ICstIG1ib3hlczoJTGlzdCBvZiBwaGFuZGxl
IG9mIDQgTVUgY2hhbm5lbHMgZm9yIHR4LCA0IE1VIGNoYW5uZWxzIGZvcg0KPiArCQlyeCwgYW5k
IDEgb3B0aW9uYWwgTVUgY2hhbm5lbCBmb3IgZ2VuZXJhbCBpbnRlcnJ1cHQuDQo+ICsJCUFsbCBN
VSBjaGFubmVscyBtdXN0IGJlIGluIHRoZSBzYW1lIE1VIGluc3RhbmNlLg0KPiAgCQlDcm9zcyBp
bnN0YW5jZXMgYXJlIG5vdCBhbGxvd2VkLiBUaGUgTVUgaW5zdGFuY2UgY2FuIG9ubHkNCj4gIAkJ
YmUgb25lIG9mIExTSU8gTVUwfk00IGZvciBpbXg4cXhwIGFuZCBpbXg4cW0uIFVzZXJzDQo+IG5l
ZWQNCj4gIAkJdG8gbWFrZSBzdXJlIHVzZSB0aGUgb25lIHdoaWNoIGlzIG5vdCBjb25mbGljdCB3
aXRoIG90aGVyIEBADQo+IC0zNCw2ICszNiw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAJ
CUNoYW5uZWwgMSBtdXN0IGJlICJ0eDEiIG9yICJyeDEiLg0KPiAgCQlDaGFubmVsIDIgbXVzdCBi
ZSAidHgyIiBvciAicngyIi4NCj4gIAkJQ2hhbm5lbCAzIG11c3QgYmUgInR4MyIgb3IgInJ4MyIu
DQo+ICsJCUdlbmVyYWwgaW50ZXJydXB0IHJ4IGNoYW5uZWwgbXVzdCBiZSAiZ2lwMyIuDQo+ICAJ
CWUuZy4NCj4gIAkJbWJveGVzID0gPCZsc2lvX211MSAwIDANCj4gIAkJCSAgJmxzaW9fbXUxIDAg
MQ0KPiBAQCAtNDIsNyArNDUsOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAgCQkJICAmbHNp
b19tdTEgMSAwDQo+ICAJCQkgICZsc2lvX211MSAxIDENCj4gIAkJCSAgJmxzaW9fbXUxIDEgMg0K
PiAtCQkJICAmbHNpb19tdTEgMSAzPjsNCj4gKwkJCSAgJmxzaW9fbXUxIDEgMw0KPiArCQkJICAm
bHNpb19tdTEgMyAzPjsNCj4gIAkJU2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tYWlsYm94L2ZzbCxtdS50eHQNCj4gIAkJZm9yIGRldGFpbGVkIG1haWxib3ggYmluZGluZy4N
Cj4gDQo+IEBAIC0xMzMsNyArMTM3LDggQEAgZmlybXdhcmUgew0KPiAgCXNjdSB7DQo+ICAJCWNv
bXBhdGlibGUgPSAiZnNsLGlteC1zY3UiOw0KPiAgCQltYm94LW5hbWVzID0gInR4MCIsICJ0eDEi
LCAidHgyIiwgInR4MyIsDQo+IC0JCQkgICAgICJyeDAiLCAicngxIiwgInJ4MiIsICJyeDMiOw0K
PiArCQkJICAgICAicngwIiwgInJ4MSIsICJyeDIiLCAicngzIiwNCj4gKwkJCSAgICAgImdpcDMi
Ow0KPiAgCQltYm94ZXMgPSA8JmxzaW9fbXUxIDAgMA0KPiAgCQkJICAmbHNpb19tdTEgMCAxDQo+
ICAJCQkgICZsc2lvX211MSAwIDINCj4gQEAgLTE0MSw3ICsxNDYsOCBAQCBmaXJtd2FyZSB7DQo+
ICAJCQkgICZsc2lvX211MSAxIDANCj4gIAkJCSAgJmxzaW9fbXUxIDEgMQ0KPiAgCQkJICAmbHNp
b19tdTEgMSAyDQo+IC0JCQkgICZsc2lvX211MSAxIDM+Ow0KPiArCQkJICAmbHNpb19tdTEgMSAz
DQo+ICsJCQkgICZsc2lvX211MSAzIDM+Ow0KPiANCj4gIAkJY2xrOiBjbGsgew0KPiAgCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14OHF4cC1jbGsiLCAiZnNsLHNjdS1jbGsiOw0KPiAtLQ0KPiAyLjcu
NA0KDQo=
