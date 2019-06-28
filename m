Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E81C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DA92147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hKTRZylD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfF1GRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:17:07 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:37565
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfF1GRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Otidic48NaX7uFm0CLUqjtm4OAKPL0s2t8BR6VoEfM=;
 b=hKTRZylDYqFaT3Nl+sxnQNDmlsp6d0GT5fY+jIvl4uUhjCGgJ123iO5A7cONg1a43ULK42ed8aUllFeDcpsFgxYNlQcDG8NaNrwz1RBKWtZtUijx0L/n9ykm2eM/Pjo5i9jXs5E20BPMn60F2CRIkf1QDFZDptVWrhKeIkE3VGc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 06:17:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 06:17:03 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: imx8mm: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLHg6KdHi+3c0WVoeANpMOeYKawly3g
Date:   Fri, 28 Jun 2019 06:17:02 +0000
Message-ID: <DB3PR0402MB39167143DD42C6A76B2A2A7BF5FC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
 <20190628032800.8428-2-Anson.Huang@nxp.com>
 <VI1PR04MB50555399D8A3E4890D8C91E6EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB50555399D8A3E4890D8C91E6EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f195e96d-962b-4bb8-4662-08d6fb903c9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-microsoft-antispam-prvs: <DB3PR0402MB386521395D4831DE55E24A07F5FC0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(13464003)(478600001)(186003)(102836004)(316002)(26005)(110136005)(6246003)(54906003)(229853002)(11346002)(476003)(99286004)(8676002)(4326008)(8936002)(53936002)(81156014)(9686003)(55016002)(7696005)(44832011)(81166006)(6436002)(446003)(14444005)(6506007)(53546011)(256004)(76176011)(33656002)(68736007)(2501003)(74316002)(66066001)(305945005)(71190400001)(486006)(3846002)(6116002)(7736002)(14454004)(25786009)(52536014)(66446008)(76116006)(71200400001)(66476007)(66556008)(64756008)(66946007)(73956011)(5660300002)(7416002)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7aHZv2Z+/LQt2E4z6FNrLKUi+ryzGj/FHSH41Q6EbbDI6o5Glfzg65pIi1nlV+TNQC1sglHGChE/4zj0dw8CfnXvUXGWHcecpg+GKxGbivsH2I8DfGInpo6WzjzHSGQX5LSgM4hs0WXCK1cIurrJD15i14JoTukl0BxJzMRsttr9EQHNIjVm5G1XetEmMFcKUaDLqU+5jNPb1zya4xusJiU86jH4NUxW1CrfAvapkIXD4HF9qGqqc6kKC7f4FtrmKzD3z+cJIQ6KZloeiHKtlxEBkECRcQq9we06NTVCurOy88iX+wK7PUempNiUa1N8XL9VhK4WXgTBqBlyBElNkaBHKVfkXeDmQl2OkYFOhvgmRjk9LWR2WIwlM2z2kGdOYXpV3uA9DCACyRb1edzZ7RWEXY1LegdLVQA18qimPlU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f195e96d-962b-4bb8-4662-08d6fb903c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:17:02.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9u
YXJkIENyZXN0ZXoNCj4gU2VudDogRnJpZGF5LCBKdW5lIDI4LCAyMDE5IDI6MDEgUE0NCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBu
eHAuY29tPjsNCj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5j
b207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFs
dXRhQG54cC5jb20+OyBBYmVsDQo+IFZlc2EgPGFiZWwudmVzYUBueHAuY29tPjsgYW5kcmV3LnNt
aXJub3ZAZ21haWwuY29tOw0KPiBjY2Fpb25lQGJheWxpYnJlLmNvbTsgYW5ndXNAYWtrZWEuY2E7
IGFneEBzaWd4Y3B1Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMi8yXSBhcm02NDogZHRzOiBpbXg4bW06IENvcnJlY3QgT1BQIHRhYmxlIGFjY29yZGlu
ZyB0bw0KPiBsYXRlc3QgZGF0YXNoZWV0DQo+IA0KPiBPbiAyOC4wNi4yMDE5IDA2OjM3LCBBbnNv
bi5IdWFuZ0BueHAuY29tIHdyb3RlOg0KPiANCj4gPiBBY2NvcmRpbmcgdG8gbGF0ZXN0IGRhdGFz
aGVldCAoUmV2LjAuMiwgMDQvMjAxOSkgZnJvbSBiZWxvdyBsaW5rcywNCj4gPiAxLjhHSHogaXMg
T05MWSBhdmFpbGFibGUgZm9yIGNvbnN1bWVyIHBhcnQsIHNvIHRoZSBtYXJrZXQgc2VnbWVudCBi
aXRzDQo+ID4gZm9yIDEuOEdIeiBvcHAgc2hvdWxkIE9OTFkgYXZhaWxhYmxlIGZvciBjb25zdW1l
ciBwYXJ0IGFjY29yZGluZ2x5Lg0KPiA+DQo+ID4gICAJCQlvcHAtaHogPSAvYml0cy8gNjQgPDE4
MDAwMDAwMDA+Ow0KPiA+ICAgCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsNCj4gPiAgIAkJ
CS8qIENvbnN1bWVyIG9ubHkgYnV0IHJlbHkgb24gc3BlZWQgZ3JhZGluZyAqLw0KPiA+IC0JCQlv
cHAtc3VwcG9ydGVkLWh3ID0gPDB4OD4sIDwweDc+Ow0KPiA+ICsJCQlvcHAtc3VwcG9ydGVkLWh3
ID0gPDB4OD4sIDwweDM+Ow0KPiANCj4gT25seSBjb25zdW1lciBwYXJ0cyBzaG91bGQgYmUgZnVz
ZWQgZm9yIHRoaXMgaGlnaGVzdCBPUFAuIElmIHlvdSBkb24ndCB3YW50DQo+IHRvIHJlbHkgb24g
dGhpcyB0aGVuIG1heWJlIGFsc28gZGVsZXRlIHRoZSBjb21tZW50IGFib3ZlPw0KDQpBcyBJIHJl
cGxpZWQgaW4gcHJldmlvdXMgaS5NWDhNUSBwYXRjaCwgaWYgdGhlIGNvbW1lbnRzIG1ha2UgcmVh
ZGVyIGNvbmZ1c2VkLA0Kc2hvdWxkIHdlIGp1c3QgcmVtb3ZlIGFsbCB0aG9zZSBjb21tZW50cz8N
Cg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IGxlb25hcmQNCg==
