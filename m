Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39121C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7EB208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RGmLSZH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfEEIDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 04:03:37 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:15437
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfEEIDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 04:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdfeNtwQS7VmjvkWqw8MWfCx0Yl6axkCz/iG2G4woyA=;
 b=RGmLSZH1h5OrXwCLkyerL2R25eUWIuFpZqomU6ET0QD9RIV+uUn2q1R4ThKSPqn2f6gSOUA5mcgYnKT7hTTtqNVcwlv2UbAX+IP6lXhpi1YTHLjTvmC5NURCe52SLLnHKt5KMjCsjkua7ppTEyRJvjcnpQE+XUrdEgh6xQyBqyQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5281.eurprd04.prod.outlook.com (52.134.89.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 08:03:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 08:03:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>, Kay-Liu <liuk@cetca.net.cn>,
        Andy Duan <fugang.duan@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for fec 'ahb'
 clock
Thread-Topic: [PATCHv2 1/2] ARM: dts: imx6sx: Use MX6SX_CLK_ENET for fec 'ahb'
 clock
Thread-Index: AQHVAmkSkfnHjuPrDUuL+rGIVj8MEqZcLD7w
Date:   Sun, 5 May 2019 08:03:23 +0000
Message-ID: <AM0PR04MB421133A3F3C6B534B6ECEA7880370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556190530-19541-1-git-send-email-liuk@cetca.net.cn>
 <CAOMZO5BbA6oq8okTR-r800k4XY76XxxEdufd1mjcV6HdTpVotA@mail.gmail.com>
In-Reply-To: <CAOMZO5BbA6oq8okTR-r800k4XY76XxxEdufd1mjcV6HdTpVotA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abdd8718-4bbc-463b-4ff0-08d6d130252c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5281;
x-ms-traffictypediagnostic: AM0PR04MB5281:
x-microsoft-antispam-prvs: <AM0PR04MB528195BBABD38B844A997A1580370@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(53936002)(476003)(486006)(52536014)(9686003)(6246003)(14444005)(256004)(446003)(110136005)(54906003)(86362001)(11346002)(55016002)(4326008)(14454004)(25786009)(33656002)(6436002)(71200400001)(44832011)(66066001)(478600001)(71190400001)(7416002)(5660300002)(305945005)(66556008)(74316002)(3846002)(6116002)(6506007)(53546011)(102836004)(6636002)(229853002)(8676002)(26005)(7696005)(76176011)(99286004)(186003)(68736007)(81166006)(81156014)(7736002)(76116006)(316002)(66476007)(8936002)(66446008)(64756008)(2906002)(73956011)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5281;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zQc6A51RPB70l2UR/FM/hqURIsEnrHOSyk9B8way2DsnnwLMFoTiuBzUSIrs5T/utL1AmHjBvdny6VZiCHerANUGPX4l784Ng2MS8mkhd45VV1va5zsv1nO+Lbsy9hB+rll5pXCDIbm7jz+ZH+tCpgWJP65GGI6aB7bGMOGp02vHqg4aphvys+7QXtN6vtU8QCA8hEE0f7tcU4u2ogeG0AsJMdmsv4xX8A24s6c1mkMBISiXJQQ6yfNF53EwLvy+rZe0ECBaim8xNbm94q1dxg4KwYCzrXbmHfttxBvlC04R8j5HafWwoqAMjeK2BIExG0IY9oU/OLGZcU/CVd05i7UQIWw4NHy/HQCB4byg5XUCSDW6sQAcMbu67fwHS5V9xfW8j8WWpEnZlZFdekgNVQKvc04q7yfuKcoUSp0tNgE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdd8718-4bbc-463b-4ff0-08d6d130252c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 08:03:23.0890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50
OiBTYXR1cmRheSwgTWF5IDQsIDIwMTkgNzowNCBQTQ0KPiANCj4gSGkgS2F5LUxpdSwNCj4gDQo+
IE9uIFRodSwgQXByIDI1LCAyMDE5IGF0IDg6MDkgQU0gPGxpdWtAY2V0Y2EubmV0LmNuPiB3cm90
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
PiA+IC0tLQ0KPiA+IENoYW5nZSBzaW5jZSB2MToNCj4gPiAtaW5wcm92ZWQgY29tbWl0IGxvZyBk
ZXNjcmlwdGlvbg0KPiA+IC1hZGQgcGxhdGZvcm0gcmVsYXRlZCBjbG9jayBjaGFuZ2UgaW5zdGVh
ZCBvZiBkZXNjcmliZSBpcyBpbiB0aGUNCj4gPiBleHRlcm5hbCBVUkwNCj4gPg0KPiA+ICBhcmNo
L2FybS9ib290L2R0cy9pbXg2c3guZHRzaSB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2
c3guZHRzaSBpbmRleCA1YjE2ZTY1Li5iOGIyM2E2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZzeC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4
LmR0c2kNCj4gPiBAQCAtOTE5LDcgKzkxOSw3IEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTE4DQo+IElSUV9UWVBFX0xFVkVMX0hJ
R0g+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxH
SUNfU1BJIDExOQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrcyBJTVg2U1hfQ0xLX0VORVQ+LA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjbGtzDQo+IElNWDZTWF9D
TEtfRU5FVF9BSEI+LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPCZjbGtzIElNWDZTWF9DTEtfRU5FVD4sDQo+IA0KPiBZZXMsIHRoZXJlIGlzIHJlYWxseSBu
byBJTVg2U1hfQ0xLX0VORVRfQUhCIGFzIHBlciB0aGUgUmVmZXJuY2UgTWFudWFsIGFuZA0KPiBp
dCBpcyB0aGUgc2FtZSB3ZSBkbyBvbiBpbXg2cWRsLmR0c2k6DQo+IA0KPiBSZXZpZXdlZC1ieTog
RmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KDQpDb3B5IEFuZHksIHRoZSBFTkVU
IG93bmVyLCB0byBjb21tZW50Lg0KDQpCVFcsIGl0J3Mgc3RyYW5nZSB0aGF0IEkgZGlkIG5vdCBy
ZWNlaXZlIHRoZSBvcmlnaW5hbCBwYXRjaCBlbWFpbC4NCkFsc28gY2FuJ3QgZ3JlcCBmcm9tIHRo
ZSBvcGVuIGxpc3QuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0K
