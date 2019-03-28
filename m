Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C241C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6FA2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lickM6rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfC1JZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:25:20 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:43931
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbfC1JZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7fqAqHXpzApqxPGTfX7hvxla6tGu/rpnyP1bIbGVRM=;
 b=lickM6rOH9cPNT22GtzMPqICqnNw1V3DN276QPm/tpGiaf7rgD/Gn4mjybmJzUiB+ORuV23a+d1RfyQ0twfOWZ6KxgkdrDJQv1mw2CMMVxDv7leHh+CSHeSQl8MuDKbUQRF27SWjTJhJP0zRuzc5CHiwiyaqX3m38Nym9rxhKZQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5363.eurprd04.prod.outlook.com (20.178.114.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 09:25:15 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 09:25:15 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Teo Hall <teo.hall@nxp.com>, Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Index: AQHU5M+7DOoA/eJp7kqEHAMC8ZrFEaYgUZAQgABsYYCAAAgiAA==
Date:   Thu, 28 Mar 2019 09:25:14 +0000
Message-ID: <AM0PR04MB4211FDBE2A19E4FEDEFAF03C80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190327190244.9208-1-daniel.baluta@nxp.com>
 <20190327190244.9208-3-daniel.baluta@nxp.com>
 <AM0PR04MB4211B89650EA1AC9133F4EBE80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAEnQRZB8f4rHhsUoefKUB6PN_aRPtSB4y8O_D8N0_s-Zq0_8Vw@mail.gmail.com>
In-Reply-To: <CAEnQRZB8f4rHhsUoefKUB6PN_aRPtSB4y8O_D8N0_s-Zq0_8Vw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae85cd4-8420-4999-4857-08d6b35f4962
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5363;
x-ms-traffictypediagnostic: AM0PR04MB5363:
x-microsoft-antispam-prvs: <AM0PR04MB53636B997234606093DA6D2480590@AM0PR04MB5363.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(68736007)(102836004)(2906002)(256004)(478600001)(186003)(6116002)(6246003)(6506007)(53936002)(229853002)(9686003)(26005)(55016002)(14444005)(93886005)(99286004)(5660300002)(25786009)(106356001)(316002)(105586002)(54906003)(74316002)(6916009)(7416002)(7736002)(4326008)(81156014)(52536014)(76176011)(33656002)(11346002)(476003)(86362001)(8936002)(3846002)(97736004)(6436002)(446003)(14454004)(8676002)(305945005)(486006)(7696005)(71200400001)(44832011)(81166006)(66066001)(71190400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5363;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7RLCfC46NXLnjMfjRFL3GkXwxiDBqTf+mD34/KqF8+Q+MdfLoxwofZe71hbi4TOuWUQ7b9gMJM/Aue1KbWHdm7P30VUoeQmbG/DjZxb9qRZnGIpkHUakKxT3nOYdi7gURbZO1q9Av0hjnWcZQVQQ2b2CoxlH41BBpEAx2O4lRG9J4l5EhOsmfWzvsoNrth8RHqvFOvX++Rzg7Mkkn5Gp9eVsG33Vy0g4D9Orc3l42c9HyZBWQDvDS3hYnGXBQSJbYuL7HS/5yuyfVYhX7+zS1Ng9QjO1jn3JIYOreLUa9zG3L3V/zBk4sNukH77GQtnDUrWox72uUm4ME/aKy1MSgLPH5iVjR9jRK7tZYNUt7N3DPjwZZsrA2mZxaCUxSx7imrM/cTuv4KKeAgTeJxc6UbMHgTMmDea+wviYchxNxSU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae85cd4-8420-4999-4857-08d6b35f4962
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 09:25:15.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAu
ZHRzaQ0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kN
Cj4gPiA+IGluZGV4IDBjYjkzOTg2MWE2MC4uODRjN2MzZWNhMWExIDEwMDY0NA0KPiA+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gPiArKysg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiA+IEBAIC0x
ODIsNiArMTgyLDc4IEBADQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxz
ID0gPDE+Ow0KPiA+ID4gICAgICAgICAgICAgICB9Ow0KPiA+ID4NCj4gPiA+ICsgICAgICAgICAg
ICAgZWRtYTA6IGRtYS1jb250cm9sbGVyQDU5MWYwMDAwIHsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWVkbWEiOw0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgIHJlZyA9IDwweDU5MjAwMDAwIDB4MTAwMDA+LCAgIC8qIGFzcmMwIHBhaXIg
QQ0KPiBpbnB1dCByZXEgKi8NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDww
eDU5MjEwMDAwIDB4MTAwMDA+LCAvKiBhc3JjMCBwYWlyIEINCj4gaW5wdXQgcmVxICovDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHg1OTIyMDAwMCAweDEwMDAwPiwgLyog
YXNyYzAgcGFpciBDDQo+IGlucHV0IHJlcSAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgPDB4NTkyMzAwMDAgMHgxMDAwMD4sIC8qIGFzcmMwIHBhaXIgQQ0KPiBvdXRwdXQg
cmVxICovDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHg1OTI0MDAwMCAw
eDEwMDAwPiwgLyogYXNyYzAgcGFpciBCDQo+IG91dHB1dCByZXEgKi8NCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDwweDU5MjUwMDAwIDB4MTAwMDA+LCAvKiBhc3JjMCBwYWly
IEMNCj4gb3V0cHV0IHJlcSAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PDB4NTkyNjAwMDAgMHgxMDAwMD4sIC8qIGVzYWkwIHJ4ICovDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8MHg1OTI3MDAwMCAweDEwMDAwPiwgLyogZXNhaTAgdHggKi8NCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDU5MjgwMDAwIDB4MTAwMDA+LCAv
KiBzcGRpZjAgcnggKi8NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDU5
MjkwMDAwIDB4MTAwMDA+LCAvKiBzcGRpZjAgdHggKi8NCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweDU5MmMwMDAwIDB4MTAwMDA+LCAvKiBzYWkwIHJ4ICovDQo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHg1OTJkMDAwMCAweDEwMDAwPiwgLyogc2Fp
MCB0eCAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4NTkyZTAwMDAg
MHgxMDAwMD4sIC8qIHNhaTEgcnggKi8NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDwweDU5MmYwMDAwIDB4MTAwMDA+LCAvKiBzYWkxIHR4ICovDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgI2RtYS1jZWxscyA9IDwzPjsNCj4gPg0KPiA+IEluIGJpbmRpbmcgZG9jLCBp
dCdzIDIuDQo+ID4gLSAjZG1hLWNlbGxzIDogTXVzdCBiZSA8Mj4uDQo+ID4gICAgICAgICBUaGUg
MXN0IGNlbGwgc3BlY2lmaWVzIHRoZSBETUFNVVgoMCBmb3IgRE1BTVVYMCBhbmQgMSBmb3INCj4g
RE1BTVVYMSkuDQo+ID4gICAgICAgICBTcGVjaWZpYyByZXF1ZXN0IHNvdXJjZSBjYW4gb25seSBi
ZSBtdWx0aXBsZXhlZCBieSBzcGVjaWZpYw0KPiBjaGFubmVscw0KPiA+ICAgICAgICAgZ3JvdXAg
Y2FsbGVkIERNQU1VWC4NCj4gPiAgICAgICAgIFRoZSAybmQgY2VsbCBzcGVjaWZpZXMgdGhlIHJl
cXVlc3Qgc291cmNlKHNsb3QpIElELg0KPiA+DQo+ID4gTmVlZCB1cGRhdGUgYmluZGluZyBkb2M/
DQo+ID4NCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBzaGFyZWQtaW50ZXJydXB0Ow0KPiA+
DQo+ID4gVW5kb2N1bWVudGVkIHByb3BlcnR5Pw0KPiA+DQo+ID4gQ2hlY2twYXRjaCBkaWQgbm90
IGNvbXBsYWluPw0KPiANCj4gVGhhbmtzIEFpc2hlbmcgZm9yIHRoaXMgY29tbWVudC4gSSB0aGlu
ayB3ZSBtaWdodCBuZWVkIHRvIGRlbGF5IGEgbGl0dGxlIGJpdA0KPiB0aGlzIHBhdGNoIGJlY2F1
c2UgKGFzIHBvaW50ZWQgYnkgWWliaW4pIG9uIGkuTVg4IFFYUC9RTSB3ZSB1c2UNCj4gZnNsLWVk
bWEtdjMgd2hpY2ggKmlzIG5vdCogeWV0IHVwc3RyZWFtLg0KPiANCj4gU28sIGxldHMgZ2V0IGJh
Y2sgdG8gYWRkaW5nIHRoZSBub2RlcyBhZnRlciBZaWJpbiBzZW5kcyBlZG1hLXYzIHBhdGNoZXMu
DQo+IA0KDQpZZXMsIFlpYmluIGNvdWxkIGNoZWNrIHRoZSBjb21tZW50cyB3aGVuIHJlc2VuZGlu
ZyB3aXRoIGVkbWEgZHJpdmVyIHN1cHBvcnQuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+
IHRoYW5rcywNCj4gRGFuaWVsLg0K
