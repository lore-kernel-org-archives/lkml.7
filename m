Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FADC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAD2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ImN1hPoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEODlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 23:41:24 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:37253
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfEODlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 23:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr315o55oJr/ZeC36GAm8zwIaMtnrdlJ6SK7C/SRW9o=;
 b=ImN1hPoeIG8PMi9WVTM+Mi6gqIZ/pJ0XSGZrhwlMfVFriIMJveKgKmGgRGjLmB9X4JAtDoCEFVZuiUhV3HO2x0Jvf8ZwA9hYvuGh+ez4NFJg5FwoaxB1ySxsIcmvyzEYfuEY3w0+2NsR/eBWGSTDeIR7EiKa6LW3zGT0tvKw2JU=
Received: from DB7PR04MB4153.eurprd04.prod.outlook.com (52.135.130.150) by
 DB7PR04MB4044.eurprd04.prod.outlook.com (52.135.130.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 03:41:06 +0000
Received: from DB7PR04MB4153.eurprd04.prod.outlook.com
 ([fe80::f8be:f6a1:bb9f:ad48]) by DB7PR04MB4153.eurprd04.prod.outlook.com
 ([fe80::f8be:f6a1:bb9f:ad48%3]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 03:41:06 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Topic: [EXT] Re: [PATCH v1] arm64: ls1028: dtsi: Add esdhc node in dtsi
Thread-Index: AQHU+cmuEJQ1seVcO0uOXKGj5Q3IF6ZWmSeAgAWDyjCAD473oA==
Date:   Wed, 15 May 2019 03:41:06 +0000
Message-ID: <DB7PR04MB415311EAA94DDE209B42729FE9090@DB7PR04MB4153.eurprd04.prod.outlook.com>
References: <20190423114424.3578-1-yinbo.zhu@nxp.com>
 <CAL_Jsq+4g+inxc+qcC3oLrXuR+L9AMvXFShGaU5Y3iRDsK3P6A@mail.gmail.com>
 <VI1PR04MB415896DA3F0AF8BA6AB149C9E9370@VI1PR04MB4158.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB415896DA3F0AF8BA6AB149C9E9370@VI1PR04MB4158.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbabde7-170a-4d68-8ccc-08d6d8e7298a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4044;
x-ms-traffictypediagnostic: DB7PR04MB4044:
x-microsoft-antispam-prvs: <DB7PR04MB4044B6BF8E760FFD0014DB40E9090@DB7PR04MB4044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(13464003)(66946007)(76116006)(52536014)(6246003)(86362001)(64756008)(66446008)(68736007)(66556008)(2906002)(446003)(71190400001)(54906003)(33656002)(66476007)(229853002)(76176011)(476003)(5660300002)(14454004)(71200400001)(53936002)(7696005)(11346002)(8676002)(73956011)(14444005)(99286004)(486006)(53546011)(102836004)(186003)(478600001)(25786009)(26005)(66066001)(74316002)(44832011)(7736002)(6116002)(6436002)(8936002)(3846002)(316002)(81156014)(6506007)(256004)(305945005)(81166006)(9686003)(55016002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4044;H:DB7PR04MB4153.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pfqWCkDNWGOsx42zb1+ivIq8QmgZR74/cu6vGPm5yBWN+IjTHki66Pn6g/WZ3MpTfToSzt8nnaAL1Wx+U5KhHqoEq33Eq5tDCKv/Z60bx/z4SaqAFB3cNY/ZWgFjH9oXJyaGl4A4GNPtvWEuCeKR0x/dkPytLPgsOULHA1ZXCi3uTP7SlOR9HL+PPVq4sNNCO+F9ayTGQ8FLyR+0adv9QlblRkM/EeD4YGeAFWl8aL9wnlXx8Akixb5YCT1W0/Dw2jNpX4wbg8g+vejHqf0jQP4k7cVyDbo0eNW7m18ai5HE3FicIrnFXg3rQd+Ldkwfpawhz84f7SbKVmrzkxGcQs9Tknol1+nCxNItByIuDYE8zpVK6xOVUOeKR6VGamk2BZ7Gfpy5wxjkqxtQejj+rRL4bPxDEb1Z8Z0plATFq2Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbabde7-170a-4d68-8ccc-08d6d8e7298a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 03:41:06.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWluYm8gWmh1DQo+IFNl
bnQ6IDIwMTnlubQ15pyINeaXpSAxNDowNw0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz4NCj4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPjsgWGlhb2JvDQo+IFhpZSA8eGlhb2JvLnhpZUBueHAuY29tPjsg
TWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFkuYi4g
THUNCj4gPHlhbmdiby5sdUBueHAuY29tPjsgSmlhZmVpIFBhbiA8amlhZmVpLnBhbkBueHAuY29t
PjsgQXNoaXNoIEt1bWFyDQo+IDxhc2hpc2gua3VtYXJAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtFWFRdIFJlOiBbUEFUQ0ggdjFdIGFybTY0OiBsczEwMjg6IGR0c2k6IEFkZCBlc2RoYyBub2Rl
IGluIGR0c2kNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaCtkdEBrZXJuZWwub3JnXQ0KPiA+IFNlbnQ6
IDIwMTnlubQ15pyIMuaXpSAxOjUwDQo+ID4gVG86IFlpbmJvIFpodSA8eWluYm8uemh1QG54cC5j
b20+DQo+ID4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IExlbyBMaSA8bGVv
eWFuZy5saUBueHAuY29tPjsNCj4gPiBYaWFvYm8gWGllIDx4aWFvYm8ueGllQG54cC5jb20+OyBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFku
Yi4gTHUNCj4gPiA8eWFuZ2JvLmx1QG54cC5jb20+OyBKaWFmZWkgUGFuIDxqaWFmZWkucGFuQG54
cC5jb20+OyBBc2hpc2ggS3VtYXINCj4gPiA8YXNoaXNoLmt1bWFyQG54cC5jb20+DQo+ID4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MV0gYXJtNjQ6IGxzMTAyODogZHRzaTogQWRkIGVzZGhj
IG5vZGUgaW4NCj4gPiBkdHNpDQo+ID4NCj4gPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPg0KPiA+
IE9uIFR1ZSwgQXByIDIzLCAyMDE5IGF0IDY6NDIgQU0gWWluYm8gWmh1IDx5aW5iby56aHVAbnhw
LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogQXNoaXNoIEt1bWFyIDxBc2hpc2guS3Vt
YXJAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGlzIHRvIGFkZCBlc2RoYyBub2Rl
IGFuZCBlbmFibGUgU0QgVUhTLUksIGVNTUMgSFMyMDAgZm9yDQo+ID4gPiBsczEwMjhhcmRiL2xz
MTAyOGFxZHMgYm9hcmQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXNoaXNoIEt1bWFy
IDxBc2hpc2guS3VtYXJAbnhwLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmdibyBMdSA8
eWFuZ2JvLmx1QG54cC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaW5ibyBaaHUgPHlpbmJv
LnpodUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHMxMDI4YS1xZHMuZHRzICAgIHwgIDggKysrKysrDQo+ID4gPiAgLi4uL2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzICAgIHwgMTMgKysrKysrKysrDQo+ID4gPiAgLi4u
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIHwgMjcNCj4gPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMo
KykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1xZHMuZHRzDQo+ID4gPiBpbmRleCAxNGM3OWY0NjkxZWEuLjE4MGU1
ZDJhMDBkMSAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMNCj4gPiA+IEBAIC00Miw2ICs0MiwxNCBAQA0KPiA+
ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArJmVz
ZGhjIHsNCj4gPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ID4gK307DQo+ID4gPiAr
DQo+ID4gPiArJmVzZGhjMSB7DQo+ID4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiA+
ICt9Ow0KPiA+ID4gKw0KPiA+ID4gICZpMmMwIHsNCj4gPiA+ICAgICAgICAgc3RhdHVzID0gIm9r
YXkiOw0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHMxMDI4YS1yZGIuZHRzDQo+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1sczEwMjhhLXJkYi5kdHMNCj4gPiA+IGluZGV4IGY4NmIwNTRhNzRhZS4uMWJm
YWY0Mjk0ZGI0IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWxzMTAyOGEtcmRiLmR0cw0KPiA+ID4gQEAgLTMwLDYgKzMwLDE5IEBADQo+
ID4gPiAgICAgICAgIH07DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArJmVzZGhjIHsNCj4gPiA+
ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ID4gKyAgICAgICBzZC11aHMtc2RyMTA0Ow0K
PiA+ID4gKyAgICAgICBzZC11aHMtc2RyNTA7DQo+ID4gPiArICAgICAgIHNkLXVocy1zZHIyNTsN
Cj4gPiA+ICsgICAgICAgc2QtdWhzLXNkcjEyOw0KPiA+ID4gKyAgICAgICB9Ow0KPiA+ID4gKw0K
PiA+ID4gKyZlc2RoYzEgew0KPiA+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gPiAr
ICAgICAgIG1tYy1oczIwMC0xXzh2Ow0KPiA+ID4gKyAgICAgICB9Ow0KPiA+ID4gKw0KPiA+ID4g
ICZpMmMwIHsNCj4gPiA+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNp
DQo+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kN
Cj4gPiA+IGluZGV4IDI4OTZiYmNmYTNiYi4uZDEzY2QzZmI0NTViIDEwMDY0NA0KPiA+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+ID4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KPiA+
ID4gQEAgLTI3NCw2ICsyNzQsMzMgQEANCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPiA+DQo+ID4g
PiArICAgICAgICAgICAgICAgZXNkaGM6IGVzZGhjQDIxNDAwMDAgew0KPiA+DQo+ID4gbW1jQC4u
Lg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxs
czEwMjhhLWVzZGhjIiwgImZzbCxlc2RoYyI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICByZWcgPSA8MHgwIDB4MjE0MDAwMCAweDAgMHgxMDAwMD47DQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgMjggMHg0PjsgLyogTGV2ZWwgaGlnaCB0eXBlICov
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MD47DQo+
ID4NCj4gPiBGaWxsZWQgaW4gYnkgYm9vdGxvYWRlcj8gSWYgc28sIGFkZCBhIGNvbW1lbnQuDQo+
IEhpIHJvYiwNCj4gRmlsbGVkIGluIGJ5IGtlcm5lbCwgcGxlYXNlIHlvdSBub3RlLg0KPiANCj4g
UmVnYXJkcywNCj4gWWluYm8uDQoNCkhpIHJvYiwNCg0KSSdtIHNvcnJ5LCBJdCBpcyBmaXhlZCB1
cCBieSBib290bG9hZGVyIGFjdHVhbGx5Lg0KQW5kIEkgd2lsbCBhZGQgYSBjb21tb250Lg0KDQp5
aW5ibw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZjbG9ja2dlbiAy
IDE+Ow0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdm9sdGFnZS1yYW5nZXMgPSA8MTgw
MCAxODAwIDMzMDAgMzMwMD47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBzZGhjaSxh
dXRvLWNtZDEyOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbGl0dGxlLWVuZGlhbjsN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ1cy13aWR0aCA9IDw0PjsNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gPiArICAgICAg
ICAgICAgICAgfTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAgICBlc2RoYzE6IGVzZGhj
QDIxNTAwMDAgew0KPiA+DQo+ID4gbW1jQC4uLg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWVzZGhjIiwgImZzbCxlc2RoYyI7DQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MjE1MDAwMCAweDAgMHgx
MDAwMD47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgNjMg
MHg0PjsgLyogTGV2ZWwgaGlnaCB0eXBlICovDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBjbG9jay1mcmVxdWVuY3kgPSA8MD47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBj
bG9ja3MgPSA8JmNsb2NrZ2VuIDIgMT47DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB2
b2x0YWdlLXJhbmdlcyA9IDwxODAwIDE4MDAgMzMwMCAzMzAwPjsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHNkaGNpLGF1dG8tY21kMTI7DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBicm9rZW4tY2Q7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBsaXR0bGUtZW5k
aWFuOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnVzLXdpZHRoID0gPDQ+Ow0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiA+ICsg
ICAgICAgICAgICAgICB9Ow0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgICAgICAgIHNhdGE6IHNh
dGFAMzIwMDAwMCB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
ImZzbCxsczEwMjhhLWFoY2kiOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0g
PDB4MCAweDMyMDAwMDAgMHgwIDB4MTAwMDA+LA0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+
ID4NCg==
