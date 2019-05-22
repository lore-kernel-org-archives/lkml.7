Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A077C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1320720851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQeuDNCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfEVGXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:23:43 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:18353
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbfEVGXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbqUzZVRwWZ4tYX4g9D6c7uI4m+J94IpDcvef/Blu5s=;
 b=eQeuDNCCH5G4d30d/2WweT02JHopYfmoiN65TAx5WJWvqiED3t6abugJKj74uVF0y/n3v2PIxz55z1cJ/+gvcZfaeP8DjVOJta0UqoHOGXEWDkin3ElWfrLsPcDI+LNPocspGjpSAqavFuqUa96+OePOS1vP7Hy8OGNUMeqTtkU=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3330.eurprd04.prod.outlook.com (52.133.47.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.20; Wed, 22 May 2019 06:23:38 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::b99f:920e:7f36:7af9%5]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 06:23:38 +0000
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
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Topic: [PATCH V5 2/2] arm64: defconfig: Add i.MX SCU SoC info driver
Thread-Index: AQHVEGbkhTj7BvBC3ECpXolLGsMP5A==
Date:   Wed, 22 May 2019 06:23:38 +0000
Message-ID: <1558505898-722-2-git-send-email-Anson.Huang@nxp.com>
References: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffb97f38-4c73-4980-1204-08d6de7e06c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR0402MB3330;
x-ms-traffictypediagnostic: AM0PR0402MB3330:
x-microsoft-antispam-prvs: <AM0PR0402MB3330AB388531DE95C534515FF5000@AM0PR0402MB3330.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(498600001)(3846002)(2906002)(53936002)(6116002)(7416002)(66066001)(5660300002)(14454004)(446003)(476003)(2616005)(6486002)(11346002)(6436002)(486006)(99286004)(36756003)(305945005)(66946007)(73956011)(26005)(6512007)(8676002)(7736002)(66556008)(4744005)(110136005)(71200400001)(2501003)(81166006)(64756008)(66446008)(386003)(71190400001)(6506007)(81156014)(25786009)(66476007)(52116002)(186003)(4326008)(76176011)(68736007)(50226002)(8936002)(256004)(102836004)(2201001)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3330;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OvTAt7KoI9oneA65TxmX6ACcPnXPZtAaIrI/imS6afnm5ZfhZN/rh9Oy+OeRg1xhBPggzMRkT3oFlss7X9+kghcDKZtPyHUtuwkNW+eYplov2X+pge7IpRdUrzGsXPBfCsECjEItNx7fOjuQDBG8Mp3ubdcXOn3S4ZWmxmUJnpQWmySPXCmZZDfrXuADL1ScY58B/y/wkYABdUQpKbHx5lcTjT+EE2YEwO5XoVCMoWzdVA5S/BLkWbvpeRPoWnfQFr3nDJZY/MA4JAj5WQQmS3afvWefXLW6ztbyY0Dh5wz2KFYMNVUW5hnpih4UkbvVkFwSKw+GqjBv2H2XkoD7bHO5YRrY/gxSIOPjl5slOLfuNfciDnyMwda4EYF39OdguJ4M0ILy2rEUIMnJyH6o0CwtRZXK7AcfgTgPI2QY5YA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C6158A717CE9534A8C5737B598AFFEC9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb97f38-4c73-4980-1204-08d6de7e06c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 06:23:38.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3330
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
index 3a1b846..61be39b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -693,6 +693,7 @@ CONFIG_RPMSG_QCOM_GLINK_RPM=3Dy
 CONFIG_RPMSG_QCOM_GLINK_SMEM=3Dm
 CONFIG_RPMSG_QCOM_SMD=3Dy
 CONFIG_RASPBERRYPI_POWER=3Dy
+CONFIG_IMX_SCU_SOC=3Dy
 CONFIG_QCOM_COMMAND_DB=3Dy
 CONFIG_QCOM_GENI_SE=3Dy
 CONFIG_QCOM_GLINK_SSR=3Dm
--=20
2.7.4

