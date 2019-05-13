Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89FC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0463208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mfl/i2am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfEMC71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:59:27 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:62016
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbfEMC70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+/U/winN9JisG14JsPFeu6qQmm8k31yyIeHEC21FSI=;
 b=Mfl/i2amrMatvLOZaziovT4qibib+pr0Lmc/R5rBlwsdtyJqtVZJ5NYG6dWUdJgrzignK1WPKBts1yyej0gJjkbSWacl4BeD1rk98PYV2QJwUFpZzR5cH/rMdhwbltWecLx2BSZxf9/5s9K7pWADVtz2rPKoHR4Oql5D3UfpNRg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 02:59:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 02:59:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH RESEND 2/2] arm64: defconfig: Add i.MX SCU SoC info
 driver
Thread-Index: AQHVCTfexFd3LXRdNECCTfbHSWwarw==
Date:   Mon, 13 May 2019 02:59:24 +0000
Message-ID: <1557716049-22744-2-git-send-email-Anson.Huang@nxp.com>
References: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557716049-22744-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fceac7ee-5f98-4c01-62a9-08d6d74f00dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB370781BFF0BF0DB109A1559EF50F0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(26005)(66066001)(6512007)(6306002)(71200400001)(71190400001)(966005)(386003)(6506007)(316002)(305945005)(110136005)(76176011)(68736007)(478600001)(52116002)(2501003)(7736002)(99286004)(14454004)(102836004)(81156014)(6436002)(81166006)(73956011)(446003)(6486002)(8676002)(4326008)(8936002)(486006)(25786009)(6116002)(4744005)(3846002)(50226002)(5660300002)(256004)(36756003)(186003)(11346002)(86362001)(2616005)(2906002)(53936002)(66446008)(64756008)(66946007)(7416002)(2201001)(66556008)(66476007)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I56DUo096jAgBJ5DhpGG3grJeJVlGuoyhQIrcI9paCcUq08hzmZrqtT34Ren/0Kv+gwl/txU1Vly64s+arBu+DO8RaFmNX73q55Oyn+kw/Bk1MQijnGvT0FQIxw+mwaf5gSF1rA4y/WMm5CdPknHpFBydcHcVxeXrXNo4tOTXpsOsyitCxjuooF6YY1+zzKb2tBKnldeMK/SQfMtVrP7DyOgQhm/yNJ73wKSylK4wR3rRo+WaKUFWQmF0iLD8N0JGIR6BF6X97fUYFy6jzqvM5X/IibHi8maWkoDbCs4o/ikh43eJMFqfs8dKzgKQmA9c7j907Sgk1nd6dgaGUyDf/mpEfF0Asqs3OOCfW/a/wBYO5SWOkXKDDUG1L6cq5hbSa3QTmpNQpzjkeXHp3JUTcDrW5vS4gVH/fo8xJY0GtE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B5957F9073035C4C8671DA70A506CF76@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fceac7ee-5f98-4c01-62a9-08d6d74f00dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 02:59:24.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects CONFIG_IMX_SCU_SOC by default to support
i.MX system controller unit SoC info driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
This patch is a resend version of patch https://patchwork.kernel.org/patch/=
10895149/, the change is
just using correct encoding.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8871cf7..d3a4508 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -691,6 +691,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy
 CONFIG_RPMSG_QCOM_GLINK_SMEM=3Dm
 CONFIG_RPMSG_QCOM_SMD=3Dy
 CONFIG_RASPBERRYPI_POWER=3Dy
+CONFIG_IMX_SCU_SOC=3Dy
 CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
--=20
2.7.4

