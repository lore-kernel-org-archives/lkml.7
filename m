Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E47C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814CE2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XV/qNoVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGDIA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:00:29 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:54063
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfGDIA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Os2M1u4hQFlUUZir5WG6cu5oF/YNz5e4IzKf5ru3hA=;
 b=XV/qNoVv0eEDPHrJ7os5NpML4t7YVkZz1DfCFCrOOEj6Cdh+i31ww8sV4yV2/bbiyo7vTC7pN4e3VClSjDJYjObLoxHr8ML8/Bs7r/kk2GTtMKzeMkSAFz5LV+r3bhHstTlDzpP43aSKlRDhZdbluJrONRUOMNf2PZ/3N00rpJ8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 08:00:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 08:00:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
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
Subject: RE: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend opp
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Assign highest opp as suspend
 opp
Thread-Index: AQHVMjD62bccyXxndUyDszIpSDkBnaa6F2SA
Date:   Thu, 4 Jul 2019 08:00:24 +0000
Message-ID: <DB3PR0402MB39165D27F23501EE358DE607F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f97e96a1-60ef-4b23-f80b-08d70055abce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-antispam-prvs: <DB3PR0402MB37385D5D32BA1619C0B548E9F5FA0@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(8676002)(99286004)(229853002)(102836004)(66066001)(76176011)(7696005)(53546011)(25786009)(54906003)(6506007)(110136005)(3846002)(6116002)(33656002)(14454004)(7416002)(7736002)(305945005)(186003)(4326008)(8936002)(316002)(15650500001)(2906002)(81166006)(81156014)(478600001)(74316002)(26005)(68736007)(2501003)(71200400001)(71190400001)(53936002)(6246003)(66556008)(66946007)(76116006)(66446008)(66476007)(64756008)(73956011)(5660300002)(55016002)(486006)(44832011)(86362001)(52536014)(9686003)(6436002)(256004)(14444005)(446003)(11346002)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sSACyW0V1pdegfYmDUfMLyW7K29iXC8f2vzGlbt4SxRekcCRm34M++/kyxkisjUtYV3nSkV2cTkXHDDiYoWSBzTxdG9rCyLJACd/2aa66quUtNbaqDZ+VyBomXf5/eq+U7SEvYlxBhW9s5T0D6svscgCdYZY+jlUujDAIcBvLjw3AC2E12Av8Xc7cIFtzocUFmkrNJIGYXt1MSd+K3v/4B3Fq1gBplOET9ClPaPxCP1rsNLjbSHY+sLRFdSraqptJgjTtnXIJNKHH9qgr2Z5AyiSpn2Vp0+YqsJjxcSlnLZhalspzcRwZRuwZvr+XhE6TrseeoG+t3VoGlC6Ub0M8/K8PtIJQXHZMG3SLMvYxKApyqCJ2CkGwi8fls9o1lrF/+J35IbFcomVPGds/MJijDYENvTG7Lm6c7w9TfcS6Bs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97e96a1-60ef-4b23-f80b-08d70055abce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 08:00:24.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiBPbiA3LzQvMjAxOSA5OjIzIEFNLCBBbnNvbi5IdWFuZ0BueHAuY29t
IHdyb3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
DQo+ID4gQXNzaWduIGhpZ2hlc3QgT1BQIGFzIHN1c3BlbmQgT1BQIHRvIHJlZHVjZSBzdXNwZW5k
L3Jlc3VtZSBsYXRlbmN5IG9uDQo+ID4gaS5NWDhNTS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAxICsNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IGluZGV4IGIxMWZjNWUuLjNhNjI0MDcgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IEBA
IC0xMzYsNiArMTM2LDcgQEANCj4gPiAgIAkJCW9wcC1taWNyb3ZvbHQgPSA8MTAwMDAwMD47DQo+
ID4gICAJCQlvcHAtc3VwcG9ydGVkLWh3ID0gPDB4OD4sIDwweDM+Ow0KPiA+ICAgCQkJY2xvY2st
bGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KPiA+ICsJCQlvcHAtc3VzcGVuZDsNCj4gPiAgIAkJfTsN
Cj4gPiAgIAl9Ow0KPiANCj4gV2hhdCBpZiB0aGUgaGlnaGVzdCBPUFAgaXMgdW5hdmFpbGFibGUg
ZHVlIHRvIHNwZWVkIGdyYWRpbmc/IElkZWFsbHkgd2UNCj4gc2hvdWxkIGZpbmQgYSB3YXkgdG8g
c3VzcGVuZCBhdCB0aGUgaGlnaGVzdCAqc3VwcG9ydGVkKiBPUFAuDQo+IA0KPiBNYXliZSB0aGUg
b3BwLXN1c3BlbmQgbWFya2luZyBjb3VsZCBiZSBhc3NpZ25lZCBmcm9tIGlteC1jcHVmcmVxLWR0
DQo+IGRyaXZlciBjb2RlPw0KDQpZZXMsIHRoaXMgaXMgYWxzbyBteSBjb25jZXJuLCB0aGUgY3Vy
cmVudCBPUFAgZHJpdmVyIGRvZXMgTk9UIGhhbmRsZSBpdCB3ZWxsLCBhbmQNCkkgd2FzIHRoaW5r
aW5nIHRvIGFzc2lnbmUgaXQgZnJvbSBpbXgtY3B1ZnJlcS1kdCBkcml2ZXIsIDEgb3B0aW9uIGlz
IHRvIHJ1bnRpbWUgYWRkDQoic3VzcGVuZC1vcHAiIHByb3BlcnR5IGludG8gRFQgT1BQIG5vZGUg
YWZ0ZXIgcGFyc2luZyB0aGUgc3BlZWQgZ3JhZGluZyBmdXNlIGFuZA0KT1BQIHRhYmxlLCBidXQg
SSBkbyBOT1QgbGlrZSB0aGF0IHZlcnkgbXVjaCwgYXMgd2UgbmVlZCB0byBtYW51YWxseSBjcmVh
dGUgYSBwcm9wZXJ0eSwNCnRoZSBvdGhlciBvcHRpb24gaXMgdG8gY2hhbmdlIGNwdSBmcmVxIHBv
bGljeSBpbnNpZGUgaW14LWNwdWZyZXEtZHQgZHJpdmVyIGluIHN1c3BlbmQvcmVzdW1lDQpjYWxs
YmFjaz8gV2hpY2ggb25lIGRvIHlvdSBwcmVmZXI/DQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+
IC0tDQo+IFJlZ2FyZHMsDQo+IExlb25hcmQNCg0K
