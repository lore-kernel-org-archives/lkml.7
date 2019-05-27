Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA86208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LjI8ttQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfE0TUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:20:06 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:43682
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfE0TUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATFdzLuMxJOEBbPBZnb7bOdnaz3hYfrpWu1hA6a3vpY=;
 b=LjI8ttQq1RhTGcGzCSO1GT//EgZJ74cLYPrJ76h5gVLFjBWV0Q2+p0jzbgxVeljOghkXvcqylQ5f1Rfc0D5RhsDgCJZGbsNeejnb38p5I9hwWIDKdLDt0TyYwUn/Xk4Qn8VvsAesJur7E/k4bt/A57zG7nryZKQzy05TLEi5Sig=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.235.152) by
 VE1PR04MB6685.eurprd04.prod.outlook.com (20.179.235.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 19:19:58 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::9e6:e136:4c09:fe67]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::9e6:e136:4c09:fe67%5]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 19:19:58 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Andy Tang <andy.tang@nxp.com>
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
Thread-Index: AQHVEdA5vBlpwutLvUe9kqG6PS5PHaZ63V2AgAPKYSCAALahcA==
Date:   Mon, 27 May 2019 19:19:58 +0000
Message-ID: <VE1PR04MB6687BA478AAFD1DF1FAF170C8F1D0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190524012151.31840-1-andy.tang@nxp.com>
 <CADRPPNRYwq0NABXobC1jQrT3QMxxm+e6zvoNwoZ-fu6NU9qDMA@mail.gmail.com>
 <VI1PR04MB4333A3E635CFDBD860D3061DF31D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4333A3E635CFDBD860D3061DF31D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ea61cd-ef93-4fe5-d4e6-08d6e2d84ef2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR04MB6685;
x-ms-traffictypediagnostic: VE1PR04MB6685:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB668552615ECA0F6CF3FA5F7D8F1D0@VE1PR04MB6685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(13464003)(189003)(199004)(74316002)(73956011)(33656002)(14454004)(7696005)(229853002)(66066001)(81156014)(186003)(14444005)(256004)(25786009)(26005)(53936002)(6506007)(8936002)(305945005)(76116006)(11346002)(102836004)(53546011)(2906002)(7736002)(76176011)(478600001)(6116002)(5660300002)(3846002)(99286004)(966005)(66476007)(316002)(6246003)(486006)(6436002)(71200400001)(6862004)(9686003)(6306002)(8676002)(81166006)(4326008)(52536014)(66556008)(66446008)(6636002)(64756008)(446003)(66946007)(54906003)(86362001)(476003)(55016002)(71190400001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6685;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lfN/+ytIvXxssqNERAk6MTD1O6QN5NA1cJpIjsDCrRuQePF7KUQHrgWjbSPFNA3QYx7guNYccfMoTGCk6DGDJyHRU1s9nQIsQSW1KS8Jg3MZKpqCjrbT2fh1G44sXeU3M4gqgA/zDHuCge5/NhRScUxJ7fIm6sR5rAnnrF9TAWC+sCVP/83Me0EWasZMDCkY0Ys98FNKUqlEto9XnAat9Q07GyolpoOnmw1XK4I0NeWSxQo7vFv5rHWXJbb8IqvnsAvYyb9R4Vw2q58B8DA7NxUiJPyRcIvaBDaba/SCnH0+4yvEvzbWYT03FquZ2N+/Pyq+2c6l8jTI9JdNkOdqYVTh9xWa0VEgIALcYWFsEJTf9FaiRAVnrcpC9FoxDf/+mw/ULZ+OSv1wJdI4sJvO2Iak+iTnCprZjdNJXrGIv8k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ea61cd-ef93-4fe5-d4e6-08d6e2d84ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 19:19:58.3584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBUYW5nDQo+IFNl
bnQ6IE1vbmRheSwgTWF5IDI3LCAyMDE5IDM6MjcgQU0NCj4gVG86IExlbyBMaSA8bGVveWFuZy5s
aUBueHAuY29tPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUm9iIEhl
cnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5k
QGFybS5jb20+Ow0KPiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0g
QVJDSElURUNUVVJFIDxsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
b3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRA0KPiBERVZJQ0UgVFJFRSBCSU5E
SU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsa21sIDxsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUkU6IFtFWFRdIFJlOiBbUEFUQ0hdIGFybTY0
OiBkdHM6IGxzMTAyOGE6IEFkZCB0ZW1wZXJhdHVyZSBzZW5zb3INCj4gbm9kZQ0KPiANCj4gSGkg
TGVvLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IExpIFlh
bmcgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gPiBTZW50OiAyMDE55bm0NeaciDI15pelIDY6MzIN
Cj4gPiBUbzogQW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPiBDYzogU2hhd24gR3Vv
IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9y
Zz47DQo+ID4gTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IG1vZGVyYXRlZCBs
aXN0OkFSTS9GUkVFU0NBTEUNCj4gSU1YDQo+ID4gLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj4gPiBvcGVuIGxpc3Q6T1BFTiBG
SVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTDQo+ID4gPGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnPjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
Cj4gPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIXSBhcm02NDogZHRzOiBsczEwMjhhOiBBZGQg
dGVtcGVyYXR1cmUgc2Vuc29yDQo+ID4gbm9kZQ0KPiA+DQo+ID4gQ2F1dGlvbjogRVhUIEVtYWls
DQo+ID4NCj4gPiBPbiBUaHUsIE1heSAyMywgMjAxOSBhdCA4OjMwIFBNIFl1YW50aWFuIFRhbmcg
PGFuZHkudGFuZ0BueHAuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEFkZCBueHAgc2E1
NjAwNCBjaGlwIG5vZGUgZm9yIHRlbXBlcmF0dXJlIG1vbml0b3IuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRz
IHwgNSArKysrKw0KPiA+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAy
OGEtcmRiLmR0cyB8IDUgKysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4gPiBpbmRleCBiMzU5MDY4ZDk2MDUuLjMx
ZmQ2MjZkZDM0NCAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+IEBAIC0xMzEsNiArMTMxLDExIEBA
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRt
ZWwsMjRjNTEyIjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0g
PDB4NTc+Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHRlbXBANGMgew0KPiA+DQo+ID4gVGhlIHJlY29tbWVu
ZGVkIG5hbWUgZm9yIHRlbXBlcmF0dXJlIHNlbm9yIGluIGR0cyBzcGVjIGlzDQo+ID4gdGVtcGVy
YXR1cmUtc2Vuc29yLg0KPiBJIGRpZG4ndCBmaW5kIHRoZSBzcGVjIGZvciB0aGlzIHJlY29tbWVu
ZGF0aW9uLiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgdGhlDQo+IGxpbms/DQoNCllvdSBjYW4g
ZmluZCB0aGUgc3BlYyBvbiBodHRwczovL3d3dy5kZXZpY2V0cmVlLm9yZy8NCg0KPiBJIGxpa2Ug
dG8gdXBkYXRlIGl0IHRvIHRlbXAtc2Vuc29yIHRob3VnaC4NCj4gDQo+ID4NCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJueHAsc2E1NjAwNCI7DQo+
ID4NCj4gPiBUaGUgYmluZGluZyBzYXlzIHRoZSBmb2xsb3dpbmcgcHJvcGVydHkgaXMgcmVxdWly
ZWQuICBJZiBpdCBpcyBub3QgdGhlDQo+ID4gY2FzZSwgcHJvYmFibHkgd2Ugc2hvdWxkIHVwZGF0
ZSB0aGUgYmluZGluZy4NCj4gPiAtIHZjYy1zdXBwbHk6IHZjYyByZWd1bGF0b3IgZm9yIHRoZSBz
dXBwbHkgdm9sdGFnZS4NCj4gSSB3aWxsIGFkZCB0aGUgdmNjLXN1cHBseSB0byBjb21wbHkgdGhp
cyByZXF1aXJlbWVudC4NCj4gDQo+IFRoYW5rcywNCj4gQW5keQ0KPiA+DQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDRjPjsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH07DQo+ID4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPiA+DQo+ID4gPiAg
ICAgICAgICAgICAgICAgaTJjQDUgew0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCj4gPiA+IGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiA+ID4gaW5kZXggZjljMjcy
ZmIwNzM4Li4wMTJiM2Y4Njk2YjcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQo+ID4gPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQo+ID4gPiBAQCAtMTE5LDYg
KzExOSwxMSBAQA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gIm54cCxwY2YyMTI5IjsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnID0gPDB4NTE+Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+
ICsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRlbXBANGMgew0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54cCxzYTU2MDA0IjsNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4NGM+Ow0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+
ID4gICAgICAgICB9Ow0KPiA+ID4gIH07DQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4xDQo+ID4gPg0K
