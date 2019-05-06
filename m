Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5FEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48F9208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YEvhT10T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEFJbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:31:05 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:26947
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbfEFJbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC/cFJe9bWpyKSyWzsX3KnISGZwavHFLktEdHfdzFy4=;
 b=YEvhT10TjlpVE7KBnJVVWRk7QbZrPl6S/Zz3BytV5jwfWbZpF/dzvQOaO9EcVaasUpIEf6QEHv6XNC13JtUyMa3+8bLm9z3O64cW4U9r8YKRAnJljJv+M8tQaKxyqIZrpP2gTiRKRYZM7xyqG72AyDZG544YJe7DGqJhOvwqyCw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 09:31:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:31:00 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mm: add clock for GPIO node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mm: add clock for GPIO node
Thread-Index: AQHVA+yl5ZkIsxfnhUGvGrmTJZdnZaZd1OQg
Date:   Mon, 6 May 2019 09:31:00 +0000
Message-ID: <AM0PR04MB4211EC52A3A2974BFD9A190380300@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
 <1557133994-5061-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557133994-5061-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04cdd554-7920-4ad3-81aa-08d6d2058cf3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4865;
x-ms-traffictypediagnostic: AM0PR04MB4865:
x-microsoft-antispam-prvs: <AM0PR04MB4865C5F22AE6B4EDDD5C927080300@AM0PR04MB4865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(86362001)(478600001)(8676002)(110136005)(446003)(33656002)(256004)(2201001)(66066001)(81156014)(8936002)(5660300002)(6116002)(53936002)(81166006)(55016002)(68736007)(4326008)(71190400001)(2906002)(76176011)(99286004)(7696005)(6246003)(71200400001)(14454004)(186003)(6436002)(102836004)(53546011)(6506007)(229853002)(26005)(3846002)(9686003)(316002)(7736002)(11346002)(7416002)(52536014)(64756008)(66556008)(476003)(66476007)(66446008)(76116006)(2501003)(66946007)(74316002)(305945005)(73956011)(486006)(25786009)(44832011)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4865;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1VUhdxw53eTrgiW6Tg4NytGueyyfdyQrZxoklCIhFzmxSbB96vXllNs8k7S+YjhOULQZZ3GSe0aapzvbXLn1A9yPF8x4Uvan2s7T1bBV3tuNlNOzqxbS0xNMuY2c4Rrv/ix+1dftccJfxRq8OA+ISKOVsqjr3gyDztMH77fTfcq9tdhfvaoVOvq50oXLdWaKvXBZEVSqbOatB31kevNDbPBYr4oxOBMlix/t/2xaw1iK8CbCDiqEYDXerdVcNnuU9AQ8BomjrD/ylWM4/c0WffkfQzZ2gljwB3tdw8oHg8zTyiE7dX1YbyIncYM+4dT5Qmb4Yrz+cMciEgU1T5Cv3an9CgUj5duUoCGACnNxOYXmA9/qF18wRavtIZWa9TrvfZ4gFRN4x+PATyOsxkMdIuSkNwmpb25UVawyTH5/X40=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cdd554-7920-4ad3-81aa-08d6d2058cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:31:00.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBNb25kYXksIE1heSA2LCAyMDE5IDU6MTggUE0N
Cj4gU3ViamVjdDogW1BBVENIIDMvM10gYXJtNjQ6IGR0czogaW14OG1tOiBhZGQgY2xvY2sgZm9y
IEdQSU8gbm9kZQ0KPiANCj4gaS5NWDhNTSBoYXMgY2xvY2sgZ2F0ZSBmb3IgZWFjaCBHUElPIGJh
bmssIGFkZCBjbG9jayBpbmZvIHRvIEdQSU8gbm9kZSBmb3INCj4gY2xvY2sgbWFuYWdlbWVudC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bW0uZHRzaSB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNp
DQo+IGluZGV4IDZiNDA3YTk0Li5mMzJkNGU5IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBAQCAtMjA2LDYgKzIwNiw3IEBADQo+ICAJCQkJcmVn
ID0gPDB4MzAyMDAwMDAgMHgxMDAwMD47DQo+ICAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDY0
IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiAgCQkJCQkgICAgIDxHSUNfU1BJIDY1IElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfR1BJTzFfUk9P
VD47DQo+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiAgCQkJCSNncGlvLWNlbGxzID0gPDI+Ow0K
PiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiBAQCAtMjE3LDYgKzIxOCw3IEBADQo+ICAJ
CQkJcmVnID0gPDB4MzAyMTAwMDAgMHgxMDAwMD47DQo+ICAJCQkJaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDY2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiAgCQkJCQkgICAgIDxHSUNfU1BJIDY3IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfR1BJ
TzJfUk9PVD47DQo+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiAgCQkJCSNncGlvLWNlbGxzID0g
PDI+Ow0KPiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiBAQCAtMjI4LDYgKzIzMCw3IEBA
DQo+ICAJCQkJcmVnID0gPDB4MzAyMjAwMDAgMHgxMDAwMD47DQo+ICAJCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDY4IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiAgCQkJCQkgICAgIDxHSUNfU1BJ
IDY5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9D
TEtfR1BJTzNfUk9PVD47DQo+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiAgCQkJCSNncGlvLWNl
bGxzID0gPDI+Ow0KPiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiBAQCAtMjM5LDYgKzI0
Miw3IEBADQo+ICAJCQkJcmVnID0gPDB4MzAyMzAwMDAgMHgxMDAwMD47DQo+ICAJCQkJaW50ZXJy
dXB0cyA9IDxHSUNfU1BJIDcwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiAgCQkJCQkgICAgIDxH
SUNfU1BJIDcxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwmY2xrIElN
WDhNTV9DTEtfR1BJTzRfUk9PVD47DQo+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiAgCQkJCSNn
cGlvLWNlbGxzID0gPDI+Ow0KPiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiBAQCAtMjUw
LDYgKzI1NCw3IEBADQo+ICAJCQkJcmVnID0gPDB4MzAyNDAwMDAgMHgxMDAwMD47DQo+ICAJCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDcyIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KPiAgCQkJCQkg
ICAgIDxHSUNfU1BJIDczIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWNsb2NrcyA9IDwm
Y2xrIElNWDhNTV9DTEtfR1BJTzVfUk9PVD47DQo+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KPiAg
CQkJCSNncGlvLWNlbGxzID0gPDI+Ow0KPiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiAt
LQ0KPiAyLjcuNA0KDQo=
