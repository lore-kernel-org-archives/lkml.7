Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E37C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8276421479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YY0ZZheE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfDTJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:12:59 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:10403
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbfDTJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPgVZdLPF06Qa9k9xuk14H/NCyok7cRiuYVxIU5wZPc=;
 b=YY0ZZheEDTK/MTO5DmqzO+LrwjsOsgYQKw8VJATaG3ir+AZtA9qZClxMxS6iu2IGWjxslcwsNG+djmTv18ISnPPWsKv5vbOHp9SZJDA/BYT5xiYe51MsgZRoijFGtA7H+XwA6TCYXVc7ck/mJ21lYBkZVvKTRqeAtCxgSJXyd5g=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3872.eurprd04.prod.outlook.com (52.134.16.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Sat, 20 Apr 2019 09:12:52 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019
 09:12:52 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Thread-Topic: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Thread-Index: AQHU91k7cr861jj9f0mUUu5r+kT9Cw==
Date:   Sat, 20 Apr 2019 09:12:52 +0000
Message-ID: <20190420091239.3793-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0275.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::42) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14fcbe1e-7b38-455d-b2a0-08d6c5705dec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3872;
x-ms-traffictypediagnostic: VI1PR0402MB3872:
x-microsoft-antispam-prvs: <VI1PR0402MB38726009F7C1A1C3CB4C2EC4F9200@VI1PR0402MB3872.eurprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(14454004)(102836004)(386003)(53936002)(3846002)(186003)(81166006)(305945005)(6506007)(6512007)(26005)(5640700003)(2616005)(2351001)(476003)(54906003)(478600001)(486006)(316002)(52116002)(99286004)(50226002)(8936002)(1730700003)(8676002)(6916009)(6486002)(6436002)(7736002)(6116002)(2906002)(5660300002)(66066001)(68736007)(86362001)(1076003)(2501003)(66556008)(81156014)(14444005)(256004)(97736004)(44832011)(36756003)(73956011)(66446008)(71200400001)(71190400001)(64756008)(4326008)(66476007)(66946007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3872;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UEhXnS0NTu0FXZpUMPl1Es2b8b9pxqvwONy0aHrGbIiTXKP7rSM5ya3IpYr/4T3QvHSoznAhig//P1GSey/aisSfCw70r8U1/ftelCyq6p3c05i+9bj+EpQygbpZDKd7Y564l9aqdXE7eMjI7Db329gDcgukN/eY1yyUcgcW1mJ5r7K2Z1zwgoE+PqFscAwYAq3nuADTKs6Kx21KopzI2RGuYAreZo/eAMz5bKARwqN3HTcWwVpHA9AGsDhBOsiShrONIlMZp4GiKADRMeQzQNn9zOy8NBaPqrWl5eBGCAuE9z+GG95+DUDJRTj7AZiksEvo0X9Bq2+6kfkCQtBhS3MgjbZVJE8At5Fq71bbnWEj/OK6BoURSNIaSA9pL6u4pAcuzQ/M14RNW/J7UJRGOgexMjQfgEkjAdypT0CkYWQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fcbe1e-7b38-455d-b2a0-08d6c5705dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 09:12:52.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KDQpTQUkgaGFzIDQg
Y2xvY2sgc291cmNlcywgd2hpY2ggY2FuIGJlIHNlbGVjdGVkIHVzaW5nIE1TRUwNCmJpdCBvZiBT
QUkgVENSMiByZWdpc3Rlci4NCg0KT24gaW14Ni83IG1jbGswIGFuZCBtY2xrMSBhbHdheXMgcG9p
bnQgdG8gdGhlIHNhbWUgY2xvY2sNCnNvdXJjZS4gQW55aG93LCB0aGlzIGlzIG5vIGxvbmdlciB0
cnVlIGZvciBpbXg4Lg0KDQpGb3IgdGhpcyByZWFzb24sIHdlIG5lZWQgdG8gYWRkIG1jbGswIGFu
ZCBoYW5kbGUgaXQNCmluIGEgZ2VuZXJpYyB3YXkgaW4gU0FJIGRyaXZlci4NCg0KU2lnbmVkLW9m
Zi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KU2lnbmVkLW9mZi1i
eTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnN4LmR0c2kgfCA2ICsrKystLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1
bC5kdHNpIHwgOSArKysrKystLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3cy5kdHNpICB8IDkg
KysrKysrLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kgYi9hcmNo
L2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0KaW5kZXggYjE2YTEyMzk5MGEyLi42ODIyMDdiNWQ4
NjggMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0KKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kNCkBAIC0xMDcxLDkgKzEwNzEsMTAgQEANCiAJCQkJ
cmVnID0gPDB4MDIxZDQwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDk3
IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KIAkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlNYX0NMS19T
QUkxX0lQRz4sDQorCQkJCQkgPCZjbGtzIElNWDZTWF9DTEtfU0FJMT4sDQogCQkJCQkgPCZjbGtz
IElNWDZTWF9DTEtfU0FJMT4sDQogCQkJCQkgPCZjbGtzIDA+LCA8JmNsa3MgMD47DQotCQkJCWNs
b2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCWNsb2Nr
LW5hbWVzID0gImJ1cyIsICJtY2xrMCIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQogCQkJ
CWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCWRtYXMgPSA8JnNkbWEgMzEgMjQgMD4sIDwm
c2RtYSAzMiAyNCAwPjsNCiAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCkBAIC0xMDkwLDkgKzEw
OTEsMTAgQEANCiAJCQkJcmVnID0gPDB4MDIxZGMwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDk4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KIAkJCQljbG9ja3MgPSA8JmNs
a3MgSU1YNlNYX0NMS19TQUkyX0lQRz4sDQorCQkJCQkgPCZjbGtzIElNWDZTWF9DTEtfU0FJMj4s
DQogCQkJCQkgPCZjbGtzIElNWDZTWF9DTEtfU0FJMj4sDQogCQkJCQkgPCZjbGtzIDA+LCA8JmNs
a3MgMD47DQotCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xr
MyI7DQorCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMCIsICJtY2xrMSIsICJtY2xrMiIs
ICJtY2xrMyI7DQogCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCWRtYXMgPSA8JnNk
bWEgMzMgMjQgMD4sIDwmc2RtYSAzNCAyNCAwPjsNCiAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZ1bC5kdHNpDQppbmRleCBiYmYwMTBjNzMzMzYuLmU5NjkxMzA2ZjU1NyAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNpDQorKysgYi9hcmNoL2FybS9i
b290L2R0cy9pbXg2dWwuZHRzaQ0KQEAgLTMwNCw5ICszMDQsMTAgQEANCiAJCQkJCXJlZyA9IDww
eDAyMDI4MDAwIDB4NDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTcgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlVMX0NMS19TQUkxX0lQ
Rz4sDQorCQkJCQkJIDwmY2xrcyBJTVg2VUxfQ0xLX1NBSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1Y
NlVMX0NMS19TQUkxPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtfRFVNTVk+LCA8JmNsa3Mg
SU1YNlVMX0NMS19EVU1NWT47DQotCQkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazEiLCAi
bWNsazIiLCAibWNsazMiOw0KKwkJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGswIiwgIm1j
bGsxIiwgIm1jbGsyIiwgIm1jbGszIjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgMzUgMjQgMD4sDQog
CQkJCQkgICAgICAgPCZzZG1hIDM2IDI0IDA+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4
IjsNCkBAIC0zMTksOSArMzIwLDEwIEBADQogCQkJCQlyZWcgPSA8MHgwMjAyYzAwMCAweDQwMDA+
Ow0KIAkJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDk4IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
IAkJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZVTF9DTEtfU0FJMl9JUEc+LA0KKwkJCQkJCSA8JmNs
a3MgSU1YNlVMX0NMS19TQUkyPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtfU0FJMj4sDQog
CQkJCQkJIDwmY2xrcyBJTVg2VUxfQ0xLX0RVTU1ZPiwgPCZjbGtzIElNWDZVTF9DTEtfRFVNTVk+
Ow0KLQkJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwgIm1jbGszIjsN
CisJCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMCIsICJtY2xrMSIsICJtY2xrMiIsICJt
Y2xrMyI7DQogCQkJCQlkbWFzID0gPCZzZG1hIDM3IDI0IDA+LA0KIAkJCQkJICAgICAgIDwmc2Rt
YSAzOCAyNCAwPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQpAQCAtMzM0LDkgKzMz
NiwxMCBAQA0KIAkJCQkJcmVnID0gPDB4MDIwMzAwMDAgMHg0MDAwPjsNCiAJCQkJCWludGVycnVw
dHMgPSA8R0lDX1NQSSAyNCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJCWNsb2NrcyA9IDwm
Y2xrcyBJTVg2VUxfQ0xLX1NBSTNfSVBHPiwNCisJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtfU0FJ
Mz4sDQogCQkJCQkJIDwmY2xrcyBJTVg2VUxfQ0xLX1NBSTM+LA0KIAkJCQkJCSA8JmNsa3MgSU1Y
NlVMX0NMS19EVU1NWT4sIDwmY2xrcyBJTVg2VUxfQ0xLX0RVTU1ZPjsNCi0JCQkJCWNsb2NrLW5h
bWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCQljbG9jay1uYW1l
cyA9ICJidXMiLCAibWNsazAiLCAibWNsazEiLCAibWNsazIiLCAibWNsazMiOw0KIAkJCQkJZG1h
cyA9IDwmc2RtYSAzOSAyNCAwPiwNCiAJCQkJCSAgICAgICA8JnNkbWEgNDAgMjQgMD47DQogCQkJ
CQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDdzLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg3cy5kdHNpDQppbmRleCAwYjAxMTA5
YWMwYTkuLjY5M2I4OGUzNzc5OSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdz
LmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdzLmR0c2kNCkBAIC04ODQsMTAgKzg4
NCwxMSBAQA0KIAkJCQkJcmVnID0gPDB4MzA4YTAwMDAgMHgxMDAwMD47DQogCQkJCQlpbnRlcnJ1
cHRzID0gPEdJQ19TUEkgOTUgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQljbG9ja3MgPSA8
JmNsa3MgSU1YN0RfU0FJMV9JUEdfQ0xLPiwNCisJCQkJCQkgPCZjbGtzIElNWDdEX1NBSTFfUk9P
VF9DTEs+LA0KIAkJCQkJCSA8JmNsa3MgSU1YN0RfU0FJMV9ST09UX0NMSz4sDQogCQkJCQkJIDwm
Y2xrcyBJTVg3RF9DTEtfRFVNTVk+LA0KIAkJCQkJCSA8JmNsa3MgSU1YN0RfQ0xLX0RVTU1ZPjsN
Ci0JCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQor
CQkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazAiLCAibWNsazEiLCAibWNsazIiLCAibWNs
azMiOw0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEg
OCAyNCAwPiwgPCZzZG1hIDkgMjQgMD47DQogCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KQEAg
LTg5OSwxMCArOTAwLDExIEBADQogCQkJCQlyZWcgPSA8MHgzMDhiMDAwMCAweDEwMDAwPjsNCiAJ
CQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA5NiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJ
CWNsb2NrcyA9IDwmY2xrcyBJTVg3RF9TQUkyX0lQR19DTEs+LA0KKwkJCQkJCSA8JmNsa3MgSU1Y
N0RfU0FJMl9ST09UX0NMSz4sDQogCQkJCQkJIDwmY2xrcyBJTVg3RF9TQUkyX1JPT1RfQ0xLPiwN
CiAJCQkJCQkgPCZjbGtzIElNWDdEX0NMS19EVU1NWT4sDQogCQkJCQkJIDwmY2xrcyBJTVg3RF9D
TEtfRFVNTVk+Ow0KLQkJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwg
Im1jbGszIjsNCisJCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xrMCIsICJtY2xrMSIsICJt
Y2xrMiIsICJtY2xrMyI7DQogCQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJZG1h
cyA9IDwmc2RtYSAxMCAyNCAwPiwgPCZzZG1hIDExIDI0IDA+Ow0KIAkJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCkBAIC05MTQsMTAgKzkxNiwxMSBAQA0KIAkJCQkJcmVnID0gPDB4MzA4YzAwMDAg
MHgxMDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNTAgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YN0RfU0FJM19JUEdfQ0xLPiwNCisJCQkJ
CQkgPCZjbGtzIElNWDdEX1NBSTNfUk9PVF9DTEs+LA0KIAkJCQkJCSA8JmNsa3MgSU1YN0RfU0FJ
M19ST09UX0NMSz4sDQogCQkJCQkJIDwmY2xrcyBJTVg3RF9DTEtfRFVNTVk+LA0KIAkJCQkJCSA8
JmNsa3MgSU1YN0RfQ0xLX0RVTU1ZPjsNCi0JCQkJCWNsb2NrLW5hbWVzID0gImJ1cyIsICJtY2xr
MSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazAi
LCAibWNsazEiLCAibWNsazIiLCAibWNsazMiOw0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4
IjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgMTIgMjQgMD4sIDwmc2RtYSAxMyAyNCAwPjsNCiAJCQkJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQotLSANCjIuMTcuMQ0KDQo=
