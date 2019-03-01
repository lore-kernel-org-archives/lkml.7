Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFE8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEA120857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HRFA+AFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389069AbfCAQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:37:20 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:43654
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389033AbfCAQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9dqjS6ls4Js8muY409ABIGnQCk2YQ8iB/PDPACZiAc=;
 b=HRFA+AFAxQBB2Ztw0JM7EyjMAOj6BI2WkwvEEDJruekUN301SSvRa4maQYRGBtR+raxsa/4Al57gTg2Ij0K2bIpsS2bpIXg3DxbAyT/kFicd88MUe3WAYbZ1RvhW5nUAPkVhzJ8arM8xw81Q5KdO8dp+TRgdJPBbzoLl9SPw+Jw=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3648.eurprd04.prod.outlook.com (52.134.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 16:36:32 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:32 +0000
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
Subject: [PATCH v5 1/4] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH v5 1/4] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHU0EztjVTk7NEnmU+psPPuICMsKw==
Date:   Fri, 1 Mar 2019 16:36:32 +0000
Message-ID: <20190301163604.10618-2-daniel.baluta@nxp.com>
References: <20190301163604.10618-1-daniel.baluta@nxp.com>
In-Reply-To: <20190301163604.10618-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 216c13bc-53a4-4fb8-2b1c-08d69e641007
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3648;
x-ms-traffictypediagnostic: VI1PR0402MB3648:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3648;23:S6frb8tVlg2DYU7bwcPbSy3k1FUUusWpZ4CO5?=
 =?iso-8859-1?Q?iNimWBQMOJzZmrfkAvr0n6KhihkqHoJ2JRbChOA6doTgdrvYLr74SlzdgM?=
 =?iso-8859-1?Q?rmeVm+t4DZH9ebyCsjjlQgfoflxZiWkd32B+lnx/OMxYrUdVaUJW1TzYZp?=
 =?iso-8859-1?Q?WwsR34GvTZ2ZYN/jfl7zUyg5GDKoWESIoyFDoa9etdR2imv0zNwDaiL1Zh?=
 =?iso-8859-1?Q?MxCQV9oew1uOwokTsPKkuFLI6g7DiiCcsOjSCfU2hNuizCejUxBAtDDNka?=
 =?iso-8859-1?Q?6tuLCJa2dkWcJ2i4CWZ8uESKcBI9w22bwh1oIE+eJYQn8WY5uts0VIp4T0?=
 =?iso-8859-1?Q?8qwa1hld568SynV6ccoGkZB2s26/V7MruReaWREjzGSjctJzCrMcDe8S5S?=
 =?iso-8859-1?Q?Mw+EA7y4kqSDPsb2Pk+eeBztb4MUCBF+e5UlT4QcElOtOTZlQM5TuBUGqn?=
 =?iso-8859-1?Q?mlAfubhYy4K/28rwipllN9co1fP6YRyYqkNu+yb5/i/iuCC/IelVgHu91d?=
 =?iso-8859-1?Q?0FTakBtfMJEDZHRM2NaY28pMIQdbL1xIJOpe1WshEoGCVembSO29S3Y5Fx?=
 =?iso-8859-1?Q?GWfSUWid4Q56EBlKIhzPWEgvt0Mon0B/IMuduRY7WIGkPXu7O0WKSCcw4X?=
 =?iso-8859-1?Q?cnauiIG2xJhygC1vuIfy8mgAd+BxrxlxUXVMzvFCJoq5IUs9EGkr9gb01v?=
 =?iso-8859-1?Q?qN5Bk6dFlfX0WiePr7NPABUvertM4xecCEJYqyNYPSvYfZQHynG4YnxaAe?=
 =?iso-8859-1?Q?y/+PVb6M/L5I1md2n4gvqQQtXlvDqOmEZ5o9B/lNrUH9wqxL0x+g+1/57c?=
 =?iso-8859-1?Q?I6tghNBXv8r9bh/uFenN8obVzrVYN+yDs7ARX5mSS89hI9mnUQ/Q+3PWIV?=
 =?iso-8859-1?Q?sOPiOROUgx9f8KJDjJgVbUoiezPQsWrgeg6o9v+EPXENqLsWKHT8K5ifay?=
 =?iso-8859-1?Q?RXAtSO7PwQh25Doq4P/7weUFYGamj6LcBQu3FqAG1CCtRVL9BgGKFw9JjN?=
 =?iso-8859-1?Q?nb+vM8t2fit5bKEU8XRn9NUF++AZ3GZ2WHycjE7Yy5YW0G9hEYTdUxvFqe?=
 =?iso-8859-1?Q?WDPEDFnR0BAMN3aqbUfgJIwczUvD15dxhQeU/2Dtbtgb22gh+fct/GZRB8?=
 =?iso-8859-1?Q?LU0N7LUEDVJO21R+wz0bxvA2qxgHi5uYiQ3S04BZgAFr8LLjEpPgsgGcD0?=
 =?iso-8859-1?Q?nDBY2fnDMl8z1AUWuzd4Rwctbj4ThHv+Kan7VX67Gyntu+jekxJjg4NHQ1?=
 =?iso-8859-1?Q?8ZN47VU5lJ0FiRMhGfqHetS3D+tnsLnYyqTTA9Jg98mOD2aaQlYgHUCAKu?=
 =?iso-8859-1?Q?+k1zwuvnKBe6gpJP0ZPC9kUSI3AyOCA7V46xZrOpzIesStVeRt40s4BiYw?=
 =?iso-8859-1?Q?eOy01vT60uPELUrpgxNniuZ9+ZaXp664kIkABz38c3heuStfn4YZVlcSdU?=
 =?iso-8859-1?Q?pMG5fwsUfzqFZ6bU=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB364859375B15DE13DD0904D7F9760@VI1PR0402MB3648.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(68736007)(478600001)(76176011)(6916009)(99286004)(386003)(53936002)(66066001)(52116002)(7416002)(4326008)(2501003)(14454004)(54906003)(6512007)(14444005)(106356001)(2906002)(86362001)(316002)(105586002)(256004)(11346002)(6486002)(486006)(1730700003)(186003)(476003)(102836004)(8676002)(25786009)(81166006)(6116002)(2616005)(446003)(5640700003)(3846002)(97736004)(50226002)(26005)(8936002)(71190400001)(5660300002)(6436002)(305945005)(71200400001)(2351001)(6506007)(1076003)(44832011)(7736002)(36756003)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3648;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x/wFEJdb2SAryj6OoXqwAyrnzw15A6f8IyNZNuwcMUNcpNSaXgy2il3QSvtsbdDNoMzlwwOECCbLgox7+KhIDN3Up5GCOF8CpW07z9E5zaxplCqwQz1H8TwEp9Ei/kq79n6CJ4U1wLGiCJZZoDUEDsT0RTbENUEQqwuxxiNVNMlqzp9J6rZxy946ffXb1YTMEZfCICDGqk3p0hv3NLsFR+91cSZjbsgQFVZhaYk4G6mW09+mzotgn3+2mck1ZSO+50TifWscQDQXglWGDa6jJQaBihN3QyedmPB76Q3POjePjf6jY92GXUu/II8Y5EODPj2vUPD2mkMRTCRgo4siUZzAYh8eN5Ke5jk2HK6Vyo4kb07QsQ3BBMYJha4/XDhYe4SKwSWiPuNkNFOzcPz4HjHoegyqwHwtnjcXHcI/0sw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216c13bc-53a4-4fb8-2b1c-08d69e641007
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:32.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3648
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
+				compatible =3D "fsl,imx8mq-sdma","fsl,imx7d-sdma";
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

