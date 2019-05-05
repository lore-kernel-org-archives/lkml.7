Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD73C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FFE206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 13:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gUeEUN7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEEN2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 09:28:34 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:45831
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEEN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 09:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0sRY4MRlfUGqyv1fW60W7NMUpX7Lruwrq8nEp7FiPk=;
 b=gUeEUN7Mx03i3d75huV5hu5ZOOrTe2Fgnjt30vscjwsMSLi758kCP19YWnh0NLJ+lK56ENRUfIf6+5H1tDtp3GV3Y0jzhZP9D9lVZ200+HlVSAxjA/T/VFFLLbRifC82bxEj3+645XfQCrnhK3vZ2HRnruXKFHJV5kJS8ppZiFg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sun, 5 May 2019 13:28:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 13:28:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Topic: [PATCH 4/4] arm64: dts: imx: add i.MX8QXP ocotp support
Thread-Index: AQHVA0ZtsxbN8eaaUUa3sSDIde4/ig==
Date:   Sun, 5 May 2019 13:28:29 +0000
Message-ID: <20190505134130.28071-4-peng.fan@nxp.com>
References: <20190505134130.28071-1-peng.fan@nxp.com>
In-Reply-To: <20190505134130.28071-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7265ab6c-b5f3-4d7d-518d-08d6d15d8fb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4259;
x-ms-traffictypediagnostic: AM0PR04MB4259:
x-microsoft-antispam-prvs: <AM0PR04MB4259A9169BD637AC21C00A7388370@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(486006)(54906003)(110136005)(68736007)(446003)(2906002)(11346002)(476003)(2616005)(8936002)(8676002)(66066001)(81166006)(7416002)(7736002)(305945005)(44832011)(53936002)(36756003)(50226002)(4326008)(25786009)(86362001)(2201001)(1076003)(4744005)(5660300002)(81156014)(52116002)(99286004)(76176011)(102836004)(316002)(6506007)(3846002)(6116002)(386003)(478600001)(256004)(6512007)(71200400001)(14454004)(6486002)(6436002)(2501003)(66946007)(73956011)(186003)(71190400001)(66446008)(26005)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hGc3i8tyOAeLDi8SoPZmw0O1AtRwwQ9z+26S+2ecni9jm5zYKQS9n9kOzfrq9tap3MOV376IOSxQub3VfyQ/dkkMPoDW0RimlhoPtWrNAMQ4HpSeQhQGISCFIgBhd73upBX4uFjgnhmM1TXHqu+FqfS/2kDoJFZoz/EDcU+R6PFpk7eroHYIpR9lxym9xg3bSZAE+xJfRVzjaD5xu+3yOaE0/N3qGlgT10gp+Lsb9uzzxT63FzkTHkd96VVoRgfUKlRRofNz7vLszbIYjZZbQ1kviko2HrPycav1Zz8eBdVVtph9L2saV8YggOowrt8An44PjBZvM5gnAyDAjtSbjYaFBoR2OuJ87uN5hniRb3XsK4avKqRFffrgKb14UacQUmZrLD9gaj1cVeAjbA0+MCaFUR3fI7zhB6co0pKq6TA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7265ab6c-b5f3-4d7d-518d-08d6d15d8fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 13:28:29.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVg4UVhQIG9jb3RwIG5vZGUNCg0KU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQpDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCkNjOiBN
YXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KQ2M6IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCkNjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
DQpDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4NCkNj
OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQpDYzogTlhQIExpbnV4IFRlYW0g
PGxpbnV4LWlteEBueHAuY29tPg0KQ2M6IEFpc2hlbmcgRG9uZyA8YWlzaGVuZy5kb25nQG54cC5j
b20+DQpDYzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQpDYzogRGFuaWVsIEJh
bHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPg0KQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnDQpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQotLS0NCiBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCA2ICsrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhxeHAuZHRzaQ0KaW5kZXggMDY4M2VlMmE0OGFlLi5mMjk5OThkNzI3NGEgMTAwNjQ0
DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCisrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KQEAgLTE0MSw2ICsx
NDEsMTIgQEANCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLWlvbXV4YyI7DQogCQl9Ow0K
IA0KKwkJb2NvdHA6IGlteDhxeC1vY290cCB7DQorCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQor
CQkJI3NpemUtY2VsbHMgPSA8MT47DQorCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1vY290
cCI7DQorCQl9Ow0KKw0KIAkJcGQ6IGlteDhxeC1wZCB7DQogCQkJY29tcGF0aWJsZSA9ICJmc2ws
aW14OHF4cC1zY3UtcGQiOw0KIAkJCSNwb3dlci1kb21haW4tY2VsbHMgPSA8MT47DQotLSANCjIu
MTYuNA0KDQo=
