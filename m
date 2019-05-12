Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C30C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F712133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMCciNio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfELKar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:30:47 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:27439
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfELKaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJHUg6iM/oMHI3oxzjNBdSsky7UYYJYg2O0AhXa92Ww=;
 b=QMCciNio8Edmsd699t3oLG3jdPpr21N/ZR5SjdgwENSL+PMWDDbB9N8YX66eGOH8LRdBCkqlIJom3xafTFzvKdrUt/2/M4GnqAG2cIbdSDYtsRmfOxiteAmvis36ByU/lJuCL/CuHzkvbCWJ5fQRJjuagjcd8wiZCiFPSIfkB6w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 10:30:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 10:30:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND] clk: imx7ulp: update nic1_bus_clk parent info
Thread-Topic: [PATCH RESEND] clk: imx7ulp: update nic1_bus_clk parent info
Thread-Index: AQHVCK2/SJLVf5bRSUqrwly/NQgOOw==
Date:   Sun, 12 May 2019 10:30:41 +0000
Message-ID: <1557656739-13120-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a38ca12-bc8f-4051-9d17-08d6d6c4e1db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB367512B57DE9A0E7BEA4BB1CF50E0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(14444005)(3846002)(6116002)(256004)(7416002)(2201001)(26005)(2906002)(66476007)(66556008)(64756008)(66446008)(5660300002)(8936002)(102836004)(73956011)(66946007)(6512007)(6506007)(71200400001)(386003)(99286004)(71190400001)(476003)(86362001)(2616005)(486006)(186003)(52116002)(110136005)(25786009)(14454004)(4326008)(305945005)(478600001)(2501003)(6436002)(7736002)(6486002)(53936002)(36756003)(68736007)(316002)(50226002)(15650500001)(66066001)(81166006)(81156014)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kyKjExGx9NSvqntaDLmzgoIfE3diKjqlSJLAsCwgZUjL2kJwuCo7qJ0S/QxMDqVWxQQe5kVjW7MAYFTM8j6M0JwRwRNnWBHJJnAzgdQTWagUsfdiAkTVPRbRzbELXktp71Xo1i2tE9219bTVmp5j17SkjsTEFCRBayE6fBcD+dcZkvXR+mDKwq4hN1Ap8z1+uLiEJgy0qJosPPvREtikaAEgqS7Poyx2vYs2zUhNDtLacgQY1WNmOnGi9AfKD7AC8KEIQPGtm2IYFsrFfz1f6Y0H0hMWIFmFotXIXGN+auNcF0Ka1lhVdOPmgdD+WFZo+LX08HcIdO3xts8r4ZyiDFFY9t2eXZy6g+NilcJyv9LeWwIILZ4Nb7GSIgmI6Y5ro++557vJx6XmXXaBsuv0kWnEnVVMip5epdRTavEfKH8=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <858DCB10922DA04E8F253FD5C25498CA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a38ca12-bc8f-4051-9d17-08d6d6c4e1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 10:30:41.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i.MX7ULP B0 chip, nic1_bus_clk's parent is changed to
from nic0_clk directly, update it accordingly.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change, just resend patch with correct encoding.
---
 drivers/clk/imx/clk-imx7ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 6668210..42e4667 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -115,7 +115,7 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
=20
 	clks[IMX7ULP_CLK_NIC0_DIV]	=3D imx_clk_hw_divider_flags("nic0_clk",		"nic=
_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 	clks[IMX7ULP_CLK_NIC1_DIV]	=3D imx_clk_hw_divider_flags("nic1_clk",		"nic=
0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	=3D imx_clk_hw_divider_flags("nic1_bus_clk=
",	"nic1_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	=3D imx_clk_hw_divider_flags("nic1_bus_clk=
",	"nic0_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
=20
 	clks[IMX7ULP_CLK_GPU_DIV]	=3D imx_clk_hw_divider("gpu_clk", "nic0_clk", b=
ase + 0x40, 20, 4);
=20
--=20
2.7.4

