Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2205C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD192173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FlmlGncg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfEJMXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:23:49 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:57678
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJMXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47VyM5IIrni7gGQiqmFicQJhymnzHX6UsANSagCiw8I=;
 b=FlmlGncgysB636DPY3KuGJ181FGRwPb286kyDYNb8fKVomqecO6KXO/TP1XNGGivSs5k2Dn13UhLtuZoEwL2QXx3cXwojcf6vPLfqC1JEHobskVLd7t8t+cPNZ9NQj3RYpGzC4YOdLtCe2nfI+P0GwEMy/9/QpnjKH2pq1HmvNY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 12:23:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 12:23:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Topic: [PATCH RESEND] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Thread-Index: AQHVBys0pgK+lXcoZEiiNPClktUsIw==
Date:   Fri, 10 May 2019 12:23:42 +0000
Message-ID: <1557490722-21657-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0041.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31c58436-945e-44dd-1554-08d6d54256f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-microsoft-antispam-prvs: <DB3PR0402MB367666D21B105115E2E74F3BF50C0@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(7416002)(53936002)(4744005)(81156014)(36756003)(6512007)(186003)(2906002)(6116002)(14454004)(3846002)(6506007)(386003)(256004)(486006)(5660300002)(2501003)(2616005)(476003)(102836004)(26005)(66066001)(99286004)(8936002)(110136005)(50226002)(68736007)(478600001)(52116002)(2201001)(81166006)(8676002)(25786009)(6486002)(6436002)(305945005)(4326008)(7736002)(73956011)(316002)(71190400001)(71200400001)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wT2IXin/uio7WxC3PLP0a/XEPawSTJ9v0ohdbJ5lPc7bfw7CsJtqHtVR8LzcdWndpJBLLoI+hKUvhWWNh4L7FuvsGtANGaj7uK6350B/70oFOmhfqDkKnCDVb2Ltg30ogiNmZ9tNyL718uBubq4JmxkV7rGu4+QjRhZLIIoM9oRRiKUmr3LICeuBsSXpcutNr5JpcUgg8EWtbxtT/ys31dDd368YEuPDiZqp8gvT40/R+6y4zwu/3PRn+n8hmEVTd+YKSV+/r6yLgG2ed2TFxvGYIMbY0fuKn+qL5l4tikkHFkQDs/4TqrCCygAhY19O8iTAd7or5EhXbzu8QaUM1yw3GhqiJMuuuQq9399PJYjPSphl+7i8Gfa5/e+KnRlf5KaHSBURwRTVOADU2n6DhmbnTc2UsvEsdL25JH5p5BM=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7C0940655F6B3F449B316FA894F688D8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c58436-945e-44dd-1554-08d6d54256f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 12:23:42.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_THERMAL_STATISTICS to extend the sysfs interface
for thermal cooling devices and expose some useful statistics.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change, just fix the base64 encoding issue.
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index 765003a..ea387cb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -225,6 +225,7 @@ CONFIG_POWER_SUPPLY=3Dy
 CONFIG_SENSORS_MC13783_ADC=3Dy
 CONFIG_SENSORS_GPIO_FAN=3Dy
 CONFIG_SENSORS_IIO_HWMON=3Dy
+CONFIG_THERMAL_STATISTICS=3Dy
 CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
 CONFIG_CPU_THERMAL=3Dy
 CONFIG_IMX_THERMAL=3Dy
--=20
2.7.4

