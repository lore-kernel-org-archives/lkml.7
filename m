Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2DC282E4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F20217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cqka8Sra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDSUUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:20:48 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27715
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfDSUUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXrXv4X4YFn63DQLFooL90ECcEzjNeix4/ShXi097JM=;
 b=cqka8SraFI+CkVYRNwc58lGqHuqF+nhlUuZB6EC7qYGKGg417/T0MfenXuVYPN0fisFJo13lpEmYOARBLhPELQZGHh4b7Bm1hqyxVbwcvZsXENpqx4ArJPo3zqCQ2l7KFrf6t/94uU/1MXy95UcPy7yin8RbfJUFDBAGaFyDys4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Fri, 19 Apr 2019 20:20:41 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::c16b:662d:9299:6be6%6]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 20:20:41 +0000
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
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Index: AQHU9u1b91prc4MsrUqY1UzjoRVnxg==
Date:   Fri, 19 Apr 2019 20:20:39 +0000
Message-ID: <20190419202024.27314-2-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4bac339b-6fcc-4afe-7b78-08d6c5047d55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3392;
x-ms-traffictypediagnostic: VI1PR0402MB3392:
x-microsoft-antispam-prvs: <VI1PR0402MB339283FB78999C67FB286D44F9270@VI1PR0402MB3392.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(189003)(199004)(81166006)(68736007)(1730700003)(8936002)(81156014)(44832011)(1076003)(2501003)(50226002)(71200400001)(54906003)(4326008)(52116002)(71190400001)(25786009)(8676002)(99286004)(316002)(76176011)(66066001)(5660300002)(305945005)(7736002)(53936002)(86362001)(6436002)(6486002)(73956011)(5640700003)(14454004)(36756003)(6916009)(97736004)(102836004)(66556008)(66476007)(66446008)(386003)(64756008)(6512007)(478600001)(3846002)(256004)(6116002)(26005)(2906002)(66946007)(446003)(11346002)(6506007)(2616005)(486006)(476003)(2351001)(14444005)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3392;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /pPzuj5SWGwH54yh82IRNirq5Dkb9+XTPhgudr5YH3qWyPLmbvw7d4agMSyO/NjesVujRCEJyYQ56ZrASRaPCqCfThU4WQ1FiMQnV0GqIsNzd+KO4ue9imF9KXSf0OcYmhNS5OW8gRqmKRKrxnkbgBSaERfT+Z4Qsq7QCrvj/LGFoRsW96F7Ux0mfQdaH54lw6XusGGeZ5bibPBN1P2R2m3F9Mfadh6DH9ICYa0NJfbqZmrIiUYf2JeR8vpB+mLUiWqLXgIJoyJsOrIiwDx74wgFPKOjzQSO8UnbAfO7BQaco3Tt1QLfIXeWffR4sXdpPQnx3uWDtmPcZNyz3bqVxw0uwuyjGVgL3W+WfTFE2SJ1h1UVrepYGPskj6IyYPJCyqtOiF0zmGipYnt8NjJr8iRbNvm2Osz+04YvluDR2IE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bac339b-6fcc-4afe-7b78-08d6c5047d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 20:20:39.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWDhNTSBoYXMgNSBTQUkgaW5zdGFuY2VzIHdpdGggdGhlIGZvbGxvd2luZyBiYXNlDQphZGRy
ZXNzZXMgYWNjb3JkaW5nIHRvIFJNLg0KDQpTQUkxIGJhc2UgYWRkcmVzczogMzAwMV8wMDAwaA0K
U0FJMiBiYXNlIGFkZHJlc3M6IDMwMDJfMDAwMGgNClNBSTMgYmFzZSBhZGRyZXNzOiAzMDAzXzAw
MDBoDQpTQUk1IGJhc2UgYWRkcmVzczogMzAwNV8wMDAwaA0KU0FJNiBiYXNlIGFkZHJlc3M6IDMw
MDZfMDAwMGgNCg0KU2lnbmVkLW9mZi1ieTogQmFpIFBpbmcgPHBpbmcuYmFpQG54cC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+DQotLS0N
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSB8IDY4ICsrKysrKysr
KysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCmluZGV4IGRlMzQ5OGMyZGQ0
NC4uZTlhMGIyYjYwNjNhIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQpAQCAtMTcxLDYgKzE3MSw3NCBAQA0KIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KIAkJ
CXJhbmdlczsNCiANCisJCQlzYWkxOiBzYWlAMzAwMTAwMDAgew0KKwkJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4bXEtc2FpIiwNCisJCQkJCSAgICAgImZzbCxpbXg2c3gtc2FpIjsNCisJCQkJcmVn
ID0gPDB4MzAwMTAwMDAgMHgxMDAwMD47DQorCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA5NSBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19TQUkx
X0lQRz4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19TQUkxX1JPT1Q+LA0KKwkJCQkJIDwmY2xr
IElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPjsNCisJCQkJY2xvY2st
bmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwgIm1jbGszIjsNCisJCQkJZG1hcyA9IDwm
c2RtYTIgMCAyIDA+LCA8JnNkbWEyIDEgMiAwPjsNCisJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4
IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCisJCQl9Ow0KKw0KKwkJCXNhaTI6IHNhaUAz
MDAyMDAwMCB7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1zYWkiLA0KKwkJCQkJICAg
ICAiZnNsLGlteDZzeC1zYWkiOw0KKwkJCQlyZWcgPSA8MHgzMDAyMDAwMCAweDEwMDAwPjsNCisJ
CQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDk2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJCQlj
bG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1NBSTJfSVBHPiwNCisJCQkJCTwmY2xrIElNWDhNTV9D
TEtfU0FJMl9ST09UPiwNCisJCQkJCTwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJTVg4
TU1fQ0xLX0RVTU1ZPjsNCisJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsy
IiwgIm1jbGszIjsNCisJCQkJZG1hcyA9IDwmc2RtYTIgMiAyIDA+LCA8JnNkbWEyIDMgMiAwPjsN
CisJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCisJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CisJCQl9Ow0KKw0KKwkJCXNhaTM6IHNhaUAzMDAzMDAwMCB7DQorCQkJCSNzb3VuZC1kYWktY2Vs
bHMgPSA8MD47DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1zYWkiLCAiZnNsLGlteDht
cS1zYWkiLCAiZnNsLGlteDZzeC1zYWkiOw0KKwkJCQlyZWcgPSA8MHgzMDAzMDAwMCAweDEwMDAw
PjsNCisJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDUwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
KwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1NBSTNfSVBHPiwNCisJCQkJCSA8JmNsayBJ
TVg4TU1fQ0xLX1NBSTNfUk9PVD4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT4sIDwm
Y2xrIElNWDhNTV9DTEtfRFVNTVk+Ow0KKwkJCQljbG9jay1uYW1lcyA9ICJidXMiLCAibWNsazEi
LCAibWNsazIiLCAibWNsazMiOw0KKwkJCQlkbWFzID0gPCZzZG1hMiA0IDIgMD4sIDwmc2RtYTIg
NSAyIDA+Ow0KKwkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KKwkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KKwkJCX07DQorDQorCQkJc2FpNTogc2FpQDMwMDUwMDAwIHsNCisJCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14OG1xLXNhaSIsICJmc2wsaW14NnN4LXNhaSI7DQorCQkJCXJlZyA9IDww
eDMwMDUwMDAwIDB4MTAwMDA+Ow0KKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTAgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQorCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0FJNV9JUEc+
LA0KKwkJCQkJIDwmY2xrIElNWDhNTV9DTEtfU0FJNV9ST09UPiwNCisJCQkJCSA8JmNsayBJTVg4
TU1fQ0xLX0RVTU1ZPiwgPCZjbGsgSU1YOE1NX0NMS19EVU1NWT47DQorCQkJCWNsb2NrLW5hbWVz
ID0gImJ1cyIsICJtY2xrMSIsICJtY2xrMiIsICJtY2xrMyI7DQorCQkJCWRtYXMgPSA8JnNkbWEy
IDggMiAwPiwgPCZzZG1hMiA5IDIgMD47DQorCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQor
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorCQkJfTsNCisNCisJCQlzYWk2OiBzYWlAMzAwNjAw
MDAgew0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtc2FpIiwgImZzbCxpbXg2c3gtc2Fp
IjsNCisJCQkJcmVnID0gPDB4MzAwNjAwMDAgMHgxMDAwMD47DQorCQkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSA5MCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCisJCQkJY2xvY2tzID0gPCZjbGsgSU1Y
OE1NX0NMS19TQUk2X0lQRz4sDQorCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19TQUk2X1JPT1Q+LA0K
KwkJCQkJIDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LCA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPjsN
CisJCQkJY2xvY2stbmFtZXMgPSAiYnVzIiwgIm1jbGsxIiwgIm1jbGsyIiwgIm1jbGszIjsNCisJ
CQkJZG1hcyA9IDwmc2RtYTIgMTAgMiAwPiwgPCZzZG1hMiAxMSAyIDA+Ow0KKwkJCQlkbWEtbmFt
ZXMgPSAicngiLCAidHgiOw0KKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KKwkJCX07DQorDQog
CQkJZ3BpbzE6IGdwaW9AMzAyMDAwMDAgew0KIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0t
Z3BpbyIsICJmc2wsaW14MzUtZ3BpbyI7DQogCQkJCXJlZyA9IDwweDMwMjAwMDAwIDB4MTAwMDA+
Ow0KLS0gDQoyLjE3LjENCg0K
