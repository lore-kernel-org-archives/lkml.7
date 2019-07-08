Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FE1C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950A20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FJLzdS8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGHHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:54:12 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:48670
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfGHHyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gFWwenjxdnLDMne55GinxjL08rhf6Z/YP812R8SfLI=;
 b=FJLzdS8xd9ztNOW31oNOWGr35QCdXX1wZuhRY+xAdU8Ch8Fdv7G1US+ElqiDezboF94DDgw7Cdds84C+7Woo65fNIsO65DqUAv5CuN0n+nyV35AdVVkdDDkJdTN7ZoIlf924Wzzq5SM6HZmZyXFZtVa1Qlu/xWtgr/M3u2sU07I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Mon, 8 Jul 2019 07:54:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 07:54:03 +0000
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
Thread-Index: AQHVMjD62bccyXxndUyDszIpSDkBnaa6F2SAgAZH0bA=
Date:   Mon, 8 Jul 2019 07:54:03 +0000
Message-ID: <DB3PR0402MB391651E56C147B1BD13727C5F5F60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704061403.8249-1-Anson.Huang@nxp.com>
 <20190704061403.8249-2-Anson.Huang@nxp.com>
 <DB7PR04MB50519C02D90675070F21501DEEFA0@DB7PR04MB5051.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165D27F23501EE358DE607F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39165D27F23501EE358DE607F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1513bb46-1363-4059-9c0d-08d70379722a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB3852A97E40F1103FFD4DC43BF5F60@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(74316002)(2501003)(53936002)(9686003)(110136005)(99286004)(54906003)(6436002)(229853002)(55016002)(316002)(44832011)(11346002)(476003)(486006)(14444005)(256004)(6506007)(7696005)(6246003)(53546011)(446003)(3846002)(33656002)(14454004)(6116002)(76176011)(26005)(76116006)(186003)(102836004)(5660300002)(4326008)(15650500001)(66556008)(66946007)(73956011)(8676002)(86362001)(66446008)(64756008)(66476007)(2906002)(81166006)(81156014)(66066001)(7736002)(25786009)(71190400001)(71200400001)(68736007)(8936002)(478600001)(7416002)(305945005)(52536014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 71gxXUF9Ra8hl72EAiw3cjJonP9VnouPbYaqBWikAbHovdaGPC0KT0V1IzNEOA1YzoMtnbtNjR97Ta+3Yy3axTXkaOb7KhIta7nS057uQVdbVrUpTVZdgDGFvoKrNZrn6eGF2CtC8cAOazLMd/djoeGa83IN1bAHn0iVdybpliaADy/utyfsT+6BQJHiykl7cp2eg0aRMyFje1/jIyDsGv0kV2vDL/+SWMrEBu2C6xQl44yRLamLsuUpeaQwFaNQJ4D6wIyPZk849510KpDI32XqjZTaQnPpuQ3H6y2NoXSLiYAMqow7MUP6ZqWJcsGfFBCvzTCitbw/Iq/cIjNE9L5FXRfGzEzEK8P6nGw7MULDTD3yriUtPpV2LO3t1NJ8Nnvq5yMFJ9k875wr/DgnRowYFSOe5rJwLS6EejzyHfc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513bb46-1363-4059-9c0d-08d70379722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 07:54:03.6096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExlb25hcmQNCg0KPiA+IE9uIDcvNC8yMDE5IDk6MjMgQU0sIEFuc29uLkh1YW5nQG54cC5j
b20gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4N
Cj4gPiA+DQo+ID4gPiBBc3NpZ24gaGlnaGVzdCBPUFAgYXMgc3VzcGVuZCBPUFAgdG8gcmVkdWNl
IHN1c3BlbmQvcmVzdW1lIGxhdGVuY3kNCj4gPiA+IG9uIGkuTVg4TU0uDQo+ID4gPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAx
ICsNCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+
ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gPiBp
bmRleCBiMTFmYzVlLi4zYTYyNDA3IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gPiBAQCAtMTM2LDYgKzEzNiw3IEBADQo+ID4g
PiAgIAkJCW9wcC1taWNyb3ZvbHQgPSA8MTAwMDAwMD47DQo+ID4gPiAgIAkJCW9wcC1zdXBwb3J0
ZWQtaHcgPSA8MHg4PiwgPDB4Mz47DQo+ID4gPiAgIAkJCWNsb2NrLWxhdGVuY3ktbnMgPSA8MTUw
MDAwPjsNCj4gPiA+ICsJCQlvcHAtc3VzcGVuZDsNCj4gPiA+ICAgCQl9Ow0KPiA+ID4gICAJfTsN
Cj4gPg0KPiA+IFdoYXQgaWYgdGhlIGhpZ2hlc3QgT1BQIGlzIHVuYXZhaWxhYmxlIGR1ZSB0byBz
cGVlZCBncmFkaW5nPyBJZGVhbGx5DQo+ID4gd2Ugc2hvdWxkIGZpbmQgYSB3YXkgdG8gc3VzcGVu
ZCBhdCB0aGUgaGlnaGVzdCAqc3VwcG9ydGVkKiBPUFAuDQo+ID4NCj4gPiBNYXliZSB0aGUgb3Bw
LXN1c3BlbmQgbWFya2luZyBjb3VsZCBiZSBhc3NpZ25lZCBmcm9tIGlteC1jcHVmcmVxLWR0DQo+
ID4gZHJpdmVyIGNvZGU/DQo+IA0KPiBZZXMsIHRoaXMgaXMgYWxzbyBteSBjb25jZXJuLCB0aGUg
Y3VycmVudCBPUFAgZHJpdmVyIGRvZXMgTk9UIGhhbmRsZSBpdCB3ZWxsLA0KPiBhbmQgSSB3YXMg
dGhpbmtpbmcgdG8gYXNzaWduZSBpdCBmcm9tIGlteC1jcHVmcmVxLWR0IGRyaXZlciwgMSBvcHRp
b24gaXMgdG8NCj4gcnVudGltZSBhZGQgInN1c3BlbmQtb3BwIiBwcm9wZXJ0eSBpbnRvIERUIE9Q
UCBub2RlIGFmdGVyIHBhcnNpbmcgdGhlDQo+IHNwZWVkIGdyYWRpbmcgZnVzZSBhbmQgT1BQIHRh
YmxlLCBidXQgSSBkbyBOT1QgbGlrZSB0aGF0IHZlcnkgbXVjaCwgYXMgd2UNCj4gbmVlZCB0byBt
YW51YWxseSBjcmVhdGUgYSBwcm9wZXJ0eSwgdGhlIG90aGVyIG9wdGlvbiBpcyB0byBjaGFuZ2Ug
Y3B1IGZyZXENCj4gcG9saWN5IGluc2lkZSBpbXgtY3B1ZnJlcS1kdCBkcml2ZXIgaW4gc3VzcGVu
ZC9yZXN1bWUgY2FsbGJhY2s/IFdoaWNoIG9uZQ0KPiBkbyB5b3UgcHJlZmVyPw0KDQpBZnRlciBs
b29raW5nIHRocm91Z2ggdGhlIGNwdWZyZXEgZHJpdmVyLCBJIHRoaW5rIHdlIGNhbiB1c2UgYmVs
b3cgbGF0ZSBpbml0IGZ1bmN0aW9uDQp0byBhc3NpZ24gdGhlIHN1c3BlbmRfZnJlcSwgdGhlbiBu
byBuZWVkIHRvIGFkZCAib3BwLXN1c3BlbmQgIiBpbiBEVCwgYW5kIHRoZSBmcmVxDQpnZXQgZnJv
bSBjcHVmcmVxX3F1aWNrX2dldF9tYXgoKSBpcyBhbHJlYWR5IHRoZSBtYXggc3VwcG9ydGVkIGZy
ZXEgY29uc2lkZXJpbmcgdGhlDQpzcGVlZCBncmFkaW5nIGFuZCBtYXJrZXQgc2VnbWVudCBmdXNl
IHNldHRpbmdzLCBwbGVhc2UgaWdub3JlIHRoZXNlIDIgcGF0Y2hlcywgSSB3aWxsDQpzZW5kIG91
dCBhIGlteC1jcHVmcmVxLWR0LmMgcGF0Y2ggd2l0aCBiZWxvdyBjaGFuZ2UgdG8gc3VwcG9ydCBh
bGwgU29DcyB3aXRoIGlteC1jcHVmcmVxLWR0DQpkcml2ZXIuDQoNCitzdGF0aWMgaW50IF9faW5p
dCBpbXhfY3B1ZnJlcV9kdF9zZXR1cF9zdXNwZW5kX29wcCh2b2lkKQ0KK3sNCisgICAgICAgc3Ry
dWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQoMCk7DQorDQorICAg
ICAgIHBvbGljeS0+c3VzcGVuZF9mcmVxID0gY3B1ZnJlcV9xdWlja19nZXRfbWF4KDApOw0KKw0K
KyAgICAgICByZXR1cm4gMDsNCit9DQorbGF0ZV9pbml0Y2FsbChpbXhfY3B1ZnJlcV9kdF9zZXR1
cF9zdXNwZW5kX29wcCk7DQoNCkFuc29uLg0KDQo=
