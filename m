Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4EFC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B942133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwW851sE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfEWOF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:05:26 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:38367
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbfEWOF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmFc55WyH3JsmRZ8ErY7j04gjyr14es9MxOyCjzhtiM=;
 b=NwW851sEoj3KwRjG+Q5OMenauRPnldDuiBZxIj6IyRet1TJPUomcOvvNflfHv6YV6yW/jTYEfujTOs4ZRG7cnZMDKLAix76c+SCaCz+D0G7Na9wrIEAiHbEQjWxTXMBCvySp7Yd/r2lWKWBMWmYvZL79oQIXlyEynBcxEwL7rPM=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4144.eurprd04.prod.outlook.com (52.133.14.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 23 May 2019 14:05:21 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2891:4e93:da53:30de]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2891:4e93:da53:30de%6]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 14:05:21 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Topic: [PATCH v4] clk: qoriq: add support for lx2160a
Thread-Index: AQHU+/zGE8MPZcMnA0GP8h3OejDbYKZ1N2hwgAOwrbA=
Date:   Thu, 23 May 2019 14:05:21 +0000
Message-ID: <VI1PR04MB4800AAC6A29E0F1001808CE8F3010@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1556261624-20504-1-git-send-email-vabhav.sharma@nxp.com>
 <AM6PR04MB4789787C4AB0613B1CF53DBCF3070@AM6PR04MB4789.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4789787C4AB0613B1CF53DBCF3070@AM6PR04MB4789.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0f064e-02e5-4586-913b-08d6df87b1dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4144;
x-ms-traffictypediagnostic: VI1PR04MB4144:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB41442A58BE33DF75177DBB87F3010@VI1PR04MB4144.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(13464003)(199004)(189003)(71200400001)(26005)(71190400001)(86362001)(2201001)(44832011)(486006)(52536014)(476003)(6436002)(73956011)(76116006)(25786009)(66946007)(11346002)(2501003)(66556008)(64756008)(66446008)(66476007)(76176011)(8676002)(478600001)(81166006)(186003)(55016002)(966005)(8936002)(66066001)(99286004)(2906002)(74316002)(229853002)(14444005)(446003)(81156014)(7696005)(54906003)(6506007)(110136005)(256004)(7736002)(4326008)(316002)(53546011)(68736007)(305945005)(6306002)(6246003)(3846002)(6116002)(53936002)(102836004)(5660300002)(9686003)(33656002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4144;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O8Ui6jbd8poelsKp8aaI0jEuXbZgJsradiKuodjr9W9OG3JtetQTDpXRB5gj1Vr/z9U14TOuDORfaW+y+7Z6sZA7hEMzGszVrZ0NYYm1Ikpt1rPbUU2EM4qLekdfLnozVKWPkQX6L5N3VyuVOdwT8I3i8da9z1zEduBl3oDgIq4oIElUoki83UTI8kz+fBfLhpJmKdBBVa8OekUdKOKCWsj1OSfcTocHED9I7KlcZz/LR92vGftBPGG3lD61wzacJxtTodKL7CW792wPpQsGT8nJQir1WqsU549jnbH2nG5U2hfS2uHk7VhhZooDA/XHPQhnArr4DUGVgwjzZo103Wtl3ilGjevD1n+HhDH5EBOrW+tt2apP2lFbm1bhILAiuXjqSlmV4CaB8jVI9tUbNTE1WSGImI9jlYRaw0rF8SE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0f064e-02e5-4586-913b-08d6df87b1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 14:05:21.5648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWYWJoYXYgU2hhcm1hDQo+IFNl
bnQ6IFR1ZXNkYXksIE1heSAyMSwgMjAxOSAxMToxNCBBTQ0KPiBUbzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gc2JveWRAa2VybmVs
Lm9yZw0KPiBDYzogbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IEFuZHkgVGFuZyA8YW5keS50YW5n
QG54cC5jb20+OyBZb2dlc2gNCj4gTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhw
LmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NF0gY2xrOiBxb3JpcTogYWRkIHN1cHBvcnQg
Zm9yIGx4MjE2MGENCj4gDQo+IEhlbGxvIFN0ZXBoZW4sDQo+IEkgaGF2ZSBpbmNvcnBvcmF0ZWQg
cmV2aWV3IGNvbW1lbnRzIGZyb20NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDkxNzE3MS8NCkhlbGxvIE1haW50YWluZXJzLA0KQWxsIHRoZSBjb21tZW50cyBhcmUgYWRk
cmVzc2VkLCBDYW4geW91IHBsZWFzZSB0YWtlIHRoZSBwYXRjaD8NClBsZWFzZSBzZWUgdGhpcyBp
cyBlc3NlbnRpYWwgZm9yIG5ldyBoYXJkd2FyZSBzdXBwb3J0Lg0KDQpSZWdhcmRzLA0KVmFiaGF2
DQo+IA0KPiBBIGdlbnRsZSByZW1pbmRlciB0byBhcHBseSB0aGUgcGF0Y2gNCj4gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDkxODQwNy8uDQo+IA0KPiBSZWdhcmRzLA0KPiBW
YWJoYXYNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBWYWJo
YXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBBcHJp
bCAyNiwgMjAxOSAxMjoyNCBQTQ0KPiA+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IHNib3lkQGtlcm5lbC5vcmc7IG10
dXJxdWV0dGVAYmF5bGlicmUuY29tOyBWYWJoYXYgU2hhcm1hDQo+ID4gPHZhYmhhdi5zaGFybWFA
bnhwLmNvbT47IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+OyBZb2dlc2gNCj4gTmFyYXlh
bg0KPiA+IEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFtQ
QVRDSCB2NF0gY2xrOiBxb3JpcTogYWRkIHN1cHBvcnQgZm9yIGx4MjE2MGENCj4gPg0KPiA+IEFk
ZCBjbG9ja2dlbiBzdXBwb3J0IGFuZCBjb25maWd1cmF0aW9uIGZvciBOWFAgU29DIGx4MjE2MGEg
d2l0aA0KPiA+IGNvbXBhdGlibGUgcHJvcGVydHkgYXMgImZzbCxseDIxNjBhLWNsb2NrZ2VuIi4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhw
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54
cC5jb20+DQo+ID4gQWNrZWQtYnk6IFNjb3R0IFdvb2QgPG9zc0BidXNlcnJvci5uZXQ+DQo+ID4g
QWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gPiBBY2tlZC1ieTog
VmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4NCj4gPiAtLS0NCj4gPiBDaGFu
Z2VzIGZvciB2NDoNCj4gPiAtIEluY29ycG9yYXRlZCByZXZpZXcgY29tbWVudHMgZnJvbSBTdGVw
aGVuIEJveWQNCj4gPg0KPiA+IENoYW5nZXMgZm9yIHYzOg0KPiA+IC0gSW5jb3Jwb3JhdGVkIHJl
dmlldyBjb21tZW50cyBvZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiA+IC0gVXBkYXRlZCBjb21taXQg
bWVzc2FnZQ0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjI6DQo+ID4gLSBTdWJqZWN0IGxpbmUgdXBk
YXRlZA0KPiA+DQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIHwgMTIgKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYyBp
bmRleA0KPiA+IDNkNTFkN2MuLjFhMTUyMDEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsv
Y2xrLXFvcmlxLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KPiA+IEBAIC01
NzAsNiArNTcwLDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8gY2hp
cGluZm9bXSA9IHsNCj4gPiAgCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExFX0VORElBTiwN
Cj4gPiAgCX0sDQo+ID4gIAl7DQo+ID4gKwkJLmNvbXBhdCA9ICJmc2wsbHgyMTYwYS1jbG9ja2dl
biIsDQo+ID4gKwkJLmNtdXhfZ3JvdXBzID0gew0KPiA+ICsJCQkmY2xvY2tnZW4yX2NtdXhfY2dh
MTIsICZjbG9ja2dlbjJfY211eF9jZ2INCj4gPiArCQl9LA0KPiA+ICsJCS5jbXV4X3RvX2dyb3Vw
ID0gew0KPiA+ICsJCQkwLCAwLCAwLCAwLCAxLCAxLCAxLCAxLCAtMQ0KPiA+ICsJCX0sDQo+ID4g
KwkJLnBsbF9tYXNrID0gMHgzNywNCj4gPiArCQkuZmxhZ3MgPSBDR19WRVIzIHwgQ0dfTElUVExF
X0VORElBTiwNCj4gPiArCX0sDQo+ID4gKwl7DQo+ID4gIAkJLmNvbXBhdCA9ICJmc2wscDIwNDEt
Y2xvY2tnZW4iLA0KPiA+ICAJCS5ndXRzX2NvbXBhdCA9ICJmc2wscW9yaXEtZGV2aWNlLWNvbmZp
Zy0xLjAiLA0KPiA+ICAJCS5pbml0X3BlcmlwaCA9IHAyMDQxX2luaXRfcGVyaXBoLA0KPiA+IEBA
IC0xNDI3LDYgKzE0MzgsNyBAQCBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczEwNDNh
LA0KPiA+ICJmc2wsbHMxMDQzYS1jbG9ja2dlbiIsIGNsb2NrZ2VuX2luaXQpOw0KPiA+IENMS19P
Rl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMTA0NmEsICJmc2wsbHMxMDQ2YS1jbG9ja2dlbiIs
DQo+ID4gY2xvY2tnZW5faW5pdCk7ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9sczEw
ODhhLCAiZnNsLGxzMTA4OGEtDQo+ID4gY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsgIENMS19P
Rl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2VuX2xzMjA4MGEsDQo+ID4gImZzbCxsczIwODBhLWNsb2Nr
Z2VuIiwgY2xvY2tnZW5faW5pdCk7DQo+ID4gK0NMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2Vu
X2x4MjE2MGEsICJmc2wsbHgyMTYwYS1jbG9ja2dlbiIsDQo+ID4gK2Nsb2NrZ2VuX2luaXQpOw0K
PiA+ICBDTEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9wMjA0MSwgImZzbCxwMjA0MS1jbG9j
a2dlbiIsDQo+ID4gY2xvY2tnZW5faW5pdCk7IENMS19PRl9ERUNMQVJFKHFvcmlxX2Nsb2NrZ2Vu
X3AzMDQxLA0KPiA+ICJmc2wscDMwNDEtY2xvY2tnZW4iLCBjbG9ja2dlbl9pbml0KTsNCj4gPiBD
TEtfT0ZfREVDTEFSRShxb3JpcV9jbG9ja2dlbl9wNDA4MCwgImZzbCxwNDA4MC1jbG9ja2dlbiIs
DQo+ID4gY2xvY2tnZW5faW5pdCk7DQo+ID4gLS0NCj4gPiAyLjcuNA0KDQo=
