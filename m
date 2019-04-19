Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0782BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB278217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hPPQTx5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfDSUUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:20:52 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27715
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfDSUUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8t4Z2B0HxQ84uDbmdFEnLjkX7+aloEp8achwIls+xw=;
 b=hPPQTx5wahogBI2aUcdOND4+GuHONqiI2Sf7r9Y0ClIUqWlntljBuDd1mDddNH1lwm80iVOX5nb/nj95dglujlKmdbshcHzjgHKU2SN+5UPyHymFw+S4CnhWLiSVNfTdnPtUsBs7esO9bNvJQax844yhaWA1I5NsyL7uFFJSG3M=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 20:20:42 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 20:20:42 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Thread-Index: AQHU9u1belSuPjg9j0eSzCLrjjl2TQ==
Date:   Fri, 19 Apr 2019 20:20:40 +0000
Message-ID: <20190419202024.27314-3-daniel.baluta@nxp.com>
References: <20190419202024.27314-1-daniel.baluta@nxp.com>
In-Reply-To: <20190419202024.27314-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c1f26bc-0de4-418a-35dc-08d6c5047ddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3392;
x-ms-traffictypediagnostic: VI1PR0402MB3392:
x-microsoft-antispam-prvs: <VI1PR0402MB33923F14C88B89434AFD1B1CF9270@VI1PR0402MB3392.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(81166006)(68736007)(1730700003)(8936002)(81156014)(44832011)(1076003)(2501003)(50226002)(71200400001)(54906003)(4326008)(52116002)(71190400001)(25786009)(8676002)(99286004)(316002)(76176011)(66066001)(5660300002)(305945005)(7736002)(53936002)(86362001)(6436002)(6486002)(73956011)(5640700003)(14454004)(36756003)(6916009)(97736004)(102836004)(66556008)(66476007)(66446008)(386003)(64756008)(6512007)(478600001)(3846002)(256004)(6116002)(26005)(2906002)(66946007)(446003)(11346002)(6506007)(2616005)(486006)(476003)(2351001)(14444005)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3392;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sH4CVlyJTFzRAH43r4ZHMbMJ5QxrOI1Vmfm7U8IBILIPjK5hjvm4Zpzf/f8x66q7Wp6LHf89Yo3pweBS/dZEGolCzREJ+tuQGPX/FpWTS0GHPua7hiDQ+3glYI44Kv+YmJD66qwkol6zg8HaMxXfIhLe9+T1mqnOMjgutePsoGTx0ZnhTe7IZJg2GHYfU28nt5ENqnBtlw6JtworRzmJDRgRjsIgbUfpW3V2lFaOTClCBKIRJ/uk0b+rIoW6p99EaJL+5hA/75/vVsHbtdplfBUmNxej3V/jpeSFt4bNPovtILqQkQBuXrT422J0wznnlmGM0wXuEuIGMPWVPr5Z2JmDo21e9q2zdtsH8KXIlQvQqH2PLYOW5F7TnaiWUe6ZfMdv725XXg65n06zxRdXmahN2/0lbPFPwog30l3MCHE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1f26bc-0de4-418a-35dc-08d6c5047ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 20:20:40.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBFVksgaGFzIG9uZSB3bTg1MjQgYXVkaW8gY29kZWMgY29ubmVjdGVkIHdpdGgNClNB
STMgZGlnaXRhbCBhdWRpbyBpbnRlcmZhY2UuDQoNClRoaXMgcGF0Y2ggdXNlcyBzaW1wbGUtY2Fy
ZCBtYWNoaW5lIGRyaXZlciBpbiBvcmRlcg0KdG8gZW5hYmxlIHdtODUyNCBjb2RlYy4NCg0KV2Ug
bmVlZCB0byBzZXQ6DQoJKiBTQUkzIHBpbmN0cmwgY29uZmlndXJhdGlvbg0KCSogY2xvY2sgaGll
cmFyY2h5DQoJKiBjb2RlYyBub2RlDQoJKiBzaW1wbGUtY2FyZCBjb25maWd1cmF0aW9uDQoNClNp
Z25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCi0tLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1ldmsuZHRzIHwgNDggKysrKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHMgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KaW5kZXggMmQ1ZDg5
NDc1Yjc2Li4yMDdiMTMyNjZhOTYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bW0tZXZrLmR0cw0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLWV2ay5kdHMNCkBAIC0zNyw2ICszNywzNSBAQA0KIAkJZ3BpbyA9IDwmZ3BpbzIg
MTkgR1BJT19BQ1RJVkVfSElHSD47DQogCQllbmFibGUtYWN0aXZlLWhpZ2g7DQogCX07DQorDQor
CXdtODUyNDogYXVkaW8tY29kZWMgew0KKwkJI3NvdW5kLWRhaS1jZWxscyA9IDwwPjsNCisJCWNv
bXBhdGlibGUgPSAid2xmLHdtODUyNCI7DQorCQl3bGYsbXV0ZS1ncGlvcyA9IDwmZ3BpbzUgMjEg
R1BJT19BQ1RJVkVfTE9XPjsNCisJfTsNCisNCisJc291bmQtd204NTI0IHsNCisJCWNvbXBhdGli
bGUgPSAic2ltcGxlLWF1ZGlvLWNhcmQiOw0KKwkJc2ltcGxlLWF1ZGlvLWNhcmQsbmFtZSA9ICJ3
bTg1MjQtYXVkaW8iOw0KKwkJc2ltcGxlLWF1ZGlvLWNhcmQsZm9ybWF0ID0gImkycyI7DQorCQlz
aW1wbGUtYXVkaW8tY2FyZCxmcmFtZS1tYXN0ZXIgPSA8JmNwdWRhaT47DQorCQlzaW1wbGUtYXVk
aW8tY2FyZCxiaXRjbG9jay1tYXN0ZXIgPSA8JmNwdWRhaT47DQorCQlzaW1wbGUtYXVkaW8tY2Fy
ZCx3aWRnZXRzID0NCisJCQkiTGluZSIsICJMZWZ0IExpbmUgT3V0IEphY2siLA0KKwkJCSJMaW5l
IiwgIlJpZ2h0IExpbmUgT3V0IEphY2siOw0KKwkJc2ltcGxlLWF1ZGlvLWNhcmQscm91dGluZyA9
DQorCQkJIkxlZnQgTGluZSBPdXQgSmFjayIsICJMSU5FVk9VVEwiLA0KKwkJCSJSaWdodCBMaW5l
IE91dCBKYWNrIiwgIkxJTkVWT1VUUiI7DQorDQorCQljcHVkYWk6IHNpbXBsZS1hdWRpby1jYXJk
LGNwdSB7DQorCQkJc291bmQtZGFpID0gPCZzYWkzPjsNCisJCX07DQorDQorCQlsaW5rX2NvZGVj
OiBzaW1wbGUtYXVkaW8tY2FyZCxjb2RlYyB7DQorCQkJc291bmQtZGFpID0gPCZ3bTg1MjQ+Ow0K
KwkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJM19ST09UPjsNCisJCX07DQorCX07DQog
fTsNCiANCiAmZmVjMSB7DQpAQCAtNjEsNiArOTAsMTUgQEANCiAJfTsNCiB9Ow0KIA0KKyZzYWkz
IHsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJs
X3NhaTM+Ow0KKwlhc3NpZ25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1NBSTM+Ow0KKwlh
c3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1NX0FVRElPX1BMTDFfT1VUPjsNCisJ
YXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MjQ1NzYwMDA+Ow0KKwlzdGF0dXMgPSAib2theSI7DQor
fTsNCisNCiAmdWFydDIgeyAvKiBjb25zb2xlICovDQogCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQogCXBpbmN0cmwtMCA9IDwmcGluY3RybF91YXJ0Mj47DQpAQCAtMTMwLDYgKzE2OCwxNiBA
QA0KIAkJPjsNCiAJfTsNCiANCisJcGluY3RybF9zYWkzOiBzYWkzZ3JwIHsNCisJCWZzbCxwaW5z
ID0gPA0KKwkJCU1YOE1NX0lPTVVYQ19TQUkzX1RYRlNfU0FJM19UWF9TWU5DICAgICAweGQ2DQor
CQkJTVg4TU1fSU9NVVhDX1NBSTNfVFhDX1NBSTNfVFhfQkNMSyAgICAgIDB4ZDYNCisJCQlNWDhN
TV9JT01VWENfU0FJM19NQ0xLX1NBSTNfTUNMSyAgICAgICAgMHhkNg0KKwkJCU1YOE1NX0lPTVVY
Q19TQUkzX1RYRF9TQUkzX1RYX0RBVEEwICAgICAweGQ2DQorCQkJTVg4TU1fSU9NVVhDX0kyQzRf
U0RBX0dQSU81X0lPMjEgICAgICAgIDB4ZDYNCisJCT47DQorCX07DQorDQogCXBpbmN0cmxfdWFy
dDI6IHVhcnQyZ3JwIHsNCiAJCWZzbCxwaW5zID0gPA0KIAkJCU1YOE1NX0lPTVVYQ19VQVJUMl9S
WERfVUFSVDJfRENFX1JYCTB4MTQwDQotLSANCjIuMTcuMQ0KDQo=
