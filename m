Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63851C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B33620684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2hw5L+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfCHMCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:02:53 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:15337
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfCHMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VRlsE/KvFCtQHOsg55l43bl/funa37fHf4AC9pZYAE=;
 b=P2hw5L+lo5BYQ8bvkJkMBMoDgN6pxxPykCYfSVtMade9DB1Nz5myeDvvEr8Bo5leFEMgIPRZbDhEckNq5n+Mr1l1IfmDtRudJUd2LSp0hfphnS5JNov+eLvxvbir5NmIiNLVU+M2woQjRhvDq05BRqoyIrgJXZKAuhzqvmF5FHI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3776.eurprd04.prod.outlook.com (52.134.15.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 12:02:26 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 12:02:26 +0000
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
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v6 3/4] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH v6 3/4] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHU1abMG22YUAXCR0yNHVTQ5Z/sRA==
Date:   Fri, 8 Mar 2019 12:02:26 +0000
Message-ID: <20190308120141.3698-4-daniel.baluta@nxp.com>
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
x-ms-office365-filtering-correlation-id: d3c0a143-c64b-45fb-d7d9-08d6a3bdee8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3776;
x-ms-traffictypediagnostic: VI1PR0402MB3776:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3776;23:FHTW09PRlq97nN+jIcAdi71kXsHj/XMmf0S+x?=
 =?iso-8859-1?Q?B00sDHF9J8ab2hrJ1wwMdXe6BPU85mAy471mqp48zyC44bndLG8l9O/+/h?=
 =?iso-8859-1?Q?Hb124k0LQ1Wg0Tl0fqab0gfNjLKaXQhXZKFR8IV4tIg/pP73vDHsPVvBM3?=
 =?iso-8859-1?Q?07g3JxlhGmUkG0N6jwqGN7pmQuF2Z+QdR9rS8sDg2n31OgCBuF4nT4ymq4?=
 =?iso-8859-1?Q?HuSP0qgCP493iZf1OKxh8MiZsXLklqFn5L81vKPIY3LyWSL4bXl/s6/Jqd?=
 =?iso-8859-1?Q?BramJ8gHXbN08q5qH9jFYrCDVJpIPKSxa9jXsRfr4LQScHg38vhfRCPbhm?=
 =?iso-8859-1?Q?kJgFhqLm0KZW+wy2xU0H4LEuW6ET41vQzeR2nI1Do2Y9aiSLukS6RldmJB?=
 =?iso-8859-1?Q?sFB3TgDZtNRlYeDHRQHFyAszO2vOZnvA61PJLq7TZjViGpTLifbo2jlYAB?=
 =?iso-8859-1?Q?VGhOUnfBqq5xFby6Kq3aho66kea+yxuto+s5l541sCluI55Wjmg+OiA4JE?=
 =?iso-8859-1?Q?G/ZSm7+C8HytIR+L0yBs59/I/vzZ6ojManFr6w08qjDt+CDt7oV6INLdIA?=
 =?iso-8859-1?Q?yINyz/g1mauK+LQrdY+UVMGoAN3+zgG3jFfdJsxmXwHz+9RQN6kYFgqPyv?=
 =?iso-8859-1?Q?Wbyv5l/m8YA9M9eWeEwsNHPydIQriSGiT17hqe+jGOTIjnrCW9/FGslOQ4?=
 =?iso-8859-1?Q?D2glhcvHaRSheYqOdF/GolkzFE3AQ0MSs2WumjZl54Wlpkzk9MRVOo4XGc?=
 =?iso-8859-1?Q?KAV2G3zBKI+p7SKrt0QGtYoqTySmDT+RHXPwhbRBU6t1ZKljvrApmSpgIb?=
 =?iso-8859-1?Q?OCWTfgfEQbSJMfFybx/iopylwVQMYzWiYqbyvevdwStYwTOtmgBckz9Fzp?=
 =?iso-8859-1?Q?Kn27lDUTvjg1hM9T5/yw6tsaqG43U1b9JONS2vyDDBj8ErN24/VnryrJPK?=
 =?iso-8859-1?Q?C6ixZ2nwhz1RXrQ5aYvJeooYZTXBYHzLx65vyh/EMqIMjRPB59DvI5oR1E?=
 =?iso-8859-1?Q?nv5rGGFLPPoWGD252ZYvJT/UthKVFXd6PI/Nj+6l6r72lhIsRvo65aLLZg?=
 =?iso-8859-1?Q?7NFRtEzcSbnXRt6vE7M6jEGnkhg/iMuNvL5dBpQXEH9qnwtWCpptQWh1jl?=
 =?iso-8859-1?Q?bQO7NuCXcfvUukdiSklLkJb2BU3JwhqsgElyH3wolSzQeaTzJM4QqcgIJf?=
 =?iso-8859-1?Q?HzJujcbYnH+nx08UdJcjPhwZIHFvfijYYNwNkEoGlgLcX9ZcHFOz3aafi1?=
 =?iso-8859-1?Q?U1ZtBbhIUYB7+IP4qqrB4+yEox15BEOvNCvAVUDefcaxppORE7EVKeGBra?=
 =?iso-8859-1?Q?zmVuUR1lPGxf4P7WYZbE0715eWo1vxIvnPO6xeQpj0u2MsXmezewBz9/AO?=
 =?iso-8859-1?Q?nTi2f+QZ080WPyzYfyNwuVQ6XOha6sENxvAPQFr/WDh636D97FGF93Msno?=
 =?iso-8859-1?Q?golwyqEwmufiK7ePxTp298ZJHpNWOEPXcQ+A1?=
x-microsoft-antispam-prvs: <VI1PR0402MB3776A2302A49410E0D9D788CF94D0@VI1PR0402MB3776.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(36756003)(52116002)(2906002)(68736007)(6436002)(25786009)(7736002)(478600001)(305945005)(4744005)(105586002)(1076003)(14454004)(2351001)(81166006)(106356001)(256004)(14444005)(6486002)(8676002)(8936002)(50226002)(6916009)(4326008)(102836004)(54906003)(3846002)(6506007)(26005)(66066001)(386003)(6116002)(316002)(486006)(1730700003)(81156014)(97736004)(44832011)(6512007)(476003)(186003)(446003)(7416002)(86362001)(5640700003)(11346002)(71200400001)(71190400001)(99286004)(2616005)(53936002)(2501003)(5660300002)(76176011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3776;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U067c9OjYmKIShXYSPrMdGI1ykvosAkUhFDy2k7iud47t4ObBGbDDU23+McXuAUFz2WNAgOcUrjYvrWfH/iix7VFhLafq5ZY7tBqrOOAYpVacmIysQEJBnQ1PeEnmsEqWlriy4wqyVVS9iNm581eg0yOLH4hHxeRNYxlDpHT2iZju58LQ6BcTwlsrHshHTnG52lC677IJXcl9m3vhOk4DiUOIvRigrli2O4Uu2jjioE42AkSkc/vAUaRt3/YUDSHZIbCJuVzesCfyWKnLs+xWtu5CqW6xL9uAZG3XW895w4lvRHLUXVATWruhV4G9QYNtpIIcCwssTY+y51Xu9ce9znx3bttZCDdu3Ikf6y372QTOkoE5D15q0WCoqqYYQyW+P9GCVIzpqsv93jHKVT3THq5xFNd7XFHtx0iJtV9XBU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c0a143-c64b-45fb-d7d9-08d6a3bdee8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 12:02:26.9490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI2 is part of AIPS-3 memory region.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9d48450453fb..b39c6c75c043 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -489,6 +489,21 @@
 				status =3D "disabled";
 			};
=20
+			sai2: sai@308b0000 {
+				#sound-dai-cells =3D <0>;
+				compatible =3D "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg =3D <0x308b0000 0x10000>;
+				interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SAI2_IPG>,
+					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible =3D "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg =3D <0x30a20000 0x10000>;
--=20
2.17.1

