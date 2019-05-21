Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A650C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12D820863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R1QaUYyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfEUIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:17:48 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:31811
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEUIRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEHjZAONryAg/0tMDSUupiVQk+SumFQKMjao6wGi8A8=;
 b=R1QaUYyt8+EKJFCKL7Sn4oQCBoYRDAMRiDkJYTF/C0qnM7qXq6h6MiFn2La+lVj8T/GptXg4XmjZmw5o+Hcww9n4dHCrysU7k0HP9T8z5x6xfYnk7VnQYS8e6On31+3KQSwckW0g1sTC821KDmyMBs92pIp74kHK7W1fFuSR6Z0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 08:17:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 08:17:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8qxp: Add gpio alias
Thread-Topic: [PATCH] arm64: dts: imx8qxp: Add gpio alias
Thread-Index: AQHVChGBhvqur/npCUCFDgMod6JPUqZ1RMKAgAACSWA=
Date:   Tue, 21 May 2019 08:17:43 +0000
Message-ID: <DB3PR0402MB391632602294707677060EF3F5070@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557809536-749-1-git-send-email-Anson.Huang@nxp.com>
 <20190521080900.GC15856@dragon>
In-Reply-To: <20190521080900.GC15856@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e01cd10-440d-4de9-82d6-08d6ddc4ccc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB37553E27AABF4209FEE9B692F5070@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(13464003)(6246003)(478600001)(446003)(6916009)(44832011)(11346002)(7736002)(186003)(2906002)(102836004)(86362001)(68736007)(66066001)(305945005)(25786009)(81166006)(14454004)(4326008)(6506007)(76116006)(53546011)(53936002)(229853002)(8936002)(66476007)(66556008)(64756008)(66446008)(73956011)(66946007)(5660300002)(14444005)(256004)(52536014)(9686003)(99286004)(54906003)(6436002)(476003)(76176011)(71190400001)(71200400001)(8676002)(3846002)(33656002)(6116002)(316002)(7696005)(81156014)(26005)(74316002)(55016002)(486006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1zQdOVWGSttW23EdY09CvUsoDGvJxRL6o1sggc8w70kjURPEeLQdeEshYbYwQZovUSytJOGa1V6Do/OAWrn1xzWjBejj0o696erDL080EC+/oyNyE1iC4Gz6TTquUxfsj6I8pTmRNErQfGbmtsFE697bCNblpa8gAK/h7QoxM4seJ09ToEiqdBY3G38fi00SlyeTvd1FlYfHgsZxYAdQ3mKyX3nmjV6kM7wAvOiIMEM1EvaJTgEJn6G6IcZKonKojTN041TRNROAVZyx6UwfuU6a1bcSxHef53Prb5j79Ai/rR5cAM7HK/PNx79IbpqT+b/kcNmxFHSspYZbhJClZrsVocQ64nQcjXZ50y37p+23Fr1iYuk1iNA5+y4H77H79FMdFmoInuI/NZF5de3dqSazleSgoe+4pxR7T4emkt8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e01cd10-440d-4de9-82d6-08d6ddc4ccc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:17:43.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIFttYWls
dG86c2hhd25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogVHVlc2RheSwgTWF5IDIxLCAyMDE5IDQ6
MDkgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogcm9i
aCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IEFpc2hl
bmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwu
YmFsdXRhQG54cC5jb20+OyBQZW5nDQo+IEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcm02NDogZHRzOiBpbXg4cXhw
OiBBZGQgZ3BpbyBhbGlhcw0KPiANCj4gT24gVHVlLCBNYXkgMTQsIDIwMTkgYXQgMDQ6NTc6MTdB
TSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg4UVhQIEdQSU8gYWxpYXMg
Zm9yIGtlcm5lbCBHUElPIGRyaXZlciB1c2FnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCA4ICsrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiA+IGluZGV4IGIxN2MyMmUuLjkyMzcwNWUg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5k
dHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNp
DQo+ID4gQEAgLTIyLDYgKzIyLDE0IEBADQo+ID4gIAkJbW1jMiA9ICZ1c2RoYzM7DQo+ID4gIAkJ
c2VyaWFsMCA9ICZhZG1hX2xwdWFydDA7DQo+ID4gIAkJbXUxID0gJmxzaW9fbXUxOw0KPiA+ICsJ
CWdwaW8wID0gJmxzaW9fZ3BpbzA7DQo+IA0KPiBPa2F5LCBpdCdzIGFscmVhZHkgb3V0IG9mIGFs
cGhhYmV0aWNhbCBvcmRlciwgYnV0IGxldCdzIG5vdCBtYWtlIGl0IHdvcnNlLg0KDQpTdXJlLCBq
dXN0IHNlbnQgb3V0IFYyIHBhdGNoLCBwbGVhc2UgaGVscCByZXZpZXcsIHRoYW5rcy4NCg0KQW5z
b24uDQoNCj4gDQo+IFNoYXduDQo+IA0KPiA+ICsJCWdwaW8xID0gJmxzaW9fZ3BpbzE7DQo+ID4g
KwkJZ3BpbzIgPSAmbHNpb19ncGlvMjsNCj4gPiArCQlncGlvMyA9ICZsc2lvX2dwaW8zOw0KPiA+
ICsJCWdwaW80ID0gJmxzaW9fZ3BpbzQ7DQo+ID4gKwkJZ3BpbzUgPSAmbHNpb19ncGlvNTsNCj4g
PiArCQlncGlvNiA9ICZsc2lvX2dwaW82Ow0KPiA+ICsJCWdwaW83ID0gJmxzaW9fZ3Bpbzc7DQo+
ID4gIAl9Ow0KPiA+DQo+ID4gIAljcHVzIHsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
