Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0582EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE5020684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTFom/jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCHMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:02:45 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:15337
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfCHMCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLFhH6ztgyfELTRhJicpuFG5Sb2PqHcWN1JkBWhSpO8=;
 b=gTFom/jn1aTctP60mhVRCQ4/9K78fVmsMrYvGSW4DQ2cyt+k66IDhVHdTdGk2BwkcK/54YP+5sJDMFDaJLF0T9WnjHIGWJ9YbgCtLUGRPnoDxWWa26mF5KZvb8U2qWhpHeSLmhbDqsgdLqfmmbELNSc1EQV5C2C3hAZTG1+5N3k=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3776.eurprd04.prod.outlook.com (52.134.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 12:02:23 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 12:02:23 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHU1abJ15BeStcYNUO2laJ1F7za2g==
Date:   Fri, 8 Mar 2019 12:02:22 +0000
Message-ID: <20190308120141.3698-2-daniel.baluta@nxp.com>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
In-Reply-To: <20190308120141.3698-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0074.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce7dab6-70ab-44e3-4efc-08d6a3bdec3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3776;
x-ms-traffictypediagnostic: VI1PR0402MB3776:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3776;23:T/8LkvD9W/3AjtFa1ntAX2x8qR3yVRoueDrnh?=
 =?iso-8859-1?Q?fZXUeWWYQCFvopIHQw4pZ7DiGTNVg/Hs/teTJmBqo5nbWUa8jmuTHRO1D8?=
 =?iso-8859-1?Q?aogpi4xl2BVjx/OkJTI2gLvO5GebQvVlHQTNe0Od6iVRAza7SAfc8RIJs5?=
 =?iso-8859-1?Q?QQq+H+GrtLUHCgYuzyfdqwYbEVObGCHo2uRvGqH+cwgMi1wi1SIv25ERms?=
 =?iso-8859-1?Q?jRAuLQ2uDe7qxXn1ebpHJJuUohDa2abKoZ4edNyEP0GX2wZihFMigXwEAt?=
 =?iso-8859-1?Q?uTaclxr6yuZhH0dUQmy0JuTrZVS8Xe0kFXK4XHcKk57zPKDmgD1KShfPBR?=
 =?iso-8859-1?Q?8V+ZWKhuPeka44JhATtvxjjTG6joBFv2B1SZDtEMIG9l+dpcjHINnCR3Fn?=
 =?iso-8859-1?Q?sbbZkcDr+agPC+HogUQ2SDQcPXYixyL257S6D4qK3H3qtmqWmD8n4c4QlR?=
 =?iso-8859-1?Q?WXlVoR4GyE6YIN7JgMxoVz+0T+PCcNWHshDfhM5RtCMwPaJ1dzGXxI4U27?=
 =?iso-8859-1?Q?HO8sLGokwAuVAYcqZS7o+8YTKlc8Cv4Dci/uJVhsehdU54KjtFfDMPBp8Q?=
 =?iso-8859-1?Q?xrstQkmq2I67b/66uDqvo9rjfiUG9ee8vI7Q15cCJHEKyHz7GDSS8Sd81T?=
 =?iso-8859-1?Q?LtGsXKRltFYnHnPj7BPn06pbhUiSaav1JZ6XvbO6z+Gqoef5F7ATGbzzEg?=
 =?iso-8859-1?Q?BnIUIWgbAwNgNgVR+kcLr+uT+0kkBULtDC2mJxitScelLYELXyLOlxQ3zE?=
 =?iso-8859-1?Q?upYmp2FvfIEj6ttVKnzbT8bojC1fhvg7QKmRME9UFWV240b/0GjH/xZH4D?=
 =?iso-8859-1?Q?2xguNIKxn2jk3BTsCECuJliHw3P7bXUX6w+MXHX69Bejy+y6G6eXfJjBKb?=
 =?iso-8859-1?Q?nnpUbfpriJEmuuATMzOltQ+wAPf1QfRplrL/M2pOX+fXI2rqSzOPlgh3rm?=
 =?iso-8859-1?Q?nK/YvqwXtLd7gM0H0T27awvH0XUtLvQmqfXJ2a49TCx6E9RabIqIxLjBJ1?=
 =?iso-8859-1?Q?sg66DQ0vM58MkfjtKPXJQkzZwIkbm+Pp8H85n3QpDqVnN66uvV+Ldub2G7?=
 =?iso-8859-1?Q?WjEFnDed/lJsVebYNui5GHk1vz77J+ATVeD3vYfWWXLQ4zdBF9cQqpKXZA?=
 =?iso-8859-1?Q?uSYN9ui6SV9MPRu7aDFrjDRuo3NmGiIpMP0PM+y1LUitJRL9Caw18cP/Up?=
 =?iso-8859-1?Q?mLPeEthTGbdCAA9haBnyl8ERrbQPZY1Gf9tlDrpViU+Wo6Eh8BnajlxDt+?=
 =?iso-8859-1?Q?kxFbB5i8maVSleq/jitNXFVhPg86FK4vXI+FrDvR+lRHUqn+meEXZ3rMIU?=
 =?iso-8859-1?Q?e/KoMxh3RZtJYCBsq+R2Bk12m5hRH9JADpf90Q23m3NlJVWb9/NhDYJMBS?=
 =?iso-8859-1?Q?IwcUSzWjZBP3NVROPnvm3wenRO9fh4owIfn8cXUhQb4alckvZC9wGXVYb4?=
 =?iso-8859-1?Q?G6r+TH9vn1WqUy/Q=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB377671521C86704301BD9286F94D0@VI1PR0402MB3776.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(36756003)(52116002)(2906002)(68736007)(6436002)(25786009)(7736002)(478600001)(305945005)(105586002)(1076003)(14454004)(2351001)(81166006)(106356001)(256004)(14444005)(6486002)(8676002)(8936002)(50226002)(6916009)(4326008)(102836004)(54906003)(3846002)(6506007)(26005)(66066001)(386003)(6116002)(316002)(486006)(1730700003)(81156014)(97736004)(44832011)(6512007)(476003)(186003)(446003)(7416002)(86362001)(5640700003)(11346002)(71200400001)(71190400001)(99286004)(2616005)(53936002)(2501003)(5660300002)(76176011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3776;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: et5mzAwDEF/5ebYwOfdKzB44Qkhi4k/qiPd744DLVN68TnI3iAIQvbA2At8bPqnBvTbhHZI9LgL3gUnGHESW9YD/QR9p/5FBIXP1a6iH90QpLhfUx9IbMpZuWpn5Wng74wzK/gu8OxqMBUtuI7JAsEEiUzAcSeWNyAq3E1ZZYq17F0ArNOVFe99w5trGqmySF5z+Aub3mimBaJ8NyEYgK8PLhtd+YSOKhzFOLz6I2Fd5SCibI93pHNxG1dKZKulrI43BZ5ipfXHKEYlQ4wP9zakcxL37nHDL42O0JMrdXmJYKEYwkq2Rdjelq2CfXrSs7HAXfl2HlrMbBqChJ5GjCuSSjDeDEvmzamtJVDYWOoFznEx/NIv8MGWtydR45s8l18bmK8EE1FpeZAy7Caw1SKAD1yxKdvdMynpRmrtWNak=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce7dab6-70ab-44e3-4efc-08d6a3bdec3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 12:02:23.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4784eb..9d48450453fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma2: sdma@302c0000 {
+				compatible =3D "fsl,imx8mq-sdma","fsl,imx7d-sdma";
+				reg =3D <0x302c0000 0x10000>;
+				interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible =3D "fsl,imx8mq-iomuxc";
 				reg =3D <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma1: sdma@30bd0000 {
+				compatible =3D "fsl, imx8mq-sdma","fsl,imx7d-sdma";
+				reg =3D <0x30bd0000 0x10000>;
+				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible =3D "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg =3D <0x30be0000 0x10000>;
--=20
2.17.1

