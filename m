Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6536C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3620661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gsXqPR6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfCGDlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:41:14 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:61077
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfCGDlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uwsRnqlMf8nmuzoorrbGra3B960Q01D0ryX4Kx/QLw=;
 b=gsXqPR6S9/LcdRgmnM+uF0yTc8y2S3MiiXK0Z9Atu8tM/yX6v8/u8EvCUygIiTlmkPPF4xIYgNVifjNDTNs54YgftxWilPcCttGDsYiiwRp7o000Rw7tqknokcq1/ERsm0Og+90yTbzWdMesjY61uHWrFxG5jGX6M01c86l8gug=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 03:41:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 03:41:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] arm64: dts: imx8mq: add osc_hdmi_phy_27m fixed clock
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mq: add osc_hdmi_phy_27m fixed clock
Thread-Index: AQHU1Jea42bJGqNkJ0GFLGt/+lXdEg==
Date:   Thu, 7 Mar 2019 03:41:09 +0000
Message-ID: <1551929772-22633-3-git-send-email-Anson.Huang@nxp.com>
References: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0046.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d7d568c-d1e6-4ffd-6044-08d6a2aebc7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:LSvz7Tok810VVSXXPuWEaaviJhRThc+9jmpkc?=
 =?iso-8859-1?Q?xxlbTsV4U4PztR5a6oCituvzKl63IOY0GzUv8fFGcVeI93/LO1XT2rMcec?=
 =?iso-8859-1?Q?dqRF6SCKH23MbTvShhJvpTNkk271lcMob0+dWleFM032AJr/SOlEINjuAj?=
 =?iso-8859-1?Q?Az9DAiBzLVriYf/CH+x2/55mH4lheOzJME0r1Z/tFJLimHJo3/WaVWslko?=
 =?iso-8859-1?Q?QJM+pfgQk0Qy4IyCwxGP7ZnGrHDdsom28azEUTvB3CmmUvBD8Dl81KqBJs?=
 =?iso-8859-1?Q?fUycL9oE97H5jvM7BOiF/2A9VU0zeUE68862vlDExPG8q+E9yrq4XSLJX9?=
 =?iso-8859-1?Q?abGtgcFndghQo5n5lwEGIFmDWJmZwm1y+4f1SVjvEhu3BZbioZpRrbQAX0?=
 =?iso-8859-1?Q?4SfOADAyTYjudxSaOLE4CICnhbuA/dxL1UK7Q4A/6AnN3+ARAF+1vKc1CX?=
 =?iso-8859-1?Q?dlrjtS/TRJsrfosrM7oSpaoWzH46jvz+FEE4AGVfPmi+tIInCwArnNqe0j?=
 =?iso-8859-1?Q?xqADP8MMONJ1gVLN+il5bPEb82XI+71eUWL3sLNR+hv6XnWhaV5us/5nCs?=
 =?iso-8859-1?Q?fgBxKGPxKm91Cc0ioYIG8s/DBUG6LtWPsK2khXs5DbNXvwYCGlfpHJklLG?=
 =?iso-8859-1?Q?u5LJb26MZjpQ88VKLiVdJKggis1qyA79n2dgFfReKCNEsKdT5TX9clJwFb?=
 =?iso-8859-1?Q?4gz9oVUyPQomsNjxDBfsHNizr8khU81S06Mg8UqBdjd2SRkwrl/1TRV+TR?=
 =?iso-8859-1?Q?kahJlwMB/tZNIVyVzsckAUzysyC781grrMlPKI8lTbNDjEBpV89poCdhMa?=
 =?iso-8859-1?Q?fBVfWeKRrtU36h1376Lmnz8lhraHLo3QUAGQo7AA+uDIs3/N/AkE0citEq?=
 =?iso-8859-1?Q?K4RTF2Vw9lg7zSJhQErOa/yZSB5lkSnaIA1Zt/p1W3Xx+RQ17e4goSxIrm?=
 =?iso-8859-1?Q?xvW0e8mHXYQGX1MkPraTgjIHk5LX3jLeacTcfgk9omfBy0RifXs1KqQ8Z+?=
 =?iso-8859-1?Q?ScCvhULbhd/W7dvV05/Vj549A0I6/vbxk3sf/zMEIYD7GkVqKiXpEpi5bX?=
 =?iso-8859-1?Q?sirKQGhl7auZvBgI7eoLcU885zQK3cW35m+p4fkO9Ru88eVogPW7nPYIo+?=
 =?iso-8859-1?Q?1ZVqyqJNQ69gLDZuLSey+msmEO1xOPKZy5rQuVHPTiE4mOG1TcbAfhhBbq?=
 =?iso-8859-1?Q?AzO4tqgRhfK3qk5juiHsQfZnzlT7pkVYEj4KVHq9zaLYG+Ho4re/QgVV5Z?=
 =?iso-8859-1?Q?RmF7xQiARrhlHTE+1U6Xe1PRD87MBPCdXqZGFaVFhQPgcYpI9NAVe3rfhV?=
 =?iso-8859-1?Q?2fGa2THBpdOX7C4auOBEL0vOQSFw/0Vz5l1g7kRLI8Jn5Ug=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707F4C9CA396E98257D44D5F54C0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(4744005)(99286004)(6116002)(446003)(76176011)(11346002)(26005)(186003)(6506007)(386003)(102836004)(52116002)(486006)(2616005)(476003)(3846002)(97736004)(50226002)(81156014)(8936002)(2501003)(81166006)(8676002)(68736007)(7736002)(305945005)(7416002)(256004)(478600001)(110136005)(14454004)(105586002)(71200400001)(66066001)(71190400001)(316002)(106356001)(2906002)(6436002)(6486002)(5660300002)(36756003)(53936002)(6512007)(2201001)(86362001)(4326008)(25786009)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUdePhihkaMqVRhby+9nSmHWxuoOXFyqj0OfBPx6KnPtUc/fssorBW9FD81hpZv9vQ1H21f5FOVZkRPZysay1hyc7Elt8Mug4KzcJAZUaRqqpfn2OX16IN/MmgxEJ0sMpxjlFlmQLpqdRFlbh1DJ3IOsTk2eAfOvoF2+5SeKiU48EQhJwY4w66rJNcuY8CYiGlV13iBoP3NMWGIq5bgX9pfkok66l35QZqD1RcYKiyPiV02nfgxoXPzZk47t9yj+l+/1jtZ3od4KK8lOF31/4wJd15A5mieIB+YUPcz5sq9BPfM0XIE082AnZWF7iEM9qL9McEegmG4KmjxNbrvndytK3Vab+zijnNcNP5IxPT1uxLMdiazuYR5lEaROJ+oy3mWc0xApF/kMhzKICCkIDUQbAtPExx0Yel54iSrP/u0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d568c-d1e6-4ffd-6044-08d6a2aebc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 03:41:09.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new fixed clock osc_hdmi_phy_27m.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 8e9d6d5..fbcdd4d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -48,6 +48,13 @@
 		clock-output-names =3D "osc_27m";
 	};
=20
+	osc_hdmi_phy_27m: clock-osc-hdmi-phy-27m {
+		compatible =3D "fixed-clock";
+		#clock-cells =3D <0>;
+		clock-frequency =3D <27000000>;
+		clock-output-names =3D "osc_hdmi_phy_27m";
+	};
+
 	clk_ext1: clock-ext1 {
 		compatible =3D "fixed-clock";
 		#clock-cells =3D <0>;
--=20
2.7.4

