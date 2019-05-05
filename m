Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F58C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F84208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xP0BrCxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEEIE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 04:04:27 -0400
Received: from mail-eopbgr20061.outbound.protection.outlook.com ([40.107.2.61]:24908
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfEEIE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 04:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSZhLTqxoEwA/3eQ84r3tq3kN8K2M9SmnzATSTr6EBQ=;
 b=xP0BrCxz83rgg0/upY3HE/9Qj6Zfx0oYMqFhLHA40iKwbiBMYYFTG+pEiU+oMyGodLFpPtdKEwh5pbX1yPwB+bORY+sTG2YK7J4eKFv3ZY1vIWd0d/1B7c1qxOOqG/Z2gizmMmM4CO+jofgV8q5ySkWkdJ7vLzRMZW61yTNaIcA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB3972.eurprd04.prod.outlook.com (52.134.124.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 08:04:22 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 08:04:22 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Kay-Liu <liuk@cetca.net.cn>,
        Andy Duan <fugang.duan@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        root <root@localhost.localdomain>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 2/2] clk: imx6sx: Remove unexisting IMX6SX_CLK_ENET_AHB
 clock
Thread-Topic: [PATCHv2 2/2] clk: imx6sx: Remove unexisting IMX6SX_CLK_ENET_AHB
 clock
Thread-Index: AQHVAmi83lrnH+d/lkWtar7gw5ucNaZcLT1g
Date:   Sun, 5 May 2019 08:04:22 +0000
Message-ID: <AM0PR04MB4211F5B54480F24FDA7ADE3680370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556190810-19690-1-git-send-email-liuk@cetca.net.cn>
 <CAOMZO5AM-Ee_8ScFEk3hSrujKqH2+XiLHPto3ES3r9AbDkUnkg@mail.gmail.com>
In-Reply-To: <CAOMZO5AM-Ee_8ScFEk3hSrujKqH2+XiLHPto3ES3r9AbDkUnkg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe395923-42ba-4682-cb33-08d6d13048b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3972;
x-ms-traffictypediagnostic: AM0PR04MB3972:
x-microsoft-antispam-prvs: <AM0PR04MB3972A829F3E7F5AF103B0E0180370@AM0PR04MB3972.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(7696005)(53546011)(6506007)(66556008)(256004)(14444005)(102836004)(76176011)(68736007)(71200400001)(71190400001)(3846002)(11346002)(25786009)(446003)(6116002)(110136005)(74316002)(99286004)(33656002)(478600001)(54906003)(8936002)(26005)(186003)(476003)(44832011)(7736002)(305945005)(486006)(6636002)(6246003)(66066001)(4326008)(7416002)(53936002)(316002)(14454004)(66946007)(55016002)(81166006)(86362001)(229853002)(6436002)(81156014)(52536014)(73956011)(66446008)(66476007)(9686003)(76116006)(2906002)(64756008)(5660300002)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3972;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0ArpnJ9pkbdncn69hYFYBzvqFKiEyRtDYi0zk8KGmWDIKRmheqF0AtBqKIsSgRafxyxD5lGUJU5ra+TWnkn+Qz5lSgUW3qvCmohdYupUCp61rbB3kyjnPkuvdSjQ8QlQInnPGLnYsimyCBN9sFOW5P8Z3YuZ7tjuGdStROLBtmOBvEtoeHrrWzbhcBIaKEHTA+El1VC0sACh703sPOgL6L0gTYonO2yUJ5KhCrzNT8IRW3BsDcqSN30t2F9mKoYZ4YQKzEhhre3lEIz+g7WVACmw3AdpnlLkraG3gNTo3SMqWhtpGrqIUOKLDJhxIs1TeAPaaK7WJ4ek0PSlRT+0dmUTXmiEPTWV2rjc+XGq1xRE1S+XRFebTrJ0DuWuG+ZFMLvKUmdIadR948lhYz+ts+CstdwQ6GwlEhbCFl5hq9E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe395923-42ba-4682-cb33-08d6d13048b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 08:04:22.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50
OiBTYXR1cmRheSwgTWF5IDQsIDIwMTkgNzowMiBQTQ0KPiANCj4gSGkgS2F5LUxpdSwNCj4gDQo+
IE9uIFRodSwgQXByIDI1LCAyMDE5IGF0IDg6MTQgQU0gPGxpdWtAY2V0Y2EubmV0LmNuPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IEtheS1MaXUgPGxpdWtAY2V0Y2EubmV0LmNuPg0KPiA+DQo+ID4g
VGhlIGlteDZzeCdzIGR0cyBmaWxlIGRlZmluZXMgZml2ZSBjbG9ja3MgZm9yIGZlYywgdGhlICdh
aGInY2xvY2sncw0KPiA+IHZhbHVlIGlzIElNWDZTWF9DTEtfRU5FVF9BSEIsIGJ1dCBpbiB0aGUg
aS5NWDZTWCBSZWZlcmVuY2UgTWFudWFsDQo+ID4gdGhlcmUgaXMgbm8gc3VjaCBlbmV0IGFoYiBj
bG9jaywgdGhlcmUgaXMgb25seSBvbmUgImVuZXQgY2xvY2siIGluIHRoZQ0KPiA+IENDTV9DQ0dS
MyByZWdpc3RlciB3aGljaCBpcyBjb250cm9sbGVkIGJ5IGJpdHMgNS00LCB0aGUgZW5ldCBjbG9j
ayBpcw0KPiA+IGRlZmluZWQgZm9yIHRoZSAnaXBnJyBjbG9jaywgdGhpcyBjYW4gY2F1c2UgcHJv
YmxlbS4NCj4gPiBUaGUgb3JpZ2luYWwgcGhlbm9tZW5vbiBpcyB1c2luZyBpbXg2LXNvbG94IHBy
b2Nlc3NvciBhbmQgTWFydmVsDQo+ID4gODhFNjM5MCBzd2l0Y2ggd2l0aCBsaW51eCBPUywgdGhl
IGtlcm5lbCB3aWxsIGhhbmcgZHVyaW5nIHRoZSBzdGFydHVwDQo+ID4gb2YgdGhlIGxpbnV4IE9T
Lg0KPiA+IEFmdGVyIGFuYWx5emluZyB0aGUgcGhlbm9tZW5vbiwgdGhlIHJlYXNvbiBvZiBDUFUg
aGFuZyBpcyByZWFkL3dyaXRlDQo+ID4gZW5ldCBtb2R1bGUncyByZWdpc3RlciB3aGVuIHRoZSBl
bmV0IGNsb2NrIGlzIGRpc2FibGVkLiBUaGUga2VybmVsDQo+ID4gY29kZSB0cnkgdG8gYXZvaWRz
IHRoZSBwcm9ibGVtIGJ5IHJlc3VtZSBlbmV0IGNsb2NrIGJlZm9yZSByZWFkL3dyaXRlDQo+ID4g
ZW5ldCByZWdpc3Rlci4NCj4gPiBCdXQgdGhlIGVuZXQgbW9kdWxlJ3MgY2xvY2sgY29uZmlnIHdp
bGwgY2F1c2UgYSBzcGVjaWFsIGVudmlyb25tZW50DQo+ID4gd2hpY2ggY2FuIGJ5cGFzcyB0aGUg
Y2xvY2sgcmVzdW1lIG1lY2hhbmlzbS4NCj4gPiBUaGUgQ1BVIGhhcyBvbmx5IG9uZSBlbmV0IGNs
b2NrLCBhZnRlciBrZXJuZWwgcGFyc2VzIHRoZSBkdHMgZmlsZSwgdGhlDQo+ID4gdHdvIGNsb2Nr
IHZhcmlhYmxlcyAnaXBnJyBhbmQgJ2FoYicNCj4gPiBmaW5uYWx5IHBvaW50IHRvIHRoZSBzYW1l
IGVuZXQgY2xvY2sgcmVnaXN0ZXIuIFRoaXMgd2lsbCBjYXVzZSBlbmV0DQo+ID4gY2xvY2sgYmUg
ZGlzYWJsZWQgYWZ0ZXIgZmVjIHByb2JlIG92ZXIuDQo+ID4gQmVjYXVzZSB0aGUgcG93ZXIgc2F2
aW5nIG1vZHVsZSB3aWxsIGFmZmVjdCB0aGUgQlVHLCBzbyB0aGVyZSBhcmUgdHdvDQo+ID4gc2l0
dWF0aW9ucyBmb3IgdGhpcyBwcm9ibGVtOg0KPiA+IDEpVHVybiBvZmYgcG93ZXIgc2F2aW5nDQo+
ID4gVHVybiBvZmYgcG93ZXIgc2F2aW5nIG1lYW5zIHRoYXQgdGhlIHJlc3VtZSBtZWNoYW5pc20g
aXMgZGlzYWJsZWQsIHNvDQo+ID4gYWZ0ZXIgZmVjIHByb2JlIG92ZXIgaWYgYW55IG9uZSByZWFk
L3dyaXRlIGVuZXQgbW9kdWxlJ3MgcmVnaXN0ZXIsIHRoZQ0KPiA+IENQVSB3aWxsIGhhbmcgYmVj
YXVzZSBubyBvbmUgY291bGQgcmVzdW1lIHRoZSBlbmV0IGNsb2NrLg0KPiA+IDIpVHVybiBvbiBw
b3dlciBzYXZpbmcNCj4gPiBUdXJuIG9uIHBvd2VyIHNhdmluZyBjb3VsZCByZXN1bWUgZW5ldCBj
bG9jayBiZWZvcmUgcmVhZC93cml0ZSBlbmV0DQo+ID4gcmVnaXN0ZXIgYnkgZW5hYmxlICdpcGcn
IGNsaywgdGhpcyB3aWxsIGNhdXNlICdhaGInIHZhcmlhYmxlIHN0YXRlIGFuZA0KPiA+IGVuZXQg
Y2xvY2sgcmVnaXN0ZXIgdmFsdWUgZG9uJ3QgbWF0Y2guSWYgYW55IHRhc2sgcmVhZC93cml0ZSBl
bmV0IGF0IGENCj4gPiBoaWdoIGZyZXF1ZW50bHksIHRoZSBrZXJuZWwgd2lsbCBrZWVwIHJlc3Vt
ZSBzdGF0ZSBhbmQgbmV2ZXIgZW50ZXINCj4gPiBzdXNwZW5kIHByb2Nlc3MsIHRoaXMgbWVhbnMg
dGhhdCB0aGUga2VybmVsIHdpbGwgb25seSBtb2RpZmllcyB0aGUNCj4gPiByZWdpc3RlciB2YWx1
ZSBkdXJpbmcgdGhlIGZpcnN0IHJlc3VtZS4NCj4gPiBCdXQgdGhlIGtlcm5lbCBpbml0IHdpbGwg
Y2hlY2sgdW51c2VkIGNsb2NrIHZhcmlhYmxlIGluIHRoZSBsYXRlDQo+ID4gaW5pdGNhbGwsIHRo
ZSAnYWhiJyBjbG9jayB3aWxsIGJlIHRyZWF0ZWQgYXMgdW51c2VkLCBhdCB0aGlzIHRpbWUsIHRo
ZQ0KPiA+IGVuZXQgY2xvY2sgd2lsbCBiZSBkaXNhYmxlZCBieXBhc3MgdGhlIHJlc3VtZSBtZWNo
YW5pc20sIHRoZW4gdGhlIG5leHQNCj4gPiByZWFkL3dyaXRlIGVuZXQgbW9kdWxlJ3MgcmVnaXN0
ZXIgd2lsbCBjYXVzZSB0aGUgQ1BVIGhhbmcuDQo+ID4gUHJvcG9zZWQgc29sdXRpb24gaXMgZGVs
ZXRlIHRoZSAnYWhiJyBjbG9jaydzIGRlZmluaXRpb24gaW4gdGhlDQo+ID4gY2xrLWlteDZzeC5j
LCBhbmQgbW9kaWZ5IGZlYyBkZXZpY2XigJlzIGNsb2NrcyBpbiB0aGUgZHRzIGZpbGUsIHBvaW50
DQo+ID4g4oCYYWhi4oCZIGZyb20gSU1YNlNYX0NMS19FTkVUX0FIQiB0byBJTVg2U1hfQ0xLX0VO
RVQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtheS1MaXUgPGxpdWtAY2V0Y2EubmV0LmNuPg0K
PiANCj4gVGhpcyBtYXRjaGVzIHRoZSBteDZzeCByZWZlcmVuY2UgbWFudWFsOg0KPiANCg0KQWxz
byBjb3B5IEFuZHksIHRoZSBFTkVUIG93bmVyLCB0byBjb21tZW50Lg0KDQpSZWdhcmRzDQpEb25n
IEFpc2hlbmcNCg==
