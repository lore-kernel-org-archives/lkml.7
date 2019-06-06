Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED24C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9779A207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Um58YizC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFFCjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:39:23 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:44877
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfFFCjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEfw2XP7woddP8jkb5yiTWjUQEYtKYxoGszP/xMn0K8=;
 b=Um58YizCLjZ0MjMCRTAakRCeE0UnE9DDxUlG+G6Rxcd9tmbDD2ezaLqeEBJm2zGel0Ww3tOcdrT677/X8YEj6q81La1p2kD2XYm6BjRq0GZlWTDfdna8J4Thq6blkqkYYJLakx4W/bfKcdbLfupbbC+X4UNUeB7GFWmoDImKfPg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 6 Jun 2019 02:38:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 02:38:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mm: Move gic node into soc node
Thread-Topic: [PATCH] arm64: dts: imx8mm: Move gic node into soc node
Thread-Index: AQHVGa55LUfZhzUgv0u2mUng1o8nvaaN6NYAgAAFcuA=
Date:   Thu, 6 Jun 2019 02:38:38 +0000
Message-ID: <DB3PR0402MB3916D9019F65E901DC4E6BDAF5170@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190603015020.41410-1-Anson.Huang@nxp.com>
 <20190606021803.GW29853@dragon>
In-Reply-To: <20190606021803.GW29853@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8caeaf81-823d-465f-6d90-08d6ea2814b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3691;
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-microsoft-antispam-prvs: <DB3PR0402MB3691523F8874F4B694BBD1CCF5170@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(13464003)(53546011)(6506007)(102836004)(4326008)(76176011)(25786009)(33656002)(316002)(5660300002)(52536014)(74316002)(71200400001)(71190400001)(6246003)(6436002)(54906003)(73956011)(76116006)(55016002)(66946007)(7736002)(6916009)(81156014)(446003)(11346002)(476003)(305945005)(2906002)(229853002)(478600001)(86362001)(486006)(44832011)(26005)(186003)(6116002)(3846002)(7416002)(99286004)(256004)(68736007)(53936002)(14444005)(66066001)(7696005)(8676002)(81166006)(8936002)(66556008)(9686003)(64756008)(66446008)(66476007)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3691;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LucmTFVOC3Hkcc0lWN2hloCjeZIUJGNfzNF35pWZ1/QD0mcoQ3wAt/bMuyYxmkrzCx7seWhIWXTmq0Nm9hq9YrfspFJFOW7OHmUksX0ULN4AOO4ruUu/nIpSyQUZ9kUb2qNuIr+LvHuYU6H1GESlVesuQjXBHo0snoFTOFsBYB0AcbnGIRv2n6X+x/BLW1hVP1U3pz1qx5usBBBFBwG6INW3LhyK9rq3BEL83FXqhGX0B/7romfPwFBPkr97zqHLavPWnRzljAwR9PKjQ+oyCN2fyZ0hZcDodqgeDNNW6wVQYGszFETsR75Ty65m2Hwezafj4139Vj8eKnEuX8WgNJVlojNT5jETksaRZ47u4p1VCzybM6aKJRGM73vmIJvEq7W5vXeXbgqKXRzGBo3D5RM1+Mo5QKWzYORKD2yKQUo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caeaf81-823d-465f-6d90-08d6ea2814b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 02:38:38.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA2LCAyMDE5
IDEwOjE4IEFNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6
IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBM
ZW9uYXJkIENyZXN0ZXoNCj4gPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgQWlzaGVuZyBEb25n
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBKYWNr
eSBCYWkgPHBpbmcuYmFpQG54cC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogaW14OG1tOiBNb3ZlIGdpYyBub2RlIGludG8gc29j
IG5vZGUNCj4gDQo+IE9uIE1vbiwgSnVuIDAzLCAyMDE5IGF0IDA5OjUwOjIwQU0gKzA4MDAsIEFu
c29uLkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQo+ID4NCj4gPiBHSUMgaXMgaW5zaWRlIG9mIFNvQyBmcm9tIGFyY2hpdGVj
dHVyZSBwZXJzcGVjdGl2ZSwgaXQgc2hvdWxkIGJlDQo+ID4gbG9jYXRlZCBpbnNpZGUgb2Ygc29j
IG5vZGUgaW4gRFQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gDQo+IEl0IGRvZXNuJ3QgYXBwbHkgdG8gbXkgaW14L2R0NjQgYnJh
bmNoLiAgUGxlYXNlIGdlbmVyYXRlIGl0IGFnYWluc3QgdGhhdA0KPiBicmFuY2ggZm9yIG15IGZv
ci1uZXh0Lg0KDQpPSywganVzdCByZXNlbnQgdGhlIHBhdGNoIGJhc2VkIG9uIHRoZSBjb3JyZWN0
IGJyYW5jaC4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IFNoYXduDQo+IA0KPiA+IC0tLQ0K
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSB8IDE4ICsrKysr
KysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaQ0KPiA+IGluZGV4IGRjOTlmNDUuLjQyOTMxMmUgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+IEBAIC0xNjksMTUgKzE2
OSw2IEBADQo+ID4gIAkJY2xvY2stb3V0cHV0LW5hbWVzID0gImNsa19leHQ0IjsNCj4gPiAgCX07
DQo+ID4NCj4gPiAtCWdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAMzg4MDAwMDAgew0KPiA+IC0J
CWNvbXBhdGlibGUgPSAiYXJtLGdpYy12MyI7DQo+ID4gLQkJcmVnID0gPDB4MCAweDM4ODAwMDAw
IDAgMHgxMDAwMD4sIC8qIEdJQyBEaXN0ICovDQo+ID4gLQkJICAgICAgPDB4MCAweDM4ODgwMDAw
IDAgMHhDMDAwMD47IC8qIEdJQ1IgKFJEX2Jhc2UgKw0KPiBTR0lfYmFzZSkgKi8NCj4gPiAtCQkj
aW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KPiA+IC0JCWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+
IC0JCWludGVycnVwdHMgPSA8R0lDX1BQSSA5IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+IC0J
fTsNCj4gPiAtDQo+ID4gIAlwc2NpIHsNCj4gPiAgCQljb21wYXRpYmxlID0gImFybSxwc2NpLTEu
MCI7DQo+ID4gIAkJbWV0aG9kID0gInNtYyI7DQo+ID4gQEAgLTczOSw2ICs3MzAsMTUgQEANCj4g
PiAgCQkJZG1hLW5hbWVzID0gInJ4LXR4IjsNCj4gPiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gPiAgCQl9Ow0KPiA+ICsNCj4gPiArCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDM4ODAw
MDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJhcm0sZ2ljLXYzIjsNCj4gPiArCQkJcmVnID0g
PDB4Mzg4MDAwMDAgMHgxMDAwMD4sIC8qIEdJQyBEaXN0ICovDQo+ID4gKwkJCSAgICAgIDwweDM4
ODgwMDAwIDB4YzAwMDA+OyAvKiBHSUNSIChSRF9iYXNlICsNCj4gU0dJX2Jhc2UpICovDQo+ID4g
KwkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQo+ID4gKwkJCWludGVycnVwdC1jb250cm9sbGVy
Ow0KPiA+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19QUEkgOSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gPiArCQl9Ow0KPiA+ICAJfTsNCj4gPg0KPiA+ICAJdXNicGh5bm9wMTogdXNicGh5bm9wMSB7
DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo=
