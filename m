Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C72C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14599218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMSt53ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfB1Vmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:42:53 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:35150
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731838AbfB1Vmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w189ljzm0VaqugtVo9tpZPHp05AlfHj0Dcxzoa0eJr0=;
 b=YMSt53ZV6W1NEbQOcDOhgD2YWdI5nCNlRiVjPII5PDui3VQA8RK9P31Sdxw87Fm1Z4FqNV8YQ6X23drWDpkqujWuZk7ZSj9IrmGgLm4kiuihEgZm5QahG5w1H3M13fP2EP438pkzWu0Ir/7bA9Sngbsn0dcemEGlCswMZ1drfx0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 21:42:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 21:42:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 1/3] arm64: dts: imx8mq: Add the clocks and the latencies
 for the A53 cores
Thread-Topic: [PATCH v3 1/3] arm64: dts: imx8mq: Add the clocks and the
 latencies for the A53 cores
Thread-Index: AQHUz66JmKu8KzqrIkCJGjmUaRcs3Q==
Date:   Thu, 28 Feb 2019 21:42:44 +0000
Message-ID: <1551390149-15443-2-git-send-email-abel.vesa@nxp.com>
References: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff95427c-9cd3-4122-d15a-08d69dc5ac32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5795;
x-ms-traffictypediagnostic: AM0PR04MB5795:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5795;23:lclh8jiqt9PVMZ5ll6ymAR4t5V8e90F0RaXPIrV?=
 =?iso-8859-1?Q?a4+Lx5CnbhwiamanCOkFhL8Fi+UFUYOflJmFKSV9hio5bJpyZWgG+KvL+h?=
 =?iso-8859-1?Q?R2kFJLZS8qsV/PH0OTVtzla7mBX9KnzQD5TgOqN/Z7y2MYayxn4kxCTdQT?=
 =?iso-8859-1?Q?+adijCWBymSa27pNGb/Q/zhc820tK/khVg1Srms9ycHvkdBRsOFY/UuMt2?=
 =?iso-8859-1?Q?ywGSLIATa8GpS1cvwZ7ykbOY2hSOoyX2mp5MpkoRO/5P+YwWqNkj2dvTC3?=
 =?iso-8859-1?Q?jYfyOlbQKZuKA+NVROO9UBZOzQY2k5Mb/0uTZ/kTLAjBjvPG1E2g9GNgaM?=
 =?iso-8859-1?Q?eBZi9BTXG8GdO4+SKHR5H/pGQ9PmYQDJi1H0KEbtZfEaNIgJzlSlse0KV8?=
 =?iso-8859-1?Q?xitrrNmVWouQcA1gspCAoqed1FbDhF6awvF7Y7gnXFfeNCObe+XvQPqGud?=
 =?iso-8859-1?Q?mL9Q0/jiQCEyyKt93osAbwuQTYSpcYbi5/6VuQys//RYtRJ7gWEBAMfKVY?=
 =?iso-8859-1?Q?Wj2XtVg/PF1g2T7fTsI/EXpfMofQP+0hhbaBRYepVNvrCsMcZiR75dMzI2?=
 =?iso-8859-1?Q?dPYcuqJpP9dmr0QAR2rJnDpVk73uQP/2LOaKDttbRgCuNXNt8fjQShDZXR?=
 =?iso-8859-1?Q?URBf2014kZoL5hze0F34ZBGdPLcSrhrOvVx4ryCPCnhfgoPzT6pg/PZoZe?=
 =?iso-8859-1?Q?lydJePyPL6V8pE3jWreUBWDKiWAPV2Sh3arLSenLbkFaPgDjxBpjYX81hj?=
 =?iso-8859-1?Q?8DRaGIQi2bz92Mf2afMawcvvoMq9spsiE1XyJ8eKowhk5oXoMA01XjQEsp?=
 =?iso-8859-1?Q?LVQPEXm+pB7hpHHgyWUrbaR4VJAZCbgcvxFYxojsoqIazkJWoBzZ5iTZGr?=
 =?iso-8859-1?Q?GUvzP/BXq1WH8biKu9tdT5AIyUYR4Z+jqp51L6zMtp+VI/P1fzjRjOTvey?=
 =?iso-8859-1?Q?yg90HmkknGxFW4FomN7Ar8mwD+4eya7btkFjOv/TSr3SV3CuvUwNmy8BNf?=
 =?iso-8859-1?Q?kQgsmziPH+g9puglR+Tfhh3RwzxkJky9Uj0wKyhhBS59+Eer6IpL+4+poD?=
 =?iso-8859-1?Q?9tcSlCDlqvYBP7lP4jCprIzy4xIHgePg6tdpen605SVmrFMyNhhNp8Ih2a?=
 =?iso-8859-1?Q?OHoil2Kz+BuF4psP+PFO1a/vhdIAAYJ9Og7rKvC6KIK2ZFmu6gGgm09VAu?=
 =?iso-8859-1?Q?uTGo6GkU31QCQYWyr5gXEdQtC2ebBQq66MRg3e8cStnwVUTOSI+MlfH/9Q?=
 =?iso-8859-1?Q?dPQKjJhygfzDpTDwxMdH3iPip5NavS9QlII8MiSoumueEIf/LxjA7kdk3t?=
 =?iso-8859-1?Q?g98LbGGoxKYZ+FpgBk40Ewf?=
x-microsoft-antispam-prvs: <AM0PR04MB5795ABA77A34C47850781D5AF6750@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(316002)(446003)(3846002)(2616005)(476003)(6436002)(110136005)(486006)(54906003)(44832011)(76176011)(106356001)(11346002)(99286004)(6486002)(105586002)(14454004)(102836004)(8936002)(68736007)(186003)(66066001)(26005)(36756003)(71190400001)(71200400001)(6512007)(5660300002)(50226002)(305945005)(53936002)(8676002)(7416002)(81166006)(81156014)(6116002)(2906002)(256004)(478600001)(386003)(7736002)(52116002)(86362001)(97736004)(6506007)(6636002)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SthuvinAQG4sqSK7OjwXInZlAgcEzzhw+50yEeKL/kumvtSw//6B40MBzB4HV1NzShT3yJAgxJIKO67wc9TvfQP6c4PhvUgIvtR+jiW9AQvKh9vhOvaX4hxOxXuGYDdbuR+2/FRLKtwO2NzAez6pKneC3X1OUJjx8RS5WMfPrfGnvUZVy6nvR5fH8wJlErwz/sQnL1Zorb9Xs9NsOSVhFUV+NgWXIz6QfarzkJYTd0xII96Zy4GzeDSA/yKdk5OmnPV31x9M9/T2jls52TzIJJxedqSvmyCXM5AEV+CyrzjSwLbld14kz+limHAjy0CzNUpm01xyvBK3o2iBquKt39KjMvi/dIbjiVlgU+DrjpZ2Pvj8+too6MtdNxNwmq+zxlC6iL8h2b3nUTHPdzHKeMZL4xM1jbnr+2u+nOgvl3w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff95427c-9cd3-4122-d15a-08d69dc5ac32
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 21:42:43.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks and their latencies will be used by cpufreq-dt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4..1a89062 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -87,6 +87,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x0>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -95,6 +97,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x1>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -103,6 +107,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x2>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -111,6 +117,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x3>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
--=20
2.7.4

