Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3702BC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E743620665
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZR073Czp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfEXFw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:52:27 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:58892
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388260AbfEXFwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKwEL0hsIp12CnwV2oHYus+JsvYqct60cA6cWG8I7AY=;
 b=ZR073CzpG6/dmkwaQ1/vCkOOLBPW/0S+1H84bIjQ65jR5+4MRw7DHI9d1/uEsSlgBcnfYE/XcxLVlSqUIYJloas+sFBYaR6oeiEvAPWJmjMc4aRmZuqq19jmZ9YrIk+Bn0iQKqFWAvlVhDNncCJozAGjdb+AA6/CDvVP0DzTFj0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Fri, 24 May 2019 05:52:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 05:52:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mq: add clock for SNVS RTC node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mq: add clock for SNVS RTC node
Thread-Index: AQHVCrrcUP74CkLHLE+NNE1EMv+PBqZ38P8AgAHi6yA=
Date:   Fri, 24 May 2019 05:52:21 +0000
Message-ID: <DB3PR0402MB391655657A8BE5E812F01C8FF5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
 <1557882259-3353-3-git-send-email-Anson.Huang@nxp.com>
 <20190523010243.GD16359@dragon>
In-Reply-To: <20190523010243.GD16359@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baa9a513-5da4-45ac-0c7f-08d6e00bfced
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3721E06CBBF74329AE5F7860F5020@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(13464003)(199004)(189003)(6436002)(76116006)(8676002)(6306002)(44832011)(73956011)(55016002)(68736007)(486006)(7736002)(9686003)(305945005)(7416002)(476003)(33656002)(74316002)(25786009)(81166006)(81156014)(2906002)(8936002)(14454004)(66476007)(446003)(66446008)(64756008)(66556008)(256004)(52536014)(54906003)(71190400001)(71200400001)(66066001)(66946007)(316002)(26005)(4326008)(53546011)(478600001)(6506007)(86362001)(102836004)(966005)(3846002)(6916009)(99286004)(229853002)(11346002)(7696005)(53936002)(6116002)(5660300002)(6246003)(186003)(76176011)(32563001)(299355004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Hl5vOWHTPitA7aKByeNvRap739atBwDilrfWyJzQluuznZoYCmY96DgI+fep+9ZVkW5OWAIS7yyiBBWqV72t3qBBAFGQsud/oYNDJVUxm6VyMBW/MHUbx2FauREX9N5DJ/QTOVTA+Gkurwx9NTRNI6rvQQERWHtMmnuIXFfLBBz/qPF+1sr4CbRWVsnlFTgKDwXYSUVTw6ocbaxxzFTlTYrN7nd+4DzC6xOYZG0RgA5bCKfKm9zS/rt9Jvm/2ceRcZ9NY5LIzQsSnUXYKX9IpcP2GRsotFv5tBsd9J/BiJSItmK6YHqYC0SKCyp7jDhVzmSd+k8NppAf0GQeEbkI/MkWCdbBJsBSgIOHryjyquy927FjK97gzM2R7Dhs6seNefyTUtJYRQqQmO7X4C2B1kNZwiGfdhjrzb4kB2Gqdc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa9a513-5da4-45ac-0c7f-08d6e00bfced
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 05:52:21.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24g
R3VvIFttYWlsdG86c2hhd25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogVGh1cnNkYXksIE1heSAy
MywgMjAxOSA5OjAzIEFNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwu
Y29tOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2VybmVsLm9yZzsgbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsgQWJlbCBWZXNhDQo+IDxhYmVsLnZlc2FAbnhwLmNvbT47IGFuZHJl
dy5zbWlybm92QGdtYWlsLmNvbTsgY2NhaW9uZUBiYXlsaWJyZS5jb207DQo+IGFuZ3VzQGFra2Vh
LmNhOyBhZ3hAc2lneGNwdS5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIGFybTY0OiBkdHM6IGlt
eDhtcTogYWRkIGNsb2NrIGZvciBTTlZTIFJUQyBub2RlDQo+IA0KPiBPbiBXZWQsIE1heSAxNSwg
MjAxOSBhdCAwMTowOTozNkFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBpLk1YOE1R
IGhhcyBjbG9jayBnYXRlIGZvciBTTlZTIG1vZHVsZSwgYWRkIGNsb2NrIGluZm8gdG8gU05WUyBS
VEMNCj4gPiBub2RlIGZvciBjbG9jayBtYW5hZ2VtZW50Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiBUaGlzIG9uZSBzdGls
bCBoYXMgcHJvYmxlbSB3aXRoIGVuY29kaW5nIGFuZCB0aHVzIGNhbm5vdCBiZSBhcHBsaWVkLg0K
PiBIZXJlIGlzIHdoYXQgSSBnZXQsIGFuZCB0aGVyZSBpcyAnPTIwJyBpbiB0aGUgcGF0Y2ggY29u
dGVudC4NCg0KV2Ugc3dpdGNoIHRvIGFub3RoZXIgc2VydmVyIHdoaWNoIGhhcyBubyBzdWNoIGlz
c3VlLCBJIHJlc2VudCB0aGUgcGF0Y2gsDQpQbGVhc2UgcGljayB1cCB0aGlzIG9uZSwgc29ycnkg
Zm9yIHRoZSBpbmNvbnZlbmllbmNlLg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwOTU5MDk3Lw0KDQp0aGFua3MsDQpBbnNvbi4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGIvYXJjaC9hcm02NC9i
b290L2R0PSBzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSBpbmRleCBlNWYzMTMzLi5iNzA2ZGU4DQo+
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRz
aQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiBA
QCAtNDM4LDYgKzQzOCw4IEBADQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvZmZzZXQgPTNEIDwweDM0PjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludGVycnVwdHMgPTNEIDxHSUNfU1BJIDE5IElSUV9UWVBFX0xFVkVMX0hJR0g+
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lD
X1NQSSAyMCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNsb2NrcyA9M0QgPCZjbGsgSU1YOE1RX0NMS19TTlZTX1JPT1Q+Ow0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPTNE
ICJzbnZzLXJ0YyI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPTIwDQo+IC0tPTIwDQo+IDIuNy40DQoNCg==
