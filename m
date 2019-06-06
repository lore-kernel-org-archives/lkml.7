Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8FC28D18
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9782070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KJVONeQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFFBOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:14:41 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:21623
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfFFBOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7SEToEJJk2tohfv8HDvE6EhVhuGjgXvv5ERpyz5nAY=;
 b=KJVONeQVlSf24n6pHrvHIt1EAsRLzi0mJvKUEBRIHLzlHFljbmNpokh6XW8ShlQUnEWjMC/Ilcob19IGptF5Zq7bbc+sHc9l8sFjj7lz38hgLxU3/ES+vcyMhRuEHV1GINYFzuHXqkbTLcmhB+AP9XEuI6Uh59LQ7M/BSyMVHJ8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 01:14:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 01:14:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>, Jacky Bai <ping.bai@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/4] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Topic: [PATCH V3 1/4] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Thread-Index: AQHVGnjyIW8h9e1Tqk6HjR2Mb0HIlaaNuSkAgAAcJNA=
Date:   Thu, 6 Jun 2019 01:14:33 +0000
Message-ID: <DB3PR0402MB39165AC38B4F45CE74F57EE7F5170@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
 <20190605233319.06CE62083E@mail.kernel.org>
In-Reply-To: <20190605233319.06CE62083E@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b76c38a-8ff6-4666-ffa8-08d6ea1c557e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-antispam-prvs: <DB3PR0402MB375610293996416E4B0349BEF5170@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(13464003)(14454004)(2906002)(486006)(52536014)(316002)(2201001)(44832011)(478600001)(86362001)(229853002)(256004)(5660300002)(6116002)(3846002)(33656002)(66066001)(2501003)(476003)(8936002)(7416002)(25786009)(446003)(8676002)(81166006)(81156014)(68736007)(110136005)(6246003)(76176011)(11346002)(7696005)(102836004)(4326008)(53546011)(53936002)(99286004)(6506007)(305945005)(6436002)(55016002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(9686003)(76116006)(186003)(26005)(74316002)(7736002)(71200400001)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qed25KPv3TR+adJr8X1R6gAoYpR5Gk1/uwD12BW4+nQWaPqu55XKm2aVNG4Lfyo4brvWSl/7p9Y5pN6mxHxDzkcfmRqe5kL0/vWj8nUcKb67qAudx3yhGLQGL9Vl8s4SWpWGDocYBY/j660EJFrrUaSf5nMlgHkVLA2pGb4CnVmM5gCW4+8xYaqOXyvNGvFPz2dnud00crJsaEYpjlAgiQ44VhGzQwI2SvZwx36x5y8vG67SH2S/FykqugjKSQhL352IpMXj0WYX/FSde6/Ykai3hMCocNlSqgnDpuSJU+LeUnvwhkeHF8Taile2xx1YysMkcmTW7SlFhuYbXMCbAFY2vj295IwrFh/pBqzdfc1ZvaZfKBy1UAEMQk7tjQfzhuvlQ8YNZ+XBCKYCKVYY1MBiOVrCmtOF5jy9yI/unp8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b76c38a-8ff6-4666-ffa8-08d6ea1c557e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 01:14:33.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDYsIDIw
MTkgNzozMyBBTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBBYmVs
IFZlc2ENCj4gPGFiZWwudmVzYUBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdA
bnhwLmNvbT47DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBjYXRhbGluLm1hcmluYXNA
YXJtLmNvbTsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGRpbmd1eWVuQGtlcm5lbC5v
cmc7DQo+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29t
Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IExlb25h
cmQgQ3Jlc3Rleg0KPiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBjbGtAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbWF4aW1l
LnJpcGFyZEBib290bGluLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IG9sb2ZAbGl4b20u
bmV0Ow0KPiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7
DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHdpbGwuZGVh
Y29uQGFybS5jb20NCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS80XSBkdC1iaW5kaW5nczogaW14OiBBZGQgY2xvY2sgYmlu
ZGluZyBkb2MgZm9yDQo+IGkuTVg4TU4NCj4gDQo+IFF1b3RpbmcgQW5zb24uSHVhbmdAbnhwLmNv
bSAoMjAxOS0wNi0wMyAxODo1OToyNSkNCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCB0aGUgY2xvY2sgYmluZGluZyBkb2MgZm9yIGkuTVg4
TU4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2VzLg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jbG9jay9pbXg4bW4tY2xvY2sudHh0ICAgICB8ICAyOSArKysNCj4gDQo+
IENhbiB0aGlzIGJlIHlhbWw/DQoNCk9LLCBJIHdpbGwgdHJ5IHRvIHVzZSB5YW1sIGluIFY0Lg0K
DQpUaGFua3MsDQpBbnNvbi4NCg0KPiANCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9p
bXg4bW4tY2xvY2suaCAgICAgICAgICAgfCAyMTUNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjQ0IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg4bW4tDQo+
IGNsb2NrLnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9pbXg4bW4tY2xvY2suaA0KPiA+DQo=
