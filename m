Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD412184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HggpNiw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfB1IAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:00:01 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:26017
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730399AbfB1H75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGZPmiwr002s45d4dqREbhsRs9DYJ2iiYOSnRa6BeIU=;
 b=HggpNiw9GDHHZH54NmRni4fRgpbBdK2ZCzv+PHcyG7IHyNa0U6Fbhdj04pCA/+9kHMu8tLeqVeR2SR6cXEl6xC5sXmX6Bs66454vA+Xc+7G6Ljr7xsQcfY66GNb1+TdO6SuQfdBH1aURivEqUVL3D92QUeVgOCqxqf24en1c62g=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3604.eurprd04.prod.outlook.com (52.133.46.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 07:59:51 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec%7]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 07:59:51 +0000
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
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH V4 2/2] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHUzzuVlP864ymFpEC6qa28bjyoYA==
Date:   Thu, 28 Feb 2019 07:59:51 +0000
Message-ID: <1551340510-2324-2-git-send-email-Anson.Huang@nxp.com>
References: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 125f2258-b602-4ed9-eb27-08d69d52b76a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3604;
x-ms-traffictypediagnostic: AM0PR0402MB3604:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3604;23:i3Ikm/Ce4+AVhH5mGKrWdTvWa0aTXkpYDHQkq?=
 =?iso-8859-1?Q?HVjRhBsBD8VsKniRfHD2adxSG5I7nqkVk2hxgLf7tiPGqs4HQ4k8icGJq9?=
 =?iso-8859-1?Q?pPEBPC1goUubg2Au/a1Sxz1LHG05vd8DoRz8o5OZwhp95vY+PVYCTSfDml?=
 =?iso-8859-1?Q?ocRGx63iRLP7ZYEwCBnCzCTuSCl1IBcpW/X6BCXhpMT7H/edJAYKmE6PFB?=
 =?iso-8859-1?Q?jp4qjMTZJ1UTqANYTA/Y743BcEuwSOHebtDZjVXV9Rq+6FJKMxTxI+0u4G?=
 =?iso-8859-1?Q?xDklt+OoI1GeyMVvaagGovy3S8hCkMjluvcmi7MiQMUDncZn1PanSxZNbg?=
 =?iso-8859-1?Q?dnH8WFHX5szdJLMdsOtyg5fQXtvCZ/frdJEUNLUmf+qS+owS3HGPT1J6e4?=
 =?iso-8859-1?Q?P8+JIiORp41z3lxUOxlwB8ZX0D/dGinPzM7wpiDHzBZdO+qna1KuCkj6Fi?=
 =?iso-8859-1?Q?irKXUXcJ4eu3peBJwz50juhTylItSrIiIv+DOtcx16PSpAhIy8Pg4pecNM?=
 =?iso-8859-1?Q?ZV265os2tT3/XcSyxt1vbTBnGOzyX6aSj4SURUCfFuUM3KtxhJY3NawgyC?=
 =?iso-8859-1?Q?Uo0OCOlDSBmHoiqf/mvXBBi07k3U5YPl3s8KTsDAhuLYNURLuAtSXLUICK?=
 =?iso-8859-1?Q?MMwClYzrwGDvTGD6DjieH18ZUxo6/Y0heOR4KnvYgCEMueidlvc78JtiVd?=
 =?iso-8859-1?Q?kosgg5+hHIsDqNqwbXkY2h8OGJYZwPRxUuoY2whnXV48XPhPEsBnHmRY3W?=
 =?iso-8859-1?Q?yd3FW0BtTe2gl3xCY2wd03IG+kAhwlhTOHwYLXgGCFgS0lD86c/x/1xWdE?=
 =?iso-8859-1?Q?3i4qsWf7ylc4sxRAE5WHqFqbFNbyd+tftwcx8DtF46rEcDD/tKqIYviuAj?=
 =?iso-8859-1?Q?W0qjc86R3eVSktLHicnvRTJro7oYYUVweMQf/Wu0z3qs/vKV6Cm8AY1oH7?=
 =?iso-8859-1?Q?mq6jn/gNSYHhb8Pm2CwBBPV43+r0xf3Qpg9dWImUVlIF0ePo12A3u7MqiS?=
 =?iso-8859-1?Q?2WXDITHimK8UdK4/xCHcgOkQ/l2/Vzjz1vxPpRa2wcLSCreb2Y7aYM4UD7?=
 =?iso-8859-1?Q?JHc8QYYRZ7qSAJjSri+S01NB5tsmZRn8PaB+DKx0moQ9pNSDtgAMlRdbjb?=
 =?iso-8859-1?Q?Y+eUNuOFSmzoyPqz4hvWqKedsck0YbvgSw8xt8Wuw5YyZmGY92ebdbyTt9?=
 =?iso-8859-1?Q?93TWcDt22NQccnl/hvJERrZ87bd8qnGXsyiKtSuEqVyyKlw8sN2WKLnd48?=
 =?iso-8859-1?Q?VYhpMnxjrLzKrAfAc53hpqLGNQyqzNEN5oxlhnkNr2rCmf5Mu/Ju4p/J5Q?=
 =?iso-8859-1?Q?dMxIpV269tt3eAvPgSYj2yqO7?=
x-microsoft-antispam-prvs: <AM0PR0402MB36045E6090A454F252C924E3F5750@AM0PR0402MB3604.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(68736007)(36756003)(50226002)(2501003)(7416002)(478600001)(71200400001)(71190400001)(305945005)(7736002)(4744005)(97736004)(66066001)(14454004)(81166006)(8936002)(8676002)(2906002)(81156014)(52116002)(316002)(386003)(6506007)(76176011)(6512007)(110136005)(6436002)(99286004)(53936002)(3846002)(6116002)(5660300002)(4326008)(486006)(446003)(11346002)(256004)(2616005)(476003)(106356001)(105586002)(86362001)(25786009)(2201001)(186003)(102836004)(6486002)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3604;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K7lIVrTPzCiAuBwT2qlFYaOM+WSBgrLptt9WPKNKeXYk+wKiT9GCjQ/KDEfDTqKg+Dq+7KEUo6uhI6mR4T1WQEofoaLnpgpuTGPGb7TKgEBuTdPLCedThPT/y+l47CucMPUut4tYUlpIlZ1RsQ+nK7JgP4VHDQ4FUnUpFfkIH0UHIkVxMkMx+QLI/fYbVr5L8c2nhKFxvQGjW+HO+OrA/9Z00YTPQRL+KzgP+ZeuKs4K8mLnrEIdm73rEVbNFjaL14uQRHX4XYC4T8vzdr0A9iEBqdgrI6wiHF5Tze+DZkC5JLfrkgpWOAo6VV8SM1yhmzjOxgnD8Py7UPqr2J7ENS6oCB/NFVmCOvP8ao1ZGP91GJnjWCta9wZZ20wfjqz13MEdybruuZKTkK5pSwQYckpTU9ZFKaxUUMOejhubFOc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125f2258-b602-4ed9-eb27-08d69d52b76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 07:59:44.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
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

