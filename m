Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059A4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B820C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lCvoVtmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfDVTgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:36:41 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:46957
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDVTgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=803L7SlD8aY7/wbrmMqaS5xgmwRF2TASNhHJ6qX5+fw=;
 b=lCvoVtmo9HZBTr1RrKdqP9s6/egx50ucFYDQ+E7Zdn86uBM8eANfMDqj3cGwJHFByGE7MK1j3eOuoFTeoWS0EojmY/aZYvicxrG+IoxTXsQ2q/MGKx9OSvICfKBcdeo1cwpFqfmOttalFTuOYuXMS70TtP8/lyLFSlEX8iqYhkE=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2861.eurprd04.prod.outlook.com (10.175.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 19:36:00 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 19:36:00 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Index: AQHU+UKd3f/INs87BEebFb8olMJ7/A==
Date:   Mon, 22 Apr 2019 19:36:00 +0000
Message-ID: <20190422193542.2853-3-daniel.baluta@nxp.com>
References: <20190422193542.2853-1-daniel.baluta@nxp.com>
In-Reply-To: <20190422193542.2853-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93fe9129-1c19-4196-af1d-08d6c759bfde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2861;
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-microsoft-antispam-prvs: <VI1PR0402MB28612DEF8B8514A71E7244BCF9220@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(102836004)(6116002)(3846002)(54906003)(2616005)(11346002)(446003)(386003)(2906002)(6506007)(476003)(25786009)(4326008)(97736004)(26005)(186003)(44832011)(36756003)(73956011)(5660300002)(2501003)(5640700003)(1076003)(71190400001)(71200400001)(66946007)(86362001)(66476007)(66066001)(64756008)(66446008)(66556008)(99286004)(478600001)(7736002)(68736007)(6436002)(52116002)(6486002)(76176011)(6916009)(256004)(14444005)(53936002)(6512007)(486006)(316002)(14454004)(305945005)(8676002)(2351001)(81166006)(81156014)(50226002)(1730700003)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2861;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nfVQE67q9WR/6N5hx2B7W20fL+4cTstWwjXaxLTE2LPIOvCdUG+tnHgtr38Bc9X20Som08/aucntGf6XWKpKaWBzuskSmHHC6KXONOFLKckz5Un+eGFL120X0lpwKIUhfe0x7xiZ/nOObanfwFrOjxEeSfVS/kwyn7/UK52tCO5uuuB1Pzv0QCidLeeIbUttA4IQW5dfrc1ZyrKXPyXSp1PtvMKcwWz/3qHzXyxX6FINW6g6VWSkD55tAvqV75mj3t3kH0wT2B71tA6nqFnnvzzpxvSYtH5dPPGi0CGgSu+RRFbxPtEVxjeoZZmax07U4rImGltCWnX8wdrqz2dGLJPPYG5HpO3YrAzbV7d63yXiyTzrNOgsgQY58B53mf96F48zOHXuTwO/bCRJaNMMnTuwE0wJ8VrSV3++J/uqO5U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe9129-1c19-4196-af1d-08d6c759bfde
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 19:36:00.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgb25lIHdtODUyNCBhdWRpbyBjb2RlYyBjb25uZWN0ZWQgd2l0aA0KU0FJMyBk
aWdpdGFsIGF1ZGlvIGludGVyZmFjZS4NCg0KVGhpcyBwYXRjaCB1c2VzIHNpbXBsZS1jYXJkIG1h
Y2hpbmUgZHJpdmVyIGluIG9yZGVyDQp0byBlbmFibGUgd204NTI0IGNvZGVjLg0KDQpXZSBuZWVk
IHRvIHNldDoNCgkqIFNBSTMgcGluY3RybCBjb25maWd1cmF0aW9uDQoJKiBjbG9jayBoaWVyYXJj
aHkNCgkqIGNvZGVjIG5vZGUNCgkqIHNpbXBsZS1jYXJkIGNvbmZpZ3VyYXRpb24NCg0KU2lnbmVk
LW9mZi1ieTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KLS0tDQogYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMgfCA0OCArKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzDQppbmRleCAyZDVkODk0NzVi
NzYuLjIwN2IxMzI2NmE5NiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbS1ldmsuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0tZXZrLmR0cw0KQEAgLTM3LDYgKzM3LDM1IEBADQogCQlncGlvID0gPCZncGlvMiAxOSBH
UElPX0FDVElWRV9ISUdIPjsNCiAJCWVuYWJsZS1hY3RpdmUtaGlnaDsNCiAJfTsNCisNCisJd204
NTI0OiBhdWRpby1jb2RlYyB7DQorCQkjc291bmQtZGFpLWNlbGxzID0gPDA+Ow0KKwkJY29tcGF0
aWJsZSA9ICJ3bGYsd204NTI0IjsNCisJCXdsZixtdXRlLWdwaW9zID0gPCZncGlvNSAyMSBHUElP
X0FDVElWRV9MT1c+Ow0KKwl9Ow0KKw0KKwlzb3VuZC13bTg1MjQgew0KKwkJY29tcGF0aWJsZSA9
ICJzaW1wbGUtYXVkaW8tY2FyZCI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxuYW1lID0gIndtODUy
NC1hdWRpbyI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxmb3JtYXQgPSAiaTJzIjsNCisJCXNpbXBs
ZS1hdWRpby1jYXJkLGZyYW1lLW1hc3RlciA9IDwmY3B1ZGFpPjsNCisJCXNpbXBsZS1hdWRpby1j
YXJkLGJpdGNsb2NrLW1hc3RlciA9IDwmY3B1ZGFpPjsNCisJCXNpbXBsZS1hdWRpby1jYXJkLHdp
ZGdldHMgPQ0KKwkJCSJMaW5lIiwgIkxlZnQgTGluZSBPdXQgSmFjayIsDQorCQkJIkxpbmUiLCAi
UmlnaHQgTGluZSBPdXQgSmFjayI7DQorCQlzaW1wbGUtYXVkaW8tY2FyZCxyb3V0aW5nID0NCisJ
CQkiTGVmdCBMaW5lIE91dCBKYWNrIiwgIkxJTkVWT1VUTCIsDQorCQkJIlJpZ2h0IExpbmUgT3V0
IEphY2siLCAiTElORVZPVVRSIjsNCisNCisJCWNwdWRhaTogc2ltcGxlLWF1ZGlvLWNhcmQsY3B1
IHsNCisJCQlzb3VuZC1kYWkgPSA8JnNhaTM+Ow0KKwkJfTsNCisNCisJCWxpbmtfY29kZWM6IHNp
bXBsZS1hdWRpby1jYXJkLGNvZGVjIHsNCisJCQlzb3VuZC1kYWkgPSA8JndtODUyND47DQorCQkJ
Y2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19TQUkzX1JPT1Q+Ow0KKwkJfTsNCisJfTsNCiB9Ow0K
IA0KICZmZWMxIHsNCkBAIC02MSw2ICs5MCwxNSBAQA0KIAl9Ow0KIH07DQogDQorJnNhaTMgew0K
KwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc2Fp
Mz47DQorCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJMz47DQorCWFzc2ln
bmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsayBJTVg4TU1fQVVESU9fUExMMV9PVVQ+Ow0KKwlhc3Np
Z25lZC1jbG9jay1yYXRlcyA9IDwyNDU3NjAwMD47DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0K
Kw0KICZ1YXJ0MiB7IC8qIGNvbnNvbGUgKi8NCiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
CiAJcGluY3RybC0wID0gPCZwaW5jdHJsX3VhcnQyPjsNCkBAIC0xMzAsNiArMTY4LDE2IEBADQog
CQk+Ow0KIAl9Ow0KIA0KKwlwaW5jdHJsX3NhaTM6IHNhaTNncnAgew0KKwkJZnNsLHBpbnMgPSA8
DQorCQkJTVg4TU1fSU9NVVhDX1NBSTNfVFhGU19TQUkzX1RYX1NZTkMgICAgIDB4ZDYNCisJCQlN
WDhNTV9JT01VWENfU0FJM19UWENfU0FJM19UWF9CQ0xLICAgICAgMHhkNg0KKwkJCU1YOE1NX0lP
TVVYQ19TQUkzX01DTEtfU0FJM19NQ0xLICAgICAgICAweGQ2DQorCQkJTVg4TU1fSU9NVVhDX1NB
STNfVFhEX1NBSTNfVFhfREFUQTAgICAgIDB4ZDYNCisJCQlNWDhNTV9JT01VWENfSTJDNF9TREFf
R1BJTzVfSU8yMSAgICAgICAgMHhkNg0KKwkJPjsNCisJfTsNCisNCiAJcGluY3RybF91YXJ0Mjog
dWFydDJncnAgew0KIAkJZnNsLHBpbnMgPSA8DQogCQkJTVg4TU1fSU9NVVhDX1VBUlQyX1JYRF9V
QVJUMl9EQ0VfUlgJMHgxNDANCi0tIA0KMi4xNy4xDQoNCg==
