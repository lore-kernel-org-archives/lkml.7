Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665EAC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCB20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VZ1oHWJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFWLUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:20:40 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:21984
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfFWLUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NllZTFARPBiLY5Ad+Gn0ez9Ow5idh95H78uOc3HLrG4=;
 b=VZ1oHWJZDm0K6Yel+lNvz179U9+FfZv2wzp22DJcbwKfV74qd7QBqIl03hRL5Pu1q2+jd/V5lDuh02WyuK5IgHKnxBjtlv5b8gDgdcSgLKRYE1wVeOYzhd/CMYEpaWHEaSp3WvptQLTDU0f/fe0LpgWeRvQtiNj3RGlD8DuQqsk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sun, 23 Jun 2019 11:20:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 11:20:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/4] arm64: dts: imx8mm: Add system counter node
Thread-Topic: [PATCH 4/4] arm64: dts: imx8mm: Add system counter node
Thread-Index: AQHVJ/+/0SOBOWGUd0q/sAmaJpF3+6anlvCAgAGD/jA=
Date:   Sun, 23 Jun 2019 11:20:34 +0000
Message-ID: <DB3PR0402MB39164587E2F6F56DBB47BCE2F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190621070720.12395-4-Anson.Huang@nxp.com>
 <9f411a1c-50d2-e26b-a4e6-83e02b626378@posteo.de>
In-Reply-To: <9f411a1c-50d2-e26b-a4e6-83e02b626378@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8feae21b-1f88-4472-bac9-08d6f7cccfa9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB38996365D3EBF2A84A5120C1F5E10@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(13464003)(199004)(189003)(6506007)(53546011)(66476007)(2501003)(3846002)(68736007)(52536014)(446003)(11346002)(6116002)(6436002)(76176011)(256004)(476003)(2906002)(5660300002)(99286004)(110136005)(25786009)(7696005)(186003)(66066001)(71200400001)(55016002)(6246003)(71190400001)(229853002)(66946007)(305945005)(102836004)(33656002)(53936002)(8936002)(26005)(9686003)(73956011)(44832011)(316002)(8676002)(66556008)(7736002)(7416002)(14454004)(76116006)(4326008)(486006)(74316002)(478600001)(86362001)(81156014)(2201001)(81166006)(66446008)(64756008)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NxgQWbB5WrEz7EaW/3PVZ3s9P2bwHnvQURvM5Itr8NOAtmo0X9hCMDtsuYmGBUa1cg8YJTDYbMy5dV6MkAyKWFkDuYjk812RM8kaT3qUcp6WmAkVQvNP04aXUzCfBM3RcpVllZlZWyxraSSNPF3vb2Y9eUm6kumyfVDayadeUygVPWDzwRkvFPWJpM8MXxWBb4rQsXoLfPtBxIOB2y9CFwJ0DaSLpBBYGvm6HMTvNBtHCwVDYNTONiIPopV+hvidbew8fCztY4qSLOBX+197iegyGMVgYrEqj7dqBm/efcTNo/JRWkldVTNfgx4CkAfiY2FBx7jfEmw+qwEvv+TfFT0t35PT/a9F7R29wlNB5LXwMdsMFgW4SGzvg8+EskKqZzVIHlIkzowLEJD8yNOYr9pnZk/6RKr3K98KlK/tvpI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feae21b-1f88-4472-bac9-08d6f7cccfa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 11:20:34.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcnRpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcnRp
biBLZXBwbGluZ2VyIDxtYXJ0aW5rQHBvc3Rlby5kZT4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUg
MjIsIDIwMTkgODoxMCBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+
OyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnOyByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFt
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGtlcm5lbC5vcmc7DQo+
IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBBaXNoZW5nIERvbmcN
Cj4gPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsg
RGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+OyBBYmVsIFZlc2ENCj4gPGFiZWwudmVzYUBueHAuY29tPjsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDQvNF0gYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgc3lzdGVtIGNvdW50ZXIg
bm9kZQ0KPiANCj4gT24gMjEuMDYuMTkgMDk6MDcsIEFuc29uLkh1YW5nQG54cC5jb20gd3JvdGU6
DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4NCj4gPiBB
ZGQgaS5NWDhNTSBzeXN0ZW0gY291bnRlciBub2RlIHRvIGVuYWJsZSB0aW1lci1pbXgtc3lzY3Ry
IGJyb2FkY2FzdA0KPiA+IHRpbWVyIGRyaXZlci4NCj4gPg0KPiANCj4gDQo+IGRvIHdlIG5lZWQg
c2ltaWxhciBhZGRpdGlvbnMgdG8gaW14OG1xPyBJZiBzbywgSSB0aGluayB0aGVzZSB3b3VsZCBm
aXQgaW4gaGVyZQ0KPiB0b28uDQoNCmkuTVg4TVEgaGFzIHNvbWV0aGluZyBkaWZmZXJlbnQgYWJv
dXQgc3lzdGVtIGNvdW50ZXIgZHJpdmVyIGVuYWJsZW1lbnQsIEkgZGlkDQppdCBpbiBhbm90aGVy
IHBhdGNoIHNlcmllcy4NCg0KQW5zb24uDQoNCj4gDQo+IHRoYW5rcywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtYXJ0aW4NCg0K
