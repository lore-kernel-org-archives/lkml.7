Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8EC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDCB21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0F8gNlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEWEx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 00:53:58 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:57216
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfEWEx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 00:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHM8JJwBphQqKuWUXxfOWmV5jdQQivpFcUOTuROYInc=;
 b=d0F8gNlq9x1/zMhv71TwwsZdKkxZy6wQSsKEoj8ai6caVDFpYWciTnvZW8rmROoZBEQJa2sGUUcJIaItumi6tOqHSlPXaxrbhaPpaA0PI36gGvPdiimYQEmVdYmhLwddplBykTss6Z/hMilzzF7HNCtpoFDLUFobzkzGxLPytY4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 23 May 2019 04:53:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 04:53:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V6 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVESOFpvI8szC/w0KZX0c9kjpgLQ==
Date:   Thu, 23 May 2019 04:53:54 +0000
Message-ID: <1558586911-29309-2-git-send-email-Anson.Huang@nxp.com>
References: <1558586911-29309-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558586911-29309-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e149115f-a471-409b-fe7e-08d6df3aa796
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3881;
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-antispam-prvs: <DB3PR0402MB3881298CC0141A986B14C285F5010@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(7736002)(66476007)(7416002)(6116002)(66556008)(64756008)(3846002)(66446008)(73956011)(66946007)(81156014)(8936002)(81166006)(50226002)(316002)(8676002)(186003)(4326008)(2906002)(26005)(476003)(2616005)(36756003)(6436002)(68736007)(99286004)(6486002)(110136005)(71200400001)(305945005)(71190400001)(14454004)(478600001)(486006)(256004)(53936002)(2201001)(6512007)(86362001)(25786009)(2501003)(76176011)(102836004)(4744005)(386003)(6506007)(66066001)(5660300002)(11346002)(52116002)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k9HTRtVwK3MD1RGnV0nQbUagSGc1utomUy3HPnadlUGjlZs4no97wPyY5Pz2C2mHfF6NQyUQBgvuQQ7xP2IpZ0KLiAc9XnH8VM1kWV+jyuOXkGpfmDfMh7/5kupG2zNYKUuslw+AxaiEnfyiKlQvnlhjyLcUuyl+V7WlGnLbe+MncUwxF6oDitReXrFMTpcY/aU4LIgWYcjWr3SAgT7qoLpjwuzvOh7HsoATTjJtPh6tLT5wVQ34qkaUT/kUpptkAvMi2GHxVSvj5pm1afX2snckZoD5shQSIAuzAKAvAbsne155kqF67EXFTJ1mBrd9Pd94oU+3oxeXqgr9y6lyAMwRtqqLqqgasetWMxOT4lY54+aMkxUm7NITStGSgBokyHJEmU35UxFQeweGTMBIHLMz62tzV4xbcy75FC6LSWE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1F2F90C8D3289847B5A7802A8D2FD698@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e149115f-a471-409b-fe7e-08d6df3aa796
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 04:53:54.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch selects CONFIG_IMX_SCU_SOC by default to support
i.MX system controller unit SoC info driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c91642d..aaca4a0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -694,6 +694,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy
 CONFIG_RPMSG_QCOM_GLINK_SMEM=3Dm
 CONFIG_RPMSG_QCOM_SMD=3Dy
 CONFIG_RASPBERRYPI_POWER=3Dy
+CONFIG_IMX_SCU_SOC=3Dy
 CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
--=20
2.7.4

