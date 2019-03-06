Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F143C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ED520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJFTOErr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfCFBGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:06:31 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:33789
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfCFBGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sGnsRBR11as5w8QjMfK7m6wH02zar6x4YDWvQV1bm8=;
 b=LJFTOErrKAEgnSwLguwOczP/Tmyb6GKOz8C3t7l334IGGGOPK0Leo5JGHvH27/XuRBefVZNJZ+Z56OmK1YEP8YU12CezGrV+hVcTU3Qvn0W08GJ+ubt9rG/ODxEngi9uNL7kLDTyH6MqLtQVwDujKJj4o8axUaa6fOYf8E1mO2Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 6 Mar 2019 01:06:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 01:06:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 2/3] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V7 2/3] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHU07jSbhu+XYDJnUSyArKzh75usA==
Date:   Wed, 6 Mar 2019 01:06:25 +0000
Message-ID: <1551834095-19950-2-git-send-email-Anson.Huang@nxp.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadbe74c-8c31-435e-4024-08d6a1cff482
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3723;23:wVnqixZbKFxcsGcn7vOGWwPGi1MCi5XfHLcOC?=
 =?iso-8859-1?Q?/j86xV2nBo3tbl0hbCM81BkFBlovNiwdxeIxxafrXngFuZHf6Lyv75ZwDw?=
 =?iso-8859-1?Q?gxmhpBAhR1ysWquBq0WPsnVK6QKPmipVESx15o/nQWjvPhWn93ndm5h3Sf?=
 =?iso-8859-1?Q?h0ewmqoNlHQTMiPt73v+rraD4qpZaT+gZAR1SC9ep3wn2AneemRuU8Cfks?=
 =?iso-8859-1?Q?VuqIc0xMXRGGRGRsn8J2eNm6mXt1amcYPYR58HseR2J8mXmoH0u7Okspe3?=
 =?iso-8859-1?Q?oKgS7ghkYfxLeIKYbGLR2ETspxes9Imsa8pY1Akz61ssmItKohjQGu0sD6?=
 =?iso-8859-1?Q?u96GEsUt/cycH8Bgr9Y88cU+psgQxdd8con/pyRAgwb0AtKCOlC9L/JYh2?=
 =?iso-8859-1?Q?ClHGEPbgU5lpr4jgaWCTAMIu6YvJeGgT4uxeE38yfFGuuwprFwyjM4np29?=
 =?iso-8859-1?Q?G0yN/MN87zLH1CP1txHcxrxVkC+pzqaHuxZ2GUuzoqhFvvwKONJanORva5?=
 =?iso-8859-1?Q?V6lukFY4+PwHIMhtKjzYwckaNwXoBthklfvR7b7SNmwIRoCX714aWHVntR?=
 =?iso-8859-1?Q?DBaGnMrdT05oqkhkSaJ9oj4f6qr3CGaQppmeuMAm75tY6aEkVtKU+1bcyW?=
 =?iso-8859-1?Q?QsCW368pNdQIm8lAsu2nxIn88Wr+KI2Z7ER4thkIDN4jONoJr2ZWfMqRCK?=
 =?iso-8859-1?Q?dRsr/SCpi37RhVgYAmH8fESUH4r3GmyY79kexJ5MRf0mFh5VObKYc9daLB?=
 =?iso-8859-1?Q?s6f+G2J3wfyUgM2TkkbHw9eWnVGYF7gsesNryi7zVPo2sPMnjwH2WCtewY?=
 =?iso-8859-1?Q?8B/Tw170yqbVOE785U1PzGVKpYMo7gxtwo8Y1ovQBurpmsbETCuuQqVS8Z?=
 =?iso-8859-1?Q?eb2TSwAcOXop/4UGL99LBftibmMtlSQofZInLcIWB51BjfEswH783goAKu?=
 =?iso-8859-1?Q?R+eZvE4IYTpetZvIvn3WV/yQyv/VSmqsY5biiknnOKPptvK0HrXMvIZdOw?=
 =?iso-8859-1?Q?7wwaY7pxGlJnMyWgGMHhrgoq2KNOf0cMuN0uqTMZ7dQJ+0dC3dTBrsIRHf?=
 =?iso-8859-1?Q?UsL1J5zzP0pUaEP43HpielkVGcQlGMPxgwAPktEctchq38HRSJl/Mjq5bf?=
 =?iso-8859-1?Q?0hJeS5hSem7ltFeSWnM5YD1OOs/TymeCEY7IoDbV7LJlUD1jWIXeJxidbo?=
 =?iso-8859-1?Q?VOTT/AdyBd+Q9ixLvWXZHj9YN+D0/MN53h6lXyzPBLBExEwfOfp1zrdg+F?=
 =?iso-8859-1?Q?dxbF2lVdiA02+e5VV59StOMKh/Am54tWrB/V/lJTsV+BeSDVzRLSc+5V2J?=
 =?iso-8859-1?Q?WWuZmFQ9gtbLFBH669sfQObA7?=
x-microsoft-antispam-prvs: <DB3PR0402MB3723EF18A1EDC914A1577748F5730@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(36756003)(68736007)(71190400001)(71200400001)(86362001)(256004)(2906002)(110136005)(316002)(105586002)(106356001)(6436002)(2501003)(6512007)(7736002)(305945005)(2201001)(6486002)(53936002)(478600001)(8936002)(7416002)(476003)(2616005)(486006)(11346002)(4326008)(14454004)(81156014)(5660300002)(3846002)(6116002)(25786009)(81166006)(8676002)(4744005)(50226002)(52116002)(6506007)(99286004)(386003)(26005)(66066001)(76176011)(446003)(102836004)(97736004)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwwEb9IrQPRqqlzJrBX7oPWO/TZCQgB9H3iuOlTY5j2303KdnIIhicff0OlTwsXfHGclpNrPzAgiIB0EEaKi0YgyLmAnuO0eZfNAN6X60EnaXyGbSe/TRzjwszc5/4Uq4DA0Y9tECiuSxHGvNtA2lNr8MQHG3kM5aFk4IYOV+bNkrWDg/5o2SBr4z06mRGkfnsWboPUVq0YvYEjH+mcQLiy14ps/9tWRJQ+J+sn2vwrYFI3nA+exdmyiSdnOwVxhJdVL/7exFKAO9zAaf8KPDiBKnCswM/RAGe2bzz5gVkYrUaXgByrrrgRD9cRtE3ewFcNcXYS440uSqaKXdQ2F8PNyzWTHwDoPAPhEcch/PhaS3StE+eo/9ySG/pEv/J94esL/JX/HbZ+4XP1al8AgXtxeoZhmIf73DxB+2F418/A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadbe74c-8c31-435e-4024-08d6a1cff482
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 01:06:25.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
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

