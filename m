Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF89BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0317206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZw+q9O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfDWNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:50:45 -0400
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:6311
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDWNun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUhYf5RiV4qSioOF8uRCXOiWhHgOJ5Rs+0yESgMT4KM=;
 b=BZw+q9O+d0i7j8hLyp9DgG0O09MQDMvXqcxFGsakRc4XU4Wk948chanSjWDjRg5sbtbtgGV27Ic04c2gLJyHP+dKrCTVCHw0U63VE4rUtt8gy/llOOd5oycdhlmYdvC4Aiw6UJFlPHaGB0v0y/dmy9C9iiPo+GxaSuLkUwinM9o=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5901.eurprd04.prod.outlook.com (20.178.205.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Tue, 23 Apr 2019 13:50:39 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 13:50:39 +0000
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
Subject: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script for
 SPI5 core"
Thread-Topic: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA
 script for SPI5 core"
Thread-Index: AQHU+duJhg3FYZIDo06xOgy8G5yNgg==
Date:   Tue, 23 Apr 2019 13:50:39 +0000
Message-ID: <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8846903c-fd78-482e-9907-08d6c7f2ab44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5901;
x-ms-traffictypediagnostic: VI1PR04MB5901:
x-microsoft-antispam-prvs: <VI1PR04MB59011E44427E2F1F93BBB11789230@VI1PR04MB5901.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(6506007)(102836004)(86362001)(97736004)(386003)(7416002)(36756003)(14444005)(2201001)(25786009)(4326008)(305945005)(26005)(256004)(73956011)(71190400001)(71200400001)(7736002)(64756008)(66556008)(66476007)(478600001)(66446008)(66946007)(11346002)(316002)(14454004)(446003)(81156014)(8676002)(68736007)(54906003)(81166006)(2501003)(8936002)(186003)(5660300002)(6436002)(110136005)(3846002)(6116002)(6486002)(53936002)(66066001)(6512007)(486006)(476003)(99286004)(76176011)(50226002)(2616005)(4744005)(52116002)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5901;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +wM91Tzc/lZU6WI0bcfRBrw9sGVdYCtxLYEdAehfGPaxl+1g5rFM+SyZZT98eAtkYT2JwjlcCKKjPSV5+QRtTQTgVkgOqADGpWr/PloR0PBS7ToTWXRiVYjncvjr0Qw5W1z086g5ghSaM6N2xmU5pepk0ykQ2bq+9juJZiy18x5tZRXnaiZ2yGfLlRZYb8r/IDzIuMxLZAcV6sDJ/ev9U9yABA8tNxnzC3Z965nzAgIIUrZFNwARZ3DPYPRDiInNiMygfvUnBP+eDDzcuUOWjPvi934zT/fzAts003nme/1vN7xQQDWDAydkOKtEJiZQIUHsGrAYN0fU+y7mFyjdZ6qJwAv04ImTBjXXslO0B68iTKZs8fDwqJsVXnNU11Lz/zT5vHXMqSpns3pMKsKpyTFbT5fSOtKF0g8KbA1OFtw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846903c-fd78-482e-9907-08d6c7f2ab44
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:50:39.6051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBkZjA3MTAxZTFjNGEyOWU4MjBkZjAyZjk5ODlhMDY2OTg4YjE2
MGU2Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQot
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnEuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kNCmluZGV4
IGQwMzhmNDEuLjcxNzU4OTggMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5k
dHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpDQpAQCAtMTcyLDcgKzE3Miw3
IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFfQ0xLX0VDU1BJNT4sDQogCQkJCQkJIDwm
Y2xrcyBJTVg2UV9DTEtfRUNTUEk1PjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIi
Ow0KLQkJCQkJZG1hcyA9IDwmc2RtYSAxMSA4IDE+LCA8JnNkbWEgMTIgOCAyPjsNCisJCQkJCWRt
YXMgPSA8JnNkbWEgMTEgNyAxPiwgPCZzZG1hIDEyIDcgMj47DQogCQkJCQlkbWEtbmFtZXMgPSAi
cngiLCAidHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCi0tIA0KMi43
LjQNCg0K
