Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB715C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B457B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tTmKKF7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDZIGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:33 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:16693
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfDZIGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD+QPTY0y4lZTlNN04nxc1CDkqMHXryEZHbv7F7Jmnk=;
 b=tTmKKF7vxw52DqgUq+BT2G3KJUf9hRmW2Biuc+rSituLFGx4EHJeS2dKGMnJ2UUH7XSEn3B6Je4cUXgojLCOadlkGSbTcPl3cecFAt1hOvjMFwiI5o+SmzTusKO923tOJ83wHpyjXWVhFhakhJuafamPba+Pm5LtxovBt34ppDs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:06:27 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:06:27 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
Thread-Topic: [PATCH v2 14/15] ARM: dts: imx6sll: correct ecspi/sdma
 compatible
Thread-Index: AQHU/AbyqUitNwSO9kivEJPchNv52g==
Date:   Fri, 26 Apr 2019 08:06:26 +0000
Message-ID: <1556265512-9130-15-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82a2a4a9-084b-4234-8af0-08d6ca1e14cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-microsoft-antispam-prvs: <VI1PR04MB61098EF757CDD47CFE1A26FE893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1kxliQ432mAuv0itRz6eUWfoBSj51BG1BWnuquNSP7uX1B55yA3JMTQSIttloQKu34vCt7hgY6rqJmVUF740cm7kIblGop05KShmeEG+x2H0nfuVrZT9BJwb2yoEbzFxVElZ1MigHhC/8cQOSzskrX3bIN4zt0gWTNY5hh3WTiVdIcGe84ELB1jLN3rWiomDMPP4MuiYBcSbkZR7RBdECbkBvzfrC+FfqZNFioV4uxuhCjCtj86N4bEJD2O8T+IdrU3ZaOpJBz+TynzbGo19jUlv2grSiXSNHWI3IHpEvLaeWdTuM8pxUJ1YUfIwJ4txWMtihOOvCQACiEzKBz0xMY9UYiL7+7+oaBbJ0efqliClNaIBKxsgFYZegKeuXGPuy4wi28UtbXi9XxtLWDOp05lNThBSNMG3zuekfFDrAU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a2a4a9-084b-4234-8af0-08d6ca1e14cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:06:26.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29ycmVjdCBlY3NwaS9zZG1hIGNvbXBhdGlibGUgc2luY2UgZWNzcGkgZXJyYXRhIEVSUjAwOTE2
NSB3aGljaA0KaXMgbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQoNClNpZ25lZC1vZmYtYnk6
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzbGwuZHRzaSB8IDEwICsrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnNsbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQppbmRleCAxYjQ4
OTlmLi5hYzA2NDcxIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNp
DQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCkBAIC0xODMsNyArMTgzLDcg
QEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGkxOiBzcGlAMjAwODAwMCB7DQotCQkJCQljb21wYXRp
YmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJl
ZyA9IDwweDAyMDA4MDAwIDB4NDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzEg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCkBAIC0xOTUsNyArMTk1LDcgQEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGkyOiBz
cGlAMjAwYzAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNs
LGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAi
ZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9IDwweDAyMDBjMDAwIDB4NDAwMD47DQogCQkJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlk
bWFzID0gPCZzZG1hIDUgNyAxPiwgPCZzZG1hIDYgNyAyPjsNCkBAIC0yMDcsNyArMjA3LDcgQEAN
CiAJCQkJfTsNCiANCiAJCQkJZWNzcGkzOiBzcGlAMjAxMDAwMCB7DQotCQkJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGli
bGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9
IDwweDAyMDEwMDAwIDB4NDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzMgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFzID0gPCZzZG1hIDcgNyAxPiwgPCZzZG1hIDgg
NyAyPjsNCkBAIC0yMTksNyArMjE5LDcgQEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGk0OiBzcGlA
MjAxNDAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlt
eDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNs
LGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9IDwweDAyMDE0MDAwIDB4NDAwMD47DQogCQkJCQlp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgMzQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFz
ID0gPCZzZG1hIDkgNyAxPiwgPCZzZG1hIDEwIDcgMj47DQpAQCAtNjE5LDcgKzYxOSw3IEBADQog
CQkJfTsNCiANCiAJCQlzZG1hOiBkbWEtY29udHJvbGxlckAyMGVjMDAwIHsNCi0JCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14NnNsbC1zZG1hIiwgImZzbCxpbXgzNS1zZG1hIjsNCisJCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14NnNsbC1zZG1hIiwgImZzbCxpbXg2cS1zZG1hIjsNCiAJCQkJcmVnID0g
PDB4MDIwZWMwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U0xMX0NMS19JUEc+LA0K
LS0gDQoyLjcuNA0KDQo=
