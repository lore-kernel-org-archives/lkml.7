Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0AC04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DB021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pc4y9kXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfEHHLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:11:06 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:22950
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfEHHLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMBYeBvoDFWlwL+euvJuE2ZOhwCxJzeEnpQcYcB8Y0A=;
 b=Pc4y9kXU51p7Uhra0oAhaW9Do+R42uzOq2/KBNtZ4Ebi0LdVQf1DqXvGaNjQrse25kue31f3ePtfsYKxEr4Qtn6WO8s7pXbu/s/ZHuhp+lPU5WiSxoExZCicMFh3ew+0hWDJO762jYbAwnQhq7dO+d0NuMGLjky9Iistz3MpNwE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3695.eurprd04.prod.outlook.com (52.134.15.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Wed, 8 May 2019 07:10:57 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 07:10:57 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RESEND PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec
 wm8524
Thread-Topic: [RESEND PATCH v3 2/2] arm64: dts: imx8mm-evk: Enable audio codec
 wm8524
Thread-Index: AQHVBW0u0JkdMhhi00WHh+rKnsTJfA==
Date:   Wed, 8 May 2019 07:10:56 +0000
Message-ID: <20190508071032.31808-3-daniel.baluta@nxp.com>
References: <20190508071032.31808-1-daniel.baluta@nxp.com>
In-Reply-To: <20190508071032.31808-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0278.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::45) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b2b80e5-54a0-4c9f-0f4b-08d6d38450bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3695;
x-ms-traffictypediagnostic: VI1PR0402MB3695:
x-microsoft-antispam-prvs: <VI1PR0402MB3695283BEBBA26F63C34C663F9320@VI1PR0402MB3695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(1730700003)(81156014)(14444005)(11346002)(256004)(71190400001)(6916009)(6116002)(3846002)(36756003)(2906002)(25786009)(66066001)(8936002)(44832011)(486006)(186003)(316002)(71200400001)(305945005)(478600001)(7736002)(7416002)(50226002)(2616005)(5660300002)(26005)(476003)(6486002)(5640700003)(2351001)(14454004)(66476007)(66556008)(64756008)(66446008)(2501003)(446003)(6436002)(8676002)(81166006)(53936002)(86362001)(6506007)(386003)(102836004)(52116002)(73956011)(68736007)(6512007)(54906003)(99286004)(66946007)(1076003)(76176011)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3695;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 185I0e4YC0OHCFlDh/6QBxpaE+5pUYwhFJhLfclfirx8HNObJX07xo+IY03+VQ6dNNoZaTNmQ17VGdmhjqnbEvV6KmtyqvDxkVVk3IC5Qan6jKVpNyFoTlS7NeHhyrDz9zK4RJcL7G+4X0DjHEEpvMkbIv3BlE5HL+LCpzX21tXPdlZ23p3Sc6ZcfdwsIGFEwo+cEc3HqVCZPeag1wYLKnOaBnbURAfpVjXoSrGNqGuXbmvPPDtLomf1mCR+s/0qYklB4I52NZc+5ZYfvX17kb528m6NtipUZwS5jRMsNlRjv/prwMNKh1laxE1d/GIgfAaGBNCuRQspn2mqVqeDqRVsIa9uyFeROIfXLLkxumF6dmS+fZ1GILbdwhT8lzateWgJr35mgAw/sP3O8q/9a8PDY6EHLupsid0woms2s5k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b80e5-54a0-4c9f-0f4b-08d6d38450bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 07:10:56.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgb25lIHdtODUyNCBhdWRpbyBjb2RlYyBjb25uZWN0ZWQgd2l0aA0KU0FJMyBk
aWdpdGFsIGF1ZGlvIGludGVyZmFjZS4NCg0KVGhpcyBwYXRjaCB1c2VzIHNpbXBsZS1jYXJkIG1h
Y2hpbmUgZHJpdmVyIGluIG9yZGVyDQp0byBlbmFibGUgd204NTI0IGNvZGVjLg0KDQpXZSBuZWVk
IHRvIHNldDoNCgkqIFNBSTMgcGluY3RybCBjb25maWd1cmF0aW9uDQoJKiBjb2RlYyByZXNldCBn
cGlvIHBpbmN0cmwgY29uZmlndXJhdGlvbg0KCSogY2xvY2sgaGllcmFyY2h5DQoJKiBjb2RlYyBu
b2RlDQoJKiBzaW1wbGUtY2FyZCBjb25maWd1cmF0aW9uDQoNClNpZ25lZC1vZmYtYnk6IERhbmll
bCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzIHwgNTUgKysrKysrKysrKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KaW5kZXggMmQ1ZDg5NDc1Yjc2Li43YzU3OGQ4NzYy
YjkgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZr
LmR0cw0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMN
CkBAIC0zNyw2ICszNywzNyBAQA0KIAkJZ3BpbyA9IDwmZ3BpbzIgMTkgR1BJT19BQ1RJVkVfSElH
SD47DQogCQllbmFibGUtYWN0aXZlLWhpZ2g7DQogCX07DQorDQorCXdtODUyNDogYXVkaW8tY29k
ZWMgew0KKwkJI3NvdW5kLWRhaS1jZWxscyA9IDwwPjsNCisJCWNvbXBhdGlibGUgPSAid2xmLHdt
ODUyNCI7DQorCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KKwkJcGluY3RybC0wID0gPCZw
aW5jdHJsX2dwaW9fd2xmPjsNCisJCXdsZixtdXRlLWdwaW9zID0gPCZncGlvNSAyMSBHUElPX0FD
VElWRV9MT1c+Ow0KKwl9Ow0KKw0KKwlzb3VuZC13bTg1MjQgew0KKwkJY29tcGF0aWJsZSA9ICJz
aW1wbGUtYXVkaW8tY2FyZCI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxuYW1lID0gIndtODUyNC1h
dWRpbyI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxmb3JtYXQgPSAiaTJzIjsNCisJCXNpbXBsZS1h
dWRpby1jYXJkLGZyYW1lLW1hc3RlciA9IDwmY3B1ZGFpPjsNCisJCXNpbXBsZS1hdWRpby1jYXJk
LGJpdGNsb2NrLW1hc3RlciA9IDwmY3B1ZGFpPjsNCisJCXNpbXBsZS1hdWRpby1jYXJkLHdpZGdl
dHMgPQ0KKwkJCSJMaW5lIiwgIkxlZnQgTGluZSBPdXQgSmFjayIsDQorCQkJIkxpbmUiLCAiUmln
aHQgTGluZSBPdXQgSmFjayI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxyb3V0aW5nID0NCisJCQki
TGVmdCBMaW5lIE91dCBKYWNrIiwgIkxJTkVWT1VUTCIsDQorCQkJIlJpZ2h0IExpbmUgT3V0IEph
Y2siLCAiTElORVZPVVRSIjsNCisNCisJCWNwdWRhaTogc2ltcGxlLWF1ZGlvLWNhcmQsY3B1IHsN
CisJCQlzb3VuZC1kYWkgPSA8JnNhaTM+Ow0KKwkJfTsNCisNCisJCXNpbXBsZS1hdWRpby1jYXJk
LGNvZGVjIHsNCisJCQlzb3VuZC1kYWkgPSA8JndtODUyND47DQorCQkJY2xvY2tzID0gPCZjbGsg
SU1YOE1NX0NMS19TQUkzX1JPT1Q+Ow0KKwkJfTsNCisJfTsNCiB9Ow0KIA0KICZmZWMxIHsNCkBA
IC02MSw2ICs5MiwxNSBAQA0KIAl9Ow0KIH07DQogDQorJnNhaTMgew0KKwlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc2FpMz47DQorCWFzc2lnbmVk
LWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJMz47DQorCWFzc2lnbmVkLWNsb2NrLXBhcmVu
dHMgPSA8JmNsayBJTVg4TU1fQVVESU9fUExMMV9PVVQ+Ow0KKwlhc3NpZ25lZC1jbG9jay1yYXRl
cyA9IDwyNDU3NjAwMD47DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KICZ1YXJ0MiB7IC8q
IGNvbnNvbGUgKi8NCiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0g
PCZwaW5jdHJsX3VhcnQyPjsNCkBAIC0xMjQsMTIgKzE2NCwyNyBAQA0KIAkJPjsNCiAJfTsNCiAN
CisJcGluY3RybF9ncGlvX3dsZjogZ3Bpb3dsZmdycCB7DQorCQlmc2wscGlucyA9IDwNCisJCQlN
WDhNTV9JT01VWENfSTJDNF9TREFfR1BJTzVfSU8yMSAgICAgICAgMHhkNg0KKwkJPjsNCisJfTsN
CisNCiAJcGluY3RybF9yZWdfdXNkaGMyX3ZtbWM6IHJlZ3VzZGhjMnZtbWMgew0KIAkJZnNsLHBp
bnMgPSA8DQogCQkJTVg4TU1fSU9NVVhDX1NEMl9SRVNFVF9CX0dQSU8yX0lPMTkJMHg0MQ0KIAkJ
PjsNCiAJfTsNCiANCisJcGluY3RybF9zYWkzOiBzYWkzZ3JwIHsNCisJCWZzbCxwaW5zID0gPA0K
KwkJCU1YOE1NX0lPTVVYQ19TQUkzX1RYRlNfU0FJM19UWF9TWU5DICAgICAweGQ2DQorCQkJTVg4
TU1fSU9NVVhDX1NBSTNfVFhDX1NBSTNfVFhfQkNMSyAgICAgIDB4ZDYNCisJCQlNWDhNTV9JT01V
WENfU0FJM19NQ0xLX1NBSTNfTUNMSyAgICAgICAgMHhkNg0KKwkJCU1YOE1NX0lPTVVYQ19TQUkz
X1RYRF9TQUkzX1RYX0RBVEEwICAgICAweGQ2DQorCQk+Ow0KKwl9Ow0KKw0KIAlwaW5jdHJsX3Vh
cnQyOiB1YXJ0MmdycCB7DQogCQlmc2wscGlucyA9IDwNCiAJCQlNWDhNTV9JT01VWENfVUFSVDJf
UlhEX1VBUlQyX0RDRV9SWAkweDE0MA0KLS0gDQoyLjE3LjENCg0K
