Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E8C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247AD205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WrqNS/IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEFIm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:42:58 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:22290
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfEFIm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrLClPDmFFzYV7WkJUQASlMITI/BjdzrmHGemSvdd+g=;
 b=WrqNS/INc5/AjdfMrJZTyV2DhurFoapcwWxRTp/Xa54EQ+eVPt1uPBllkobm5wfDJN4FliQA56bhHgD3AnAusDKvIDDLH3z8qHolrUQtcSoynJvJHbalH/ANKLTwspCyB+X1ekQKKLuByl6w6HkU1UrG899OfEQp6gcIY39X5GI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5523.eurprd04.prod.outlook.com (20.178.113.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Mon, 6 May 2019 08:42:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 08:42:54 +0000
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
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Index: AQHVA0Zt0jza7L79NEWlMXlMGOglhqZdyLUw
Date:   Mon, 6 May 2019 08:42:54 +0000
Message-ID: <AM0PR04MB421175C951494A6F8E83917980300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
 <20190505134130.28071-4-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-4-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57bc14d-6277-44bc-0851-08d6d1fed4cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5523;
x-ms-traffictypediagnostic: AM0PR04MB5523:
x-microsoft-antispam-prvs: <AM0PR04MB55239050D62DF70B1BF7268580300@AM0PR04MB5523.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(476003)(86362001)(2201001)(486006)(44832011)(4326008)(3846002)(7416002)(99286004)(6246003)(54906003)(110136005)(6506007)(53546011)(316002)(66066001)(256004)(25786009)(53936002)(14454004)(5660300002)(186003)(74316002)(71190400001)(71200400001)(8676002)(81156014)(6436002)(2906002)(478600001)(68736007)(7736002)(81166006)(8936002)(33656002)(26005)(52536014)(66476007)(229853002)(64756008)(66556008)(76176011)(66946007)(66446008)(446003)(11346002)(2501003)(7696005)(102836004)(73956011)(305945005)(55016002)(6116002)(9686003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5523;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYVlG/ptSxhZ1yxL11ekxzFD2wFD1gKnuuJeHykUolXjZ7CnSZjdl8sJSedbqWmEwK8+616bSpdzM4OifcZlY6Iqm6NvA5CTl4rxixCVOlzkKgY7LPwsyqlPM2utkFyhiEUg0bqYhukH70YzqABrODvvNG5FyAWItvHHr9Muo83ZXcHMI6svZuAA70duh21//k+hI6imzNs2ynPmyxZQfMhNKyRVrQ265l7yc2vA3RGS7NkmZgx/YgTawgYAcsD4ftPm5lT5vWh7Ix2iVjogRwWTvRDT0PTXyEgurrziPmU0U5X1Drv9/x8VFfq3bIWXMF/0trbuW6c0E5/99i9zdj7KMG7fFZ5IMK6XVEikXEnPa1pFPjR4yxXnuR4G2eZOeDPa4R/abACyjuoeLby9PK74i51T9+IZtdSWJkNSifg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57bc14d-6277-44bc-0851-08d6d1fed4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 08:42:54.0890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbg0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDk6MjggUE0NCj4g
U3ViamVjdDogW1BBVENIIDQvNF0gYXJtNjQ6IGR0czogaW14OiBhZGQgaS5NWDhRWFAgb2NvdHAg
c3VwcG9ydA0KPiANCj4gQWRkIGkuTVg4UVhQIG9jb3RwIG5vZGUNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz4NCj4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+
DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBTYXNjaGEgSGF1
ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBQZW5ndXRyb25peCBLZXJuZWwgVGVh
bSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KPiBDYzogTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPg0KPiBD
YzogQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gQ2M6IEFuc29uIEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0
YUBueHAuY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC5kdHNpDQo+IGluZGV4IDA2ODNlZTJhNDhhZS4uZjI5OTk4ZDcyNzRhIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+IEBAIC0x
NDEsNiArMTQxLDEyIEBADQo+ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWlvbXV4YyI7
DQo+ICAJCX07DQo+IA0KPiArCQlvY290cDogaW14OHF4LW9jb3RwIHsNCj4gKwkJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg4cXhwLW9jb3RwIjsNCj4gKwkJfTsNCg0KU2VlIG15IHJlcGx5IG9uIFBhdGNo
IFsxLzRdDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+ICsNCj4gIAkJcGQ6IGlteDhxeC1w
ZCB7DQo+ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjdS1wZCI7DQo+ICAJCQkjcG93
ZXItZG9tYWluLWNlbGxzID0gPDE+Ow0KPiAtLQ0KPiAyLjE2LjQNCg0K
