Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B4218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VKWgrt7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfCONdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:33:40 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:26275
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfCONdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziucn0v+rYp1uYeWhWZRDCSWI7/6pgArmaQJDlrUvgc=;
 b=VKWgrt7uOeS+vtF/gxkfrr0YAkdUTyltpdmrS6lIOVfMGdE4iFdwCGTYYjyHIWiVmw++IXOEnFPTtfPxa5d21ZB+1Rpml3JWSbNg5cqXMAgQu3ksU086wQ+nymcEIqZ5DxluJIyXpibdUwTQULBa36tNCQJuNbYqJPAULRI/S1M=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4435.eurprd04.prod.outlook.com (52.135.150.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 13:33:32 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 13:33:32 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Patrick Wildt <patrick@blueri.se>
CC:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Thread-Topic: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Thread-Index: AQHU0ziyUrOqOGzNAUGITeZr+qRjmqX9Xs+AgAE2d4CAA0ucgIAFxWYAgADawACABD2OYA==
Date:   Fri, 15 Mar 2019 13:33:31 +0000
Message-ID: <AM0PR04MB42112ECD22C474CE71C8D9B680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
 <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com>
 <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175>
 <155205894567.20095.2782332899458282059@swboyd.mtv.corp.google.com>
 <20190312073654.GA85609@thor.local>
 <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com>
In-Reply-To: <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42194bd6-1975-4ed8-76be-08d6a94ad115
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4435;
x-ms-traffictypediagnostic: AM0PR04MB4435:
x-microsoft-antispam-prvs: <AM0PR04MB4435B815EC76352D1891DCAA80440@AM0PR04MB4435.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(4326008)(71190400001)(86362001)(76176011)(6116002)(33656002)(3846002)(478600001)(7696005)(486006)(6436002)(102836004)(105586002)(106356001)(14454004)(476003)(8676002)(74316002)(81156014)(305945005)(7416002)(68736007)(7736002)(44832011)(81166006)(256004)(11346002)(93886005)(6246003)(8936002)(2906002)(71200400001)(5660300002)(53936002)(229853002)(6506007)(54906003)(110136005)(99286004)(26005)(97736004)(9686003)(316002)(186003)(66066001)(55016002)(446003)(14444005)(52536014)(25786009)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4435;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eqEM/TKuEKceSgT+28GaQQ72VrMLQX19DGJxW0PAC/xl/4bjVvWN5AUYYqdusntVa58VwzFKMN+wdPqIKKG/7VuYAS7+CFiQi1eQBOSW0gxAr/Teqvwl0dCCKJbBEcVxh9UX3fj3Ip8ViZ3SCC5u2rX4bKu+vP2B8PqS0wFmUUNieeEV3lEQBQS+KbG3xd2IEVRsKPbh8fms7BNI6Kj845dxjri8r2vomaJ6FWSdnfXKjoLpPHvwcjb3x2Mgv9ybk+nxBRMew3DaWq9wjXhsjZwBA4dmIEY0w5PS8xELZzntQeCaGlTdaUSXiS9vP7hl7tJ5Hssuiw3VBbiaZ1ZJplH1vVGBFjBRLD+gVctzs+e9tMKrZ0yeLxFABCOixPAM1MiOaGF4Cz9IBXHSdyEpf6PHCXXM3ZPK5XzvapZG2LU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42194bd6-1975-4ed8-76be-08d6a94ad115
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 13:33:31.9382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiANCj4gUXVv
dGluZyBQYXRyaWNrIFdpbGR0ICgyMDE5LTAzLTEyIDAwOjM2OjU0KQ0KPiA+IE9uIEZyaSwgTWFy
IDA4LCAyMDE5IGF0IDA3OjI5OjA1QU0gLTA4MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiA+
IEl0J3MgbW9zdGx5IGFib3V0IG1ha2luZyBzdXJlIHRoYXQgYW55IGV4aXN0aW5nIGR0YnMgZG9u
J3QgaGF2ZQ0KPiA+ID4gdGhlaXIgbnVtYmVycyBzaGlmdGVkIGFyb3VuZC4gU28gaG9wZWZ1bGx5
IGFueSBvdmVybGFwcGluZw0KPiA+ID4gaWRlbnRpZmllcnMgYXJlbid0IGluIHVzZSB5ZXQgYW5k
IHRoZW4gdGhvc2UgaWRzIGNhbiBiZSBjaGFuZ2VkDQo+ID4gPiB3aGlsZSBsZWF2aW5nIHRoZSBv
bmVzIHRoYXQgYXJlIGluIHVzZSBob3cgdGhleSBhcmUuDQo+ID4NCj4gPiBJbiBwcmFjdGljZSBJ
IGJldCBubyBvbmUgdXNlcyBMaW51eCA1LjAncyBpLk1YOE0gZGV2aWNlIHRyZWVzIHNpbmNlDQo+
ID4gdGhleSBsYWNrIHRvbyBtdWNoIHN1cHBvcnQuICBJdCdzIHNvIGJhc2ljIGl0J3Mgbm90IHVz
ZWZ1bC4gIFlvdSdkDQo+ID4gc3RpbGwgcnVuIHlvdXIgZXhpc3Rpbmcgbm9uLW1haW5saW5lIGJp
bmRpbmdzIHVudGlsIGl0IGlzLiAgVGh1cyBJDQo+ID4gd291bGQgYXJndWUgY2hhbmdpbmcgdGhl
IEFCSSByaWdodCBub3cgd291bGQgYmUgdGhlIG9ubHkgY2hhbmNlIHRoZXJlIGlzLg0KPiA+DQo+
ID4gSWYgeW91IHRoaW5rIHRoYXQgY2hhbmNlIGlzIGdvbmUsIHRoZW4gSSBndWVzcyB0aGUgcmVh
c29uYWJsZSB0aGluZyBpcw0KPiA+IHRvIGtlZXAgdGhlIG51bWJlcnMgYW5kIG9ubHkgbW92ZSB0
aG9zZSAodG8gdGhlIGVuZCkgd2hpY2ggb3ZlcmxhcC4NCj4gPiBPciBwdXQgdGhlbSBpbnRvIHRo
YXQgZXJyZW5lb3VzIG51bWJlciBnYXAuDQo+ID4NCj4gDQo+IFRoZSBjaGFuY2UgaXMgcXVpY2ts
eSBzbGlwcGluZyBhd2F5IGJlY2F1c2Ugd2UncmUgZ29pbmcgdG8gYmUgYXQgLXJjMSBzb29uLiBJ
J20NCj4gbm90IHRoZSBvbmUgdG8gZGVjaWRlIHdoYXQgaXMgYW5kIGlzbid0IGJlaW5nIHVzZWQg
YnkgcGVvcGxlIG91dCB0aGVyZSwgc28gSSdtDQo+IGhhcHB5IHRvIGFwcGx5IHRoaXMgcGF0Y2gg
bm93IGJlZm9yZSB0aGUgbmV4dCAtcmMxIGNvbWVzIG91dCBhcyBsb25nIGFzIGl0DQo+IGRvZXNu
J3QgYnJlYWsgYW55dGhpbmcgaW4gYXJtLXNvYyBhcmVhLiBUaGUgY29uZmlkZW5jZSBJJ20gZ2V0
dGluZyBpc24ndCBoaWdoDQo+IHRob3VnaC4gSGFzIGFueW9uZSBmcm9tIE5YUCByZXZpZXdlZCB0
aGlzIGNoYW5nZT8gTWF5YmUgSSBjYW4gZ2V0IGFuIGFjaw0KPiBmcm9tIHNvbWVvbmUgZWxzZSB0
aGF0IG5vcm1hbGx5IGxvb2tzIGFmdGVyIHRoZSBhcm0tc29jL2R0cyBzaWRlIG9mIHRoaW5ncw0K
PiBoZXJlIGluZGljYXRpbmcgdGhhdCBub3RoaW5nIHNob3VsZCBnbyB3cm9uZz8gVGhhdCB3b3Vs
ZCBpbmNyZWFzZSBteQ0KPiBjb25maWRlbmNlIGxldmVscy4NCg0KQUZBSUsgbm8gb25lIG91dCB0
aGVyZSB1c2luZyBpdCBmb3IgcHJvZHVjdCB3aXRob3V0IGJlaW5nIGFibGUgdG8gdXBkYXRlIGFj
Y29yZGluZ2x5LA0KYXMgaXQgc3RpbGwgaGFzIGEgdmVyeSBwcmVsaW1pbmFyeSBzdXBwb3J0Lg0K
U28gSSBhZ3JlZSB3ZSBuZWVkIHRvIGZpeCBpdCBhdCB0aGlzIGVhcmx5IHRpbWUNCg0KVGVzdGVk
LWFuZC1BY2tlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KRG9uZyBBaXNoZW5nDQo=
