Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFC220833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 05:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r4c0clBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfEQFt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 01:49:26 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:38687
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727512AbfEQFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 01:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrCjeTDamcaoaTq2VUYAyidZ2kOWwo9zMS8K20Z+yls=;
 b=r4c0clBBvGtLwltieh9cbuIAQmywAJ4wCjWxWHQxo65o/9p/evj3WSPZV/u81SNasA+1ef2kHWJ1G+2W8Twt678xW+Oorhdhx4NI2jp2Vh/Bp1bfathQ0H5ydHyokVTlLI2hTI/UJZEhzDGLZ9xWriKYaBGzhE0uhuLr9qVYPMo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3801.eurprd04.prod.outlook.com (52.134.65.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Fri, 17 May 2019 05:49:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 05:49:21 +0000
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
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V4 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVDHRGQ1K7isZ4v0CnO8+331XKCw==
Date:   Fri, 17 May 2019 05:49:21 +0000
Message-ID: <1558071840-841-2-git-send-email-Anson.Huang@nxp.com>
References: <1558071840-841-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558071840-841-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e01e13-22d7-478c-9964-08d6da8b6874
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3801;
x-ms-traffictypediagnostic: DB3PR0402MB3801:
x-microsoft-antispam-prvs: <DB3PR0402MB3801621436923820ED85F2BFF50B0@DB3PR0402MB3801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(53936002)(7416002)(36756003)(68736007)(3846002)(6116002)(2501003)(4326008)(8936002)(71200400001)(71190400001)(256004)(7736002)(8676002)(81156014)(81166006)(316002)(66066001)(2906002)(50226002)(6512007)(305945005)(478600001)(52116002)(446003)(6436002)(6486002)(386003)(73956011)(25786009)(99286004)(66446008)(64756008)(6506007)(14454004)(66556008)(2616005)(66946007)(476003)(76176011)(66476007)(11346002)(4744005)(486006)(102836004)(86362001)(110136005)(26005)(186003)(5660300002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3801;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /SWC0G4xYl1oE3fdIsnwD1ikx3aDrID/QhY/cVJCNuDi+m2Zj7zF7mpLHrhuCgegV17qa2UgA+KPGainTjxOStlQLVJroMSpXdWrdzbb7akBP8azDgIDaD8zFd+2DdP4yuP26aUNnxPVwIJyIrPdeFvg84figNApg6gWDPPFvCGBpyHUHB5KuP46wH6PXpgqNpM2WbGy7Lo3ijoU2IynBonQ1LK3LWFM7XMMOJaIFOVhjw6MuBCRDgckp/Xj8JK02ntQeOGbK0ZwAxtxoY84mmQrtZYGImiztMqVSOpUyXVUOu5JgIB7yvmr3XTuznHmH/p6bnmOM9fjPotWKYALBjWGtH0uXYSaiAbBxaPXsFJoz41nPpcpRzWnXL3ZnQ63CDX2ct/Zyb7plwOKPhIXXBwdHsCWbRHQO/nSsdooi2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E222615DFE319946A362D5552DAAEA85@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e01e13-22d7-478c-9964-08d6da8b6874
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 05:49:21.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3801
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

