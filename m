Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0CDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4839206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QHIOiPuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfDWNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:51:51 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:11021
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfDWNvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/IDcHs9jP09hmm9doyPTUcKo6IFh2atrqiRmGaEN0o=;
 b=QHIOiPuvNY6qBWqUZl1DpKrd5eVV8gMnQw13ErHSBjYH3N/VcAAlxhEu3nVe2VfApQn8W2T9bOJcpikG3JwmuCORBFoHINHYE1eNVT6+oepamdfR7lqhsHM8xd5/IGSM15Mq2owNy9cO/MZo4L5PCiDYSv6YGhv1BNwBC0ULED8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5854.eurprd04.prod.outlook.com (20.178.204.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:51:45 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:51:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
Thread-Topic: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma
 compatible
Thread-Index: AQHU+duwHt0Y+lCjeEKfty3+TgG1IA==
Date:   Tue, 23 Apr 2019 13:51:45 +0000
Message-ID: <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0960edff-7a6c-4538-a60b-08d6c7f2d284
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5854;
x-ms-traffictypediagnostic: VI1PR04MB5854:
x-microsoft-antispam-prvs: <VI1PR04MB585438105A84C78A9065E9CC89230@VI1PR04MB5854.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(25786009)(2201001)(71200400001)(86362001)(54906003)(110136005)(52116002)(6116002)(3846002)(2906002)(71190400001)(76176011)(14454004)(73956011)(2616005)(5660300002)(446003)(476003)(68736007)(6436002)(97736004)(11346002)(99286004)(478600001)(316002)(486006)(2501003)(66446008)(66476007)(102836004)(66066001)(26005)(6486002)(66556008)(386003)(53936002)(6506007)(50226002)(4326008)(186003)(6512007)(7736002)(81166006)(81156014)(305945005)(8676002)(8936002)(256004)(36756003)(66946007)(7416002)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5854;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: phpe7i+tq1KCCgLQ/Ez7KmFR3ZVdS2LD70OmRqboBARfgczgwMmkrJlufbNqkU23KNYN94tOuS0GewhWR6GPj+Vjz8CNOT8IlBVZ8es4mAchnyTqtoKVxAE8SolIzwhfB3DWWNehefnGez/VnEojNAPXoMU5HXXjhdt2n3lfkfB/aRXMJ6NFzBDwUbla8oHOc1kk5SRE/Eu76T5xbGDeQx5b5OofAcwllOqhTanFYijbc1DhAE8qPUrLAIAlOThlhZ3qynbaJsTcSRUid3/gbc6UAQ5V+149GQ9b7xNHVXt9Hj8RBO44w02B3faXLQZEard4kOaASMYt3RMzwwvFsOZyolud5KHzkQE5sBiOu1qboOb2wMdhz+nLDf732BZ/2dvHEYXrwgf0kbfNNfacKAY+Jl1uAabUtxNAaAdBDWE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0960edff-7a6c-4538-a60b-08d6c7f2d284
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:51:45.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29ycmVjdCBlY3NwaS9zZG1hIGNvbXBhdGlibGUgc2luY2UgZWNzcGkgZXJyYXRhIEVSUjAwOTE2
NQ0Kbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdv
bmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwu
ZHRzaSB8IDEwICsrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQppbmRleCAxYjQ4OTlmLi4wM2Yy
MTAzIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQorKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCkBAIC0xODMsNyArMTgzLDcgQEANCiAJCQkJ
fTsNCiANCiAJCQkJZWNzcGkxOiBzcGlAMjAwODAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSJm
c2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMDgwMDAgMHg0MDAwPjsNCiAJCQkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSAzMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJCWRt
YXMgPSA8JnNkbWEgMyA3IDE+LCA8JnNkbWEgNCA3IDI+Ow0KQEAgLTE5NSw3ICsxOTUsNyBAQA0K
IAkJCQl9Ow0KIA0KIAkJCQllY3NwaTI6IHNwaUAyMDBjMDAwIHsNCi0JCQkJCWNvbXBhdGlibGUg
PSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMGMwMDAgMHg0MDAwPjsN
CiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJ
CQkJCWRtYXMgPSA8JnNkbWEgNSA3IDE+LCA8JnNkbWEgNiA3IDI+Ow0KQEAgLTIwNyw3ICsyMDcs
NyBAQA0KIAkJCQl9Ow0KIA0KIAkJCQllY3NwaTM6IHNwaUAyMDEwMDAwIHsNCi0JCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMTAwMDAgMHg0
MDAwPjsNCiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzMyBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KQEAgLTIxOSw3
ICsyMTksNyBAQA0KIAkJCQl9Ow0KIA0KIAkJCQllY3NwaTQ6IHNwaUAyMDE0MDAwIHsNCi0JCQkJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMTQw
MDAgMHg0MDAwPjsNCiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzNCBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgOSA3IDE+LCA8JnNkbWEgMTAgNyAyPjsNCkBA
IC02MTksNyArNjE5LDcgQEANCiAJCQl9Ow0KIA0KIAkJCXNkbWE6IGRtYS1jb250cm9sbGVyQDIw
ZWMwMDAgew0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2c2xsLXNkbWEiLCAiZnNsLGlteDM1
LXNkbWEiOw0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2cS1zZG1hIiwgImZzbCxpbXgzNS1z
ZG1hIjsNCiAJCQkJcmVnID0gPDB4MDIwZWMwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrcyBJ
TVg2U0xMX0NMS19JUEc+LA0KLS0gDQoyLjcuNA0KDQo=
