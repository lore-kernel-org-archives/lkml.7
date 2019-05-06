Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA63C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79124205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/VZOe7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEFIGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:06:54 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:34318
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfEFIGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU+hwGzRti1+kaLy9fvGYn3ov9kqvmkT3oTPANuuDac=;
 b=m/VZOe7y3VDaGET3QP5RBXqFVUrpxntaLViM9oqkhsUZIoocDQPIf3n8dzXAnoRRcY7BVujr/pIuChTMkx+N3Eg4oGJuQUgvLUi+G3PSFYodkkTODSjVQ+DAH7mNC6SD5tHwCkT/sVp4JptIjcKUcmJwy75nrk4qAbl6+8MRhPk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4034.eurprd04.prod.outlook.com (52.134.124.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 08:06:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:06:09 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Thread-Index: AQHVA0ZjnXjmGbRNIUCIpXt7yxOkeqZduNCg
Date:   Mon, 6 May 2019 08:06:09 +0000
Message-ID: <AM0PR04MB4211BC6C3321648BEB67927480300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b43b4e-aa27-4f40-4025-08d6d1f9b2cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4034;
x-ms-traffictypediagnostic: AM0PR04MB4034:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB403416152A7FF3E3D6DE580280300@AM0PR04MB4034.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(102836004)(66066001)(6506007)(4326008)(229853002)(74316002)(305945005)(68736007)(8676002)(25786009)(7736002)(5660300002)(81156014)(81166006)(8936002)(33656002)(256004)(66476007)(66446008)(64756008)(66556008)(71200400001)(66946007)(71190400001)(73956011)(76116006)(110136005)(54906003)(6436002)(44832011)(476003)(2201001)(7696005)(99286004)(76176011)(7416002)(55016002)(52536014)(11346002)(446003)(26005)(186003)(6306002)(9686003)(966005)(3846002)(6116002)(14454004)(6246003)(2501003)(478600001)(53936002)(2906002)(316002)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4034;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZAoXo2tKK4iJeOYrDYQxumjBNXXxjPOjfWDFFpvBDk4Ntx/gQLe92Ss73qmJDqr8sfbb7jXwVaGcKS47V49t6oQaBT/IAkNELyTnKgaqZeUj99gLyZzlkl8iK8vgBJmqbjjTd90DrFzToNoKW5/s2RzI8W3INAp4bRVJTy3BDrKRM+oJmtr2isZOYWAGuhvF4WycC8ke2JCcvM8DC6QGMjK0NtJYlkE5nvpM5RKOAEUQjPfbMX3GK20X5ElvVmaPj1OoFQoaKlX9Xlgdtk5lQq/7vo6Q47+WxyS9bmYv3YW1LD66smxQYPxvHvDGMx8k36LVytWHabq4pJNYzUjndA6Q49DdbP3zaIGjL/Bz1Adn/8x79cWl+4LREdB4aHNXvimHXEwaEbRcJMAH6bzoMDKo7bzM5SrFapypPyVa4NA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b43b4e-aa27-4f40-4025-08d6d1f9b2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:06:09.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDk6MjggUE0NCj4g
DQo+IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGlu
c2lkZSBhcyBzeXN0ZW0NCj4gY29udHJvbGxlcihTQ1UpLCB0aGUgb2NvdHAgY29udHJvbGxlciBp
cyBiZWluZyBjb250cm9sbGVkIGJ5IHRoZSBTQ1UsIHNvIExpbnV4DQo+IG5lZWQgdXNlIFJQQyB0
byBTQ1UgZm9yIG9jb3RwIGhhbmRsaW5nLiBUaGlzIHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9y
IGkuTVg4DQo+IFNDVSBPQ09UUCBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5v
cmc+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiBDYzogQWlz
aGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Pg0KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiBDYzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zw0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0IHwgMTMNCj4gKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+IGluZGV4
IDVkN2RiYWJiYjc4NC4uOWNiN2Q1MmJkZjI2IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4
dA0KPiBAQCAtMTAwLDYgKzEwMCwxMyBAQCBJRCBpbiBpdHMgImNsb2NrcyIgcGhhbmRsZSBjZWxs
Lg0KPiAgU2VlIHRoZSBmdWxsIGxpc3Qgb2YgY2xvY2sgSURzIGZyb206DQo+ICBpbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL2lteDhxeHAtY2xvY2suaA0KPiANCj4gK09DT1RQIGJpbmRpbmdzIGJh
c2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gK1JlcXVpcmVkIHByb3BlcnRp
ZXM6DQo+ICstIGNvbXBhdGlibGU6CQlTaG91bGQgYmUgImZzbCxpbXg4cXhwLW9jb3RwIg0KPiAr
LSAjYWRkcmVzcy1jZWxsczoJTXVzdCBiZSAxLiBDb250YWlucyBieXRlIGluZGV4DQo+ICstICNz
aXplLWNlbGxzOgkJTXVzdCBiZSAxLiBDb250YWlucyBieXRlIGxlbmd0aA0KPiArDQoNClBsZWFz
ZSBwdXQgdGhpcyB1bmltcG9ydGFudCBvbmUgdG8gdGhlIGxhc3QuDQpBbmQgaXQncyBiZXR0ZXIg
dG8gbWVudGlvbiB0aGUgb3B0aW9uYWwgY2hpbGQgbm9kZXMgZm9yIGRhdGEgY2VsbHMgYXMNCkFi
b3ZlICNhZGRyZXNzLWNlbGxzIGFuZCAjc2l6ZS1jZWxscyBhcmUgdXNlZCBmb3IgaXQuDQpKdXN0
IGxpa2U6DQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vaW14LW9jb3Rw
LnR4dA0KDQo+ICBQaW5jdHJsIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29s
DQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gDQo+IEBAIC0xNzcsNiArMTg0LDEyIEBAIGZpcm13YXJlIHsNCj4gIAkJCS4u
Lg0KPiAgCQl9Ow0KPiANCj4gKwkJb2NvdHA6IGlteDhxeC1vY290cCB7DQo+ICsJCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KDQpOb3Qgc3VyZSBpZiBp
dCdzIGEgZnJlZSBjaG9pY2UsIGJ1dCBBRkFJSyB3ZSB1c3VhbGx5IHdyaXRlICNhZGRyZXNzLWNl
bGxzIGFuZCAjc2l6ZS1jZWxscw0KdW5kZXIgY29tcGF0aWJsZSBzdHJpbmcgYWNjb3JkaW5nIHRv
IHRoZSBleGFtcGxlIGluIERUIHNwZWMgYW5kIGRvYy4NCmh0dHBzOi8vZWxpbnV4Lm9yZy9EZXZp
Y2VfVHJlZV9Vc2FnZQ0KaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2RldmljZXRy
ZWUtc3BlY2lmaWNhdGlvbi9yZWxlYXNlcy90YWcvdjAuMg0KDQpNYXliZSBSb2IgY2FuIGNvbW1l
bnQgdG8gYXZvaWQgY29uZnVzaW5nLg0KDQpPdGhlcndpc2UsIHRoaXMgcGF0Y2ggc2VlbXMgZ29v
ZCB0byBtZS4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gKwkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtb2NvdHAiOw0KPiArCQl9Ow0KPiArDQo+ICAJCXBkOiBpbXg4cXgtcGQgew0K
PiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zY3UtcGQiLCAiZnNsLHNjdS1wZCI7DQo+
ICAJCQkjcG93ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiAtLQ0KPiAyLjE2LjQNCg0K
