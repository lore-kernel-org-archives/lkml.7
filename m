Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF066C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7465B208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gwmg6toP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCDEZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:25:35 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:23360
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfCDEZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sGnsRBR11as5w8QjMfK7m6wH02zar6x4YDWvQV1bm8=;
 b=Gwmg6toPrmXuJvUH2/Xwha7ODaOAAe1Uj2XOpg25n6orLL3Z15d6ugCis4WBnL1ynTDzMGx7pnuz/mZ1Zw1U+Y+wclXAIeOmb+kL5aemE60i8rZ9rMgF17kel0oa9qFwngQnELWNRgh6BMOH5pFt8AZWI1SaQlLXbKMgI5T7yDg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 04:25:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 04:25:28 +0000
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
Subject: [PATCH V6 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V6 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHU0kJLnqBA5Q+pHEu2cM4q1hCKzA==
Date:   Mon, 4 Mar 2019 04:25:28 +0000
Message-ID: <1551673236-27834-2-git-send-email-Anson.Huang@nxp.com>
References: <1551673236-27834-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551673236-27834-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5df9d680-8c7e-4cfc-a055-08d6a0596e0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3852;23:bo1Cm4RUDmbZSmKl0mKmSAT37ThqRtzl19iHd?=
 =?iso-8859-1?Q?OVLsI/wLybdciW7K3wU5Z/by0XfdVjxSADInKN7bK8xby84iJNBEo1sKrA?=
 =?iso-8859-1?Q?Nr4hb/J7FVPL4f+/GcAUTiwLyamdYfp4d2G9FpewacU6msYP12P2dBH40S?=
 =?iso-8859-1?Q?Py1GVGS38OjfTFJVGh1+XyHkZ25FXDSI9mKv/GIoEpusLn/Oqm+2lfT08p?=
 =?iso-8859-1?Q?TNuEzxd3i2AiSNHNnZlHVzZXWj4iAv3YJIMIORdy5foMIESJ0g+YQpuLCU?=
 =?iso-8859-1?Q?GLCi+Xr/YMQwSpc88kbgaP/9OX5CVdV1ek0wH7QC9HuXKeqn3iWAHNnDPm?=
 =?iso-8859-1?Q?sq/ICZJTFQf5KA54MRfu3AmWrLhh2MO4VxmAFxGU2g/af7TT3jOTjMSkIn?=
 =?iso-8859-1?Q?zhOxTtNc/qrnWAq5tuiHYWsiDmdFkm7VS7DMAfAO40yHxgnc2eo4PArts6?=
 =?iso-8859-1?Q?fGQbh7bWH0dmvGSoPAcaoWOFKpoPpIu3l3d2yEUXKkkgY23ZIrCashhB6v?=
 =?iso-8859-1?Q?YCOvKZQhEuGAcmiKMesgOovw+jOVTMEy2MocaEpsCNiekTwE5h5h1199MX?=
 =?iso-8859-1?Q?8cPfSfYVVuTK/M9O9XrDhsTsqgPCdCKRaHmubUJPi5sQK8BYsaQQOJoepi?=
 =?iso-8859-1?Q?CQUS8pqMOR9rHb/KKNDPLuK1q50TLd63S43koLuiyfcwiQO12NwScsxbxV?=
 =?iso-8859-1?Q?jCgO/i9LffDec74TEn50VI8ym3GLYV8cWDjAIlhUa4SFZKOApbAtGSPcbT?=
 =?iso-8859-1?Q?DlMzk8WbAWe+WHsA7vjy3KrQ0zwIGGMrHq/WQW+mSvFJoYbWKYFTY3dHDm?=
 =?iso-8859-1?Q?iRJe2KC40eHfDDPNA80IRrjvPoDusrOLFHxeZWkT11alAfL6WAJ4sPs1pe?=
 =?iso-8859-1?Q?57cl1KdACXpaD3EgpiHw6UrHycAKaiA56L8n+5T+U3zHy1sQZQMK76lMO/?=
 =?iso-8859-1?Q?w4x8sqxbxYozT2DvIxx9+riibNzVdMW2yPD5luTQkfSH4ESq6hgqX2GgjS?=
 =?iso-8859-1?Q?sjbEtQqmpiOrBBqCStr5h3LgZpaz5A1yjT1uqyxcWWz++IA5qDwMhEn6y3?=
 =?iso-8859-1?Q?mdH/3/pH/3I+Dyx+fMsHMPooG0l8Nl9x0bcKxQYLPcHg/gDoGMDQ1j3MQK?=
 =?iso-8859-1?Q?zwsCW9dF7vSBCCnO3zLUOBdqZbS4fFdLMf8hxADFCCELtFwIa8C4rLJS/D?=
 =?iso-8859-1?Q?jS6tv8RxxId/sAF8SxWi5jdZx+MHLrb1Mnl960DTSjieiYi+1CQjrTa+ub?=
 =?iso-8859-1?Q?3ongVk2zf7v8gOA75yOT5NsnnTYgOeNDfcbuBLmOdBFaPmJL9t2C5LVgY8?=
 =?iso-8859-1?Q?tQMbyJz5cF1XUwjiAIsTNC4b1?=
x-microsoft-antispam-prvs: <DB3PR0402MB385270D2952F9883F650D886F5710@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(256004)(102836004)(6506007)(476003)(386003)(106356001)(8676002)(81156014)(4744005)(186003)(4326008)(316002)(110136005)(2501003)(25786009)(105586002)(5660300002)(446003)(7416002)(3846002)(97736004)(486006)(81166006)(86362001)(6116002)(52116002)(99286004)(2201001)(11346002)(26005)(2616005)(305945005)(76176011)(14454004)(8936002)(66066001)(6486002)(50226002)(7736002)(478600001)(6512007)(53936002)(68736007)(6436002)(36756003)(71200400001)(2906002)(71190400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+jE3cqqK6rol6odVrHRrZ+wjsOqt32lW09syA2WaEFieWrBtqBg/u5bGu6lOdB4TnESisxsxbr0WhRtv2QL9y3e449qtVmJPQtgmBS8H3t01NMb0ksF5+UYUh9BfJx3mHsXKgoVr5APPOiEKWA1Jziwka2aKZR4+/pDoLkz2bzBJo+DvaT1cN5BftBg7NvocB5fefUYJmNOmCB/LNpN5xng7Mzdib8UTMRQ9QU2F1c/2lUlmMe2zAPWS1nKyoO8u9S6saa+DQaMs6LMZFGe/7AQo5DeabZ1C5G2X++z90LKGYSnZv+eRubH2oU6naflC7zkosS2XETnnee1ARAyoJeWe9RWvYTat4YYv+qly41FzVSo5R4z4pok5x0OU1gzkDgC1IR+/Ak03wenoroqfZtpUvMPWlZnx6c5f0q6KB4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df9d680-8c7e-4cfc-a055-08d6a0596e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 04:25:28.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
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

