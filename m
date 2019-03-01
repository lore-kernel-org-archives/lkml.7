Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24535C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD911218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FF1ImsAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfCAGfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:35:44 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:26558
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727545AbfCAGfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sGnsRBR11as5w8QjMfK7m6wH02zar6x4YDWvQV1bm8=;
 b=FF1ImsAJX/uFnHlL0FqVhZqf0JLuTtpAuXBN/b1g66H0tnYhE5Sf9A3QGsDucvohIFZ8BlCa2/cI+AHl6UVEzpX1FfiS1joCHEq82/DK1TwZZ6G60qoL9l7qDFP/ROG39dmzB66oHJeQogbs0XrCqX43mHJWu3Fn5OLKrphxDhs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 06:35:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 06:35:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V5 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHUz/j7YGXfslNzkEScTcLNHLcmmg==
Date:   Fri, 1 Mar 2019 06:35:38 +0000
Message-ID: <1551421837-21230-2-git-send-email-Anson.Huang@nxp.com>
References: <1551421837-21230-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551421837-21230-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19600d5-8657-4d13-48c9-08d69e101e10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3899;23:odkrCuSPd2iadBc51CNKYNvtrIDVbjAZvZt6I?=
 =?iso-8859-1?Q?kr2mKam810wKwpUW0uAhZiVAQ2Pa8wgZlZmbK6FaFQkoe1eHds9jkDLISB?=
 =?iso-8859-1?Q?xTt6YFK27R9OuUew6MTShVO2NUgtixj2nnHwvKiL5sShzYLzvv0phPR7lJ?=
 =?iso-8859-1?Q?vC/PSaixoVkz09pwOCw+lxoMnzg2DQxKNXm6hClsZYgk2Hpffb4IdAUzNO?=
 =?iso-8859-1?Q?fqjI1nVDGXqu4F+J8cdG2A7ClcB8d6rLWvcA7S1WKBjeVkK8RKPMsFrClF?=
 =?iso-8859-1?Q?XItHroX+gRMKjoXpd7AH9JwFBT3c6FDiZDJts/fdcZn0HAQq4XmYiejM0k?=
 =?iso-8859-1?Q?hMu4AWSgCLucwX/pk28RWt2bPcu37p2FfY1L9iYcW8dX7MLRolahprqlLZ?=
 =?iso-8859-1?Q?NKVOYy96rruZggDWuI8CIpizpGsVnLBh9vXmIpXpYTfJBhqGE+BZrv2svi?=
 =?iso-8859-1?Q?v5/2LQMxyaOrolvzZXNAuCYnuPBtIUIhhF9sYRzQIDSTFHaGkihr0719Kl?=
 =?iso-8859-1?Q?IL9uPBzswrW00ezVMV9DkMOF9U8eAyld3ew5Ejqo2vlI0zAisj53ckttKA?=
 =?iso-8859-1?Q?JYO+KxyuabBSSzNhZC7+65rj3KRe8YJNp5i5Ra416vKv836wrFrr/Ins9u?=
 =?iso-8859-1?Q?QtKv1PefzhRG0u76EYXA6nPw37y8PF8S/20ZXyP72sWh4jlGA6zWZveR+s?=
 =?iso-8859-1?Q?NIGcP/LmSm9xd8HDIeeaJMJDmB+KsXMPySVo9pSO+T36uWz4GUAvspmXvf?=
 =?iso-8859-1?Q?3SMckzlpgXjsCUVvj+4aCER/tqIEGFYoG3Aw1Rv4O6mXlMWkMc7YDGo9k/?=
 =?iso-8859-1?Q?MnBvI04oehGbGH3RBMdr5TNZjHS7F30JGHNKgOT0D1ixxMBSqcH+Bn7KZl?=
 =?iso-8859-1?Q?RkW4r6a3Rj7Z9vDnaFgkcqy7+IhgrBNbDNvYJ6Wqv7qGW+FVbPcs2K7jxZ?=
 =?iso-8859-1?Q?KPZSv46nOTCmfpJRf2/u4edXnA1zSizrqWgtBMhzH2+BTtqdc4U+TVbc4H?=
 =?iso-8859-1?Q?hj0nKnwFkoE5kTAc5b6jf1GRFh7GYuIC9XVhJFR04ZcFLMCglRooH2/3GV?=
 =?iso-8859-1?Q?xXvAXe27v+t3uC9s4nCV5nDHb4qodQhFCNNdGkMRwN95eYNS54ePtGYwJ0?=
 =?iso-8859-1?Q?f/9KG9zyk5yUC+jEtSE/Ysb9YJ5ZvPZO18PyXSlJmPAcWsT8qMzRv8qnuG?=
 =?iso-8859-1?Q?0ixDXsqkwRmBX57dx903kqpRX3RPWM7elajLOvQzdU5kJCuvEtx8cORPsW?=
 =?iso-8859-1?Q?AHRLxw+zBTmKnvwCadNr2d702HAYxleCJqdSuNAmwdCADYIyDoVyq8rZH8?=
 =?iso-8859-1?Q?fpMjRj3XPjxgRK8BVXqEHRdCK?=
x-microsoft-antispam-prvs: <DB3PR0402MB38996B358B23C599CAD0EB07F5760@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(11346002)(26005)(476003)(2616005)(316002)(99286004)(36756003)(386003)(6506007)(68736007)(50226002)(52116002)(305945005)(7736002)(102836004)(4744005)(76176011)(5660300002)(8676002)(486006)(106356001)(81166006)(7416002)(105586002)(81156014)(446003)(53936002)(2501003)(256004)(6486002)(25786009)(4326008)(478600001)(71190400001)(186003)(110136005)(6512007)(97736004)(86362001)(66066001)(2201001)(6116002)(8936002)(2906002)(3846002)(71200400001)(14454004)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OEaI4CooEIsxJ5cFLBJxk8jL2TCqw0yS1/WSsCLw42ugpWsI6bwDjylG7PvbVesTXVTONrgtaR6+Z1s6Q7tGuKZFDRmKsKJCXxM3jfy8//icUdwfmf4XzIWARavaFzbp7pD6Q/cKeNgKYlj8BD3p0bhd8bWXPUapSqSaMFdLdTHaPur4SixgD7W8/KkE4M4ul1fn2h8D0JxqTc7KkT8BdeSoUT8dk+3+/n0UZKhx3eNNkXcMk3dSdvsGg8sSIkrP5wy1m9e4+cigX6eymd+Y27aABl4V1oMb86JaaRhkWH86Kgc6J7GldOHrbTn5Sc26JStewPjaxC8D1QNR6KthHAldblFEBqP3/jO3bvTJgnixdd3itVcgGme+jH9ktlOKEYUytdPLBICQbQFbsUVJj3tVKUNfZOPChnFYtqr/Krs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19600d5-8657-4d13-48c9-08d69e101e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 06:35:38.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=3Dy
 CONFIG_ARM_SP805_WATCHDOG=3Dy
 CONFIG_S3C2410_WATCHDOG=3Dy
 CONFIG_IMX2_WDT=3Dy
+CONFIG_IMX_SC_WDT=3Dm
 CONFIG_MESON_GXBB_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_RENESAS_WDT=3Dy
--=20
2.7.4

