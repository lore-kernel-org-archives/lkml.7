Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13593C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D588D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZQfLiU9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE0I2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:28:12 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:61939
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfE0I2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFNKVrfhO5x9hzNK0VbeADDNtMTZ/ZXVhzdsfLYLZZA=;
 b=ZQfLiU9Q0JWIBHNwZJ3brGyK978MmJvhUJ1+8V0oGg4SYAskjcy/1Pm/QKH/w++kIgvs/Pk6j3OvYnjkRtDHlhIrg9sC+rz0uhGB7UGZJTK2AvLGSfZvP1+29iPaNqvpm90lmSj6mQ7X5q/dRrqAMBJm6Krt2EsvD2PuVvG967o=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4031.eurprd04.prod.outlook.com (10.171.182.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Mon, 27 May 2019 08:27:26 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::497a:768:c7b1:34e0%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 08:27:26 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] arm64: dts: ls1028a: Add temperature sensor
 node
Thread-Topic: [EXT] Re: [PATCH] arm64: dts: ls1028a: Add temperature sensor
 node
Thread-Index: AQHVEdA5Oph4GV2XbECsbmKrZdLVl6Z63V2AgAPKYSA=
Date:   Mon, 27 May 2019 08:27:26 +0000
Message-ID: <VI1PR04MB4333A3E635CFDBD860D3061DF31D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20190524012151.31840-1-andy.tang@nxp.com>
 <CADRPPNRYwq0NABXobC1jQrT3QMxxm+e6zvoNwoZ-fu6NU9qDMA@mail.gmail.com>
In-Reply-To: <CADRPPNRYwq0NABXobC1jQrT3QMxxm+e6zvoNwoZ-fu6NU9qDMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93c023bf-5c12-47c9-b227-08d6e27d2697
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4031;
x-ms-traffictypediagnostic: VI1PR04MB4031:
x-microsoft-antispam-prvs: <VI1PR04MB4031E9167AD0E7E7598AB0DAF31D0@VI1PR04MB4031.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(13464003)(4326008)(52536014)(102836004)(2906002)(53546011)(55016002)(5660300002)(6862004)(9686003)(8676002)(81166006)(99286004)(229853002)(3846002)(6116002)(14444005)(256004)(81156014)(316002)(6506007)(74316002)(53936002)(6246003)(7696005)(54906003)(6636002)(25786009)(6436002)(76176011)(33656002)(68736007)(14454004)(66066001)(86362001)(44832011)(71200400001)(7736002)(305945005)(71190400001)(486006)(11346002)(446003)(478600001)(476003)(66946007)(73956011)(66556008)(66476007)(66446008)(64756008)(76116006)(26005)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4031;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0mOXCrVTSsfkf6zUhJeXkNJUj+2tcJL47Q7Vs6hXLrXoSGj7E6vzwSsiO55mP1KIGMMu8CHCsWWX7L9mABm1SNDxOs8Syf5NtxaPc44jcHkZfujs2VZPB0RCn9S+2yAVvhA4HI54UVA5Ic/xb7eiXU30ujcYam7hXgTdkFn4nfpEYQrfAgjc6J+ZA8tqN2ohEnvqtvBbuEwJmy+qoqj/us5NeRAXl9muj3cbegDiBWkT6w+TJlKuvUBU8z/OE5tkksi1aEiJi478C475Hpu0Tq4f6g0z/OhVhTllt9tKITu0SRx8FctEI5pYzh/m1o4c+7mhAbH/ccY1kCla5ceuT6qUdDUHxL/ZiHSs8FYeorDvUckEbZJBSTxdsC/N+Kt6yEf71mLE0E5ReI0r6D/Mno76kZJ5BOuodFmeT++YNxc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c023bf-5c12-47c9-b227-08d6e27d2697
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 08:27:26.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andy.tang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpIFlhbmcg
PGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gU2VudDogMjAxOeW5tDXmnIgyNeaXpSA2OjMyDQo+IFRv
OiBBbmR5IFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1
b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IE1hcmsg
UnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVND
QUxFDQo+IElNWCAvIE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc+Ow0KPiBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVE
IERFVklDRSBUUkVFIEJJTkRJTkdTDQo+IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxr
bWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBb
UEFUQ0hdIGFybTY0OiBkdHM6IGxzMTAyOGE6IEFkZCB0ZW1wZXJhdHVyZSBzZW5zb3INCj4gbm9k
ZQ0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUaHUsIE1heSAyMywgMjAxOSBh
dCA4OjMwIFBNIFl1YW50aWFuIFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IEFkZCBueHAgc2E1NjAwNCBjaGlwIG5vZGUgZm9yIHRlbXBlcmF0dXJlIG1vbml0b3Iu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAy
OGEtcWRzLmR0cyB8IDUgKysrKysNCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHMxMDI4YS1yZGIuZHRzIHwgNSArKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4gaW5kZXggYjM1OTA2OGQ5NjA1Li4zMWZk
NjI2ZGQzNDQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiBAQCAtMTMxLDYgKzEzMSwxMSBAQA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCwyNGM1MTIi
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4NTc+Ow0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHRlbXBANGMgew0KPiANCj4gVGhlIHJlY29tbWVuZGVkIG5hbWUgZm9yIHRlbXBlcmF0
dXJlIHNlbm9yIGluIGR0cyBzcGVjIGlzDQo+IHRlbXBlcmF0dXJlLXNlbnNvci4NCkkgZGlkbid0
IGZpbmQgdGhlIHNwZWMgZm9yIHRoaXMgcmVjb21tZW5kYXRpb24uIENvdWxkIHlvdSBwbGVhc2Ug
cHJvdmlkZSB0aGUgbGluaz8NCkkgbGlrZSB0byB1cGRhdGUgaXQgdG8gdGVtcC1zZW5zb3IgdGhv
dWdoLg0KDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJueHAsc2E1NjAwNCI7DQo+IA0KPiBUaGUgYmluZGluZyBzYXlzIHRoZSBmb2xsb3dpbmcg
cHJvcGVydHkgaXMgcmVxdWlyZWQuICBJZiBpdCBpcyBub3QgdGhlIGNhc2UsDQo+IHByb2JhYmx5
IHdlIHNob3VsZCB1cGRhdGUgdGhlIGJpbmRpbmcuDQo+IC0gdmNjLXN1cHBseTogdmNjIHJlZ3Vs
YXRvciBmb3IgdGhlIHN1cHBseSB2b2x0YWdlLg0KSSB3aWxsIGFkZCB0aGUgdmNjLXN1cHBseSB0
byBjb21wbHkgdGhpcyByZXF1aXJlbWVudC4NCg0KVGhhbmtzLA0KQW5keQ0KPiANCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDRjPjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+DQo+ID4gICAgICAg
ICAgICAgICAgIGkyY0A1IHsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiA+IGluZGV4IGY5YzI3MmZiMDczOC4uMDEy
YjNmODY5NmI3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwMjhhLXJkYi5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQo+ID4gQEAgLTExOSw2ICsxMTksMTEgQEANCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLHBjZjIxMjki
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4NTE+Ow0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHRlbXBANGMgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJueHAsc2E1NjAwNCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHg0Yz47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiAg
ICAgICAgICAgICAgICAgfTsNCj4gPiAgICAgICAgIH07DQo+ID4gIH07DQo+ID4gLS0NCj4gPiAy
LjE3LjENCj4gPg0K
