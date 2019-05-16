Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F766C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221292087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/xgndWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEPDZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 23:25:02 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:58852
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfEPDZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrCjeTDamcaoaTq2VUYAyidZ2kOWwo9zMS8K20Z+yls=;
 b=l/xgndWdQ6YNQ9kwdZZb0Us7gUXXthrB/d6jlDBecRb/Ng32U4LdgRRG59Gvrkdp7bwO05qKbBF+SM5BCMddZ/G8c2CQbiX4YFZz+hVIZJrFG186E9OqaEni8wiaSzIeROEjfI+qIbse6O0xlAduntJxHawb52Hknqg0IyqUhQI=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3700.eurprd04.prod.outlook.com (52.133.36.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 03:24:57 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9%5]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 03:24:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V3 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVC5bv/JLO4MlDG0ajk/kIHcdZeg==
Date:   Thu, 16 May 2019 03:24:56 +0000
Message-ID: <1557976777-8304-2-git-send-email-Anson.Huang@nxp.com>
References: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1f53f22-1fe4-4ced-8d10-08d6d9ae11b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3700;
x-ms-traffictypediagnostic: AM0PR0402MB3700:
x-microsoft-antispam-prvs: <AM0PR0402MB3700C8F7E5112397A942BFCEF50A0@AM0PR0402MB3700.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(36756003)(2201001)(8936002)(50226002)(2501003)(86362001)(81156014)(316002)(8676002)(66066001)(3846002)(81166006)(14454004)(6116002)(2906002)(478600001)(68736007)(11346002)(25786009)(446003)(305945005)(99286004)(2616005)(476003)(7736002)(4326008)(6486002)(26005)(7416002)(66556008)(256004)(102836004)(52116002)(76176011)(486006)(386003)(6506007)(186003)(6436002)(66446008)(64756008)(66946007)(73956011)(71190400001)(71200400001)(5660300002)(4744005)(110136005)(66476007)(53936002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3700;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: biH+AOzAJc9F9ofAtGS7j8SxbMIza06zBMpRB2vZzY0eZUZFMpHA5sH0tgz/0czSl2KNjFgXfO7VmTELlFhg42aE/rlRWPQJ1/F0kj9rrr527WO+YkCdUJfbvbEH68KuJHlD4/dChIFTJc+8O62+j6BIvplV7REykFr6SdAudEoryruTl1SRBJD49mm98fQRYLS2h0cWySYtQkONuP1WScsJTPA8Zv7G9tWC8ZDyzZaVcjEdrNVdcpJf2mABSDx0d5rl9uSelPw9YlD6vOx+8FZTNSDrcXkGbjE3NzOJpe1oUOV6AXu6+/VNqM3rC0QupL3aNUq5H0ufWk3kQ2xXS0qc7kqwkHKrhceh/cb2eDPrptsEJWEU3ZlZyp9L9W/rPd2/lC8L/AnaORQFS+3HyEf4MEkDY7YEZ05f4Ip6jY4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <72C07F05E1FF974E8E808A8BD23D3D49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f53f22-1fe4-4ced-8d10-08d6d9ae11b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 03:24:56.8881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects CONFIG_IMX_SCU_SOC by default to support
i.MX system controller unit SoC info driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
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

