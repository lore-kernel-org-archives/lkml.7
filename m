Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B8FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A9218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rUWRSx69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfCUP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:26:00 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:14051
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfCUPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc5p1vsUqTu5JIvBxPRroE8mMezxfCahpebxF/O5Spw=;
 b=rUWRSx692a+6qkxcTIKXDcGZ9BbxWT4LxDlIdsXWbW4JboOAZMZy3pEbsCZaECfpn9Wiy7yqq4EkHy2rwcNcT/KfOxITIHp1hKEj5tCQuC4MUNEQwEG8PEnmPajIRVjv1X8gOSGKkVC2yde129tFxAd6oj73si6Y4NFTpHdBazY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4388.eurprd04.prod.outlook.com (52.135.148.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 15:25:54 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Thu, 21 Mar 2019
 15:25:54 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Remove unused imx_get_clk_hw_fixed
Thread-Topic: [PATCH] clk: imx: Remove unused imx_get_clk_hw_fixed
Thread-Index: AQHU3/pgiSlUmcBDSUm5+clCoj/uvQ==
Date:   Thu, 21 Mar 2019 15:25:54 +0000
Message-ID: <1553181943-24123-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::47) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 722ed74a-4452-4636-0b98-08d6ae11826f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4388;
x-ms-traffictypediagnostic: AM0PR04MB4388:
x-microsoft-antispam-prvs: <AM0PR04MB43885B477D34CE43670415F7F6420@AM0PR04MB4388.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(6486002)(2906002)(4744005)(486006)(5660300002)(71200400001)(36756003)(8936002)(99286004)(44832011)(66066001)(476003)(86362001)(71190400001)(256004)(316002)(54906003)(110136005)(4326008)(6636002)(2616005)(68736007)(50226002)(6116002)(3846002)(105586002)(6436002)(26005)(478600001)(14454004)(97736004)(186003)(52116002)(386003)(6506007)(102836004)(81166006)(81156014)(8676002)(6512007)(53936002)(106356001)(305945005)(7736002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4388;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uoqftTFBFOhQPAecXJ7U+SDv9DmnVdMydE8ABJ02nL54wK30+wqP2ww/eDplUVCRylZKj6TT5r+v8GoxLHtpeqDUHA5NOBOHi1cRBMGqJDhSQPqHoeB+qitJnbE8uN6nXzS24dF5W3uBRS8PiWgTVIqaUmayWpLkExsCjmyUpdwZPPOy8aKJ/LqUQvkr3k+xYw+pw+m3Y3bosukp3W//TaaNm6dMvtkJTs9EwrKxL2U3H9ANFv6p/vkktgGAF1ha8YDGdBxUm8PSea92qJLJRbOzVa46N8FSZonrNkG1ogm37i5AFO5Gu4DCsQ99TM7adXfTC87pME2SLqWXiLryQAsuI5xymeSPK08VbRqATH5piMSGheUZZg2xXw383JIeHw0E6Mx7Z1/agwrWzrhP63DeplHfiE9yflGo/xzF9Cg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722ed74a-4452-4636-0b98-08d6ae11826f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 15:25:54.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4388
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is never used and the imx_clk_hw_fixed does the same thing.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5748ec8..edc12d6 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -138,11 +138,6 @@ static inline struct clk_hw *imx_clk_hw_fixed(const ch=
ar *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
=20
-static inline struct clk_hw *imx_get_clk_hw_fixed(const char *name, int ra=
te)
-{
-	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
-}
-
 static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *=
reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
--=20
2.7.4

