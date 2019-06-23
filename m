Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4583C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F1420820
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ajYz/Y7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFWLYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:24:48 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:54710
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfFWLYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ow1USR7TjW6eJ1VG46Zb9BRFxlEAgYfJgq52msIcGQ=;
 b=ajYz/Y7bGK7IpL5iINCr0DARA7DXlQb+V7LltxiRLxK5QAMoGl/IF90lgtTpvugkalNy/6TRL9TtdI7Au7wo145uZj7bWK5MVIytKs5OJb4IUbRFs/MS7291HvVc4f04c8nttDHQ2GSSdEZHEeGk0wWZ1GIPeqaojHR3GagoK+M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sun, 23 Jun 2019 11:24:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 11:24:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mq: Add system counter node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mq: Add system counter node
Thread-Index: AQHVKAsXvjXZswp9YUaGUA/T/OvzKqanug2AgAFhPfA=
Date:   Sun, 23 Jun 2019 11:24:44 +0000
Message-ID: <DB3PR0402MB39167752236F0DD5316F4AACF5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
 <20190621082838.12630-3-Anson.Huang@nxp.com>
 <6c632476-9ecd-d6cc-b543-a28576c06a0c@posteo.de>
In-Reply-To: <6c632476-9ecd-d6cc-b543-a28576c06a0c@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06466600-3e95-46b2-1d78-08d6f7cd6474
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899F73BC6AAA531382C66EBF5E10@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(13464003)(199004)(189003)(6506007)(53546011)(66476007)(2501003)(3846002)(68736007)(52536014)(446003)(11346002)(6116002)(6436002)(76176011)(256004)(476003)(2906002)(5660300002)(99286004)(110136005)(25786009)(7696005)(186003)(66066001)(71200400001)(55016002)(6246003)(71190400001)(229853002)(66946007)(305945005)(102836004)(33656002)(53936002)(8936002)(26005)(9686003)(73956011)(44832011)(316002)(8676002)(66556008)(7736002)(7416002)(14454004)(76116006)(4326008)(486006)(74316002)(478600001)(86362001)(81156014)(2201001)(81166006)(66446008)(64756008)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BS502TWMRMbdxHY32RYnUGEbh1gm6A4lPITY1CqjLZJt2dDiki/aqIr7vaI2ThVCS63k/PubdWcczhOtqYFoIQEpAsC+bWypoiN9iUQTPQ/BhOIaooZbcfhu1GooPSXJXwAQb+ocKlgKqH+vuLrh43W7RrVdUsyyA+ypj4nv8qPTRCsLA0PymhIaLRVhy+oGl+KaDYOO+s3Y51HHmFQL19bolevLy1D7exNjgLM8RvoYcKsr0Z9CgKS4MeyvxLZKMQVJLzi1XI09du3HUfV4BUtK+A/hbG+bbQlDdnNACZ/8//ekHMo9d4+ulQvWiC0Yw7k9DRLTntWr5hI8MCNT9P45NMjLTKcDdIL6v1lSCRFzTO006PKNk1DLZc5aSoDu0qDOmcQtPsgLsVMUp79trDmbR0sVaEf86xWDlGwE7sc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06466600-3e95-46b2-1d78-08d6f7cd6474
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 11:24:44.4252
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
MjIsIDIwMTkgMTA6MTYgUE0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29t
PjsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gdGdseEBsaW51dHJvbml4LmRlOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZl
c3RldmFtQGdtYWlsLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgQWJlbCBWZXNhDQo+IDxh
YmVsLnZlc2FAbnhwLmNvbT47IGNjYWlvbmVAYmF5bGlicmUuY29tOyBhbmd1c0Bha2tlYS5jYTsN
Cj4gYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tOyBhZ3hAc2lneGNwdS5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGFybTY0OiBkdHM6
IGlteDhtcTogQWRkIHN5c3RlbSBjb3VudGVyIG5vZGUNCj4gDQo+IE9uIDIxLjA2LjE5IDEwOjI4
LCBBbnNvbi5IdWFuZ0BueHAuY29tIHdyb3RlOg0KPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4gQWRkIGkuTVg4TVEgc3lzdGVtIGNvdW50ZXIgbm9k
ZSB0byBlbmFibGUgdGltZXItaW14LXN5c2N0ciBicm9hZGNhc3QNCj4gPiB0aW1lciBkcml2ZXIu
DQo+IA0KPiB3aXRoIHRoZXNlIGNoYW5nZXMgYW5kIFRJTUVSX0lNWF9TWVNfQ1RSIHNlbGVjdGVk
LCBJIGRvbid0IHNlZSBjcHVpZGxlDQo+IHdvcmtpbmcgeWV0ICh3aGljaCBpcyB3aGF0IEkgd2Fu
dCB0byBhY2hpZXZlIG9uIGlteDhtcSkuIE1pZ2h0IHRoZXJlIGJlIGENCj4gc3lzdGVtIGNvdW50
ZXIgY2xvY2sgZGVmaW5pdGlvbiBvciBhbnl0aGluZyBlbHNlIG1pc3Npbmc/DQoNCmkuTVg4TVEg
aXMgZGlmZmVyZW50IGFib3V0IHN5c3RlbSBjb3VudGVyIGVuYWJsZW1lbnQsIHdpdGggdGhpcyBw
YXRjaCBzZXJpZXMsDQpubyBuZWVkIHRvIGhhdmUgc3lzdGVtIGNvdW50ZXIgY2xvY2sgZGVmaW5p
dGlvbiwgdGhpcyBwYXRjaCBpcyBqdXN0IHRvIGVuYWJsZSB0aGUNCnN5c3RlbSBjb3VudGVyIGFz
IGJyb2FkY2FzdCB0aW1lciwgaXQgaXMgbmVjZXNzYXJ5IGZvciBmdXJ0aGVyIHN1cHBvcnQgb2Yg
Y3B1LWlkbGUsDQp0byBlbmFibGUgY3B1LWlkbGUsIGFub3RoZXIgRFQgcGF0Y2ggaXMgbmVlZGVk
IHRvIGFkZCBpZGxlIG5vZGUsIGJ1dCBhcyBmYXIgYXMgIEkNCmtub3csIEFiZWwgaXMgd29ya2lu
ZyBvbiB0aGUgd29ya2Fyb3VuZCBvZiB0aGUgaS5NWDhNUSBjcHUtaWRsZSwgSSBkb24ndCBrbm93
DQppZiBpdCBpcyBwaWNrZWQgdXAgb3IgTk9ULCBzbyBJIGJlbGlldmUgdGhlIGNwdS1pZGxlIHdp
bGwgYmUgZW5hYmxlZCBsYXRlciBmb3IgaS5NWDhNUQ0KYnkgQWJlbC4NCg0KVGhhbmtzLA0KQW5z
b24uDQoNCj4gDQo+IHRoYW5rcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXJ0
aW4NCj4gDQoNCg==
