Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ECE206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctvL7lHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCKHRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:17:12 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:53313
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfCKHRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIB9B4sPPVj2fHYe81EHQQssn7tIDYGbILLjeoXVZIo=;
 b=ctvL7lHG/QdovthoWAkcWv68WanijpGo7UvYT/N1ncYvFXkarwTM1EDaVNXHJC5kLu7LeeblSCs0/oPS0O/DvqWI3Cl54n0oC7JF9BaG/qYnfBAaGQ4zVbEjpI/PpOsbLQCFeqXxS1XBtlNdyo5ShfVgpBJsT3wK/34GeCAZ2lM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 07:16:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Topic: [PATCH 4/5] ARM: dts: imx7ulp: Add pwm0 support
Thread-Index: AQHU19pZs/QkjBQhTECvLbkuloZZ8Q==
Date:   Mon, 11 Mar 2019 07:16:30 +0000
Message-ID: <1552288273-31028-5-git-send-email-Anson.Huang@nxp.com>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3e17da0-f5ba-46b8-0be5-08d6a5f17bd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3724;23:QcLoxisXtCO1mbWMAM7z0mc7PtSUFWN8xGZZo?=
 =?iso-8859-1?Q?WHumNM2Gh7iMjyY/eZeLyz/8X3QkhoiSGs9De24JdbTDvZ+kR7m+nJ6Gki?=
 =?iso-8859-1?Q?zJM+2h8e+xVf3I8bkI8at1eSJV5Kl6MGuCBqeQX7EaiR4xkEYcLF40NimS?=
 =?iso-8859-1?Q?Q/sYUO8xCGvJrJRadBtMa0qgj1d5ftJEJlS2txAnHU4ggM1ylUU+4ApIyu?=
 =?iso-8859-1?Q?ZOxN9FCS3b+v52VJ3IF1iGbXgb0B8HK5TcLhO3/P61OWIwAjeqWGDVYbVR?=
 =?iso-8859-1?Q?/hR4uuZL1wtX9nyHglIb9Iw4kCMGy+wXlCatmc8Sd0lVuaj3Tnm/NJYK3D?=
 =?iso-8859-1?Q?xqPQDL3IXq2aBssKUH2ffP+xI/z8gGybOfI7JcmidMctAK/wNY+9xM3ma4?=
 =?iso-8859-1?Q?UojLX70MRujkjr0gPlTAe36OkYYkOnWgOx0Zyo+b92e4MstbeDpXAQ01SU?=
 =?iso-8859-1?Q?DiE3r2HCMBY8eYKbNMdXIhv0pIiewnbdgH4oR5ThlYPBxnkla8IaEORkim?=
 =?iso-8859-1?Q?r2o+Zx9Ou/xgD9jwn6TkxL4kOz+3L9rGdF5/5QbZ7VkRqCTCnrAAUceCby?=
 =?iso-8859-1?Q?qQN91rmhW//jpRcibL8ELMiIo7RE/y+AJcB02ko7DaFEjuJJLnQRsdLtmC?=
 =?iso-8859-1?Q?oS7HfciL941IpYMeb/HPZ7GWdUnkuwb07sc6si+rxT6y0b/4fIEc2Qe4Sz?=
 =?iso-8859-1?Q?9zIC/vRXFohnjdFp4FLN34gJd2dOe93pnpAsWyYZGpjILAVvd34DX4sKHv?=
 =?iso-8859-1?Q?Jg+Y9YATlE4U1z9M+iNC2lVHhbehy2dcP2xjgOvVi9MwNFaoFJlwDIAjaz?=
 =?iso-8859-1?Q?2/xsgzg1ZGqBOtQp5TLCos7se9GU5MC/Hir2N7xpnYrOFG2dtXr9wWnqsg?=
 =?iso-8859-1?Q?zwfn88kM3C3R9qA2nUoCFoAZOlS/GOKAyKI+e8y0wYz3SBHTmEdYa/05Ye?=
 =?iso-8859-1?Q?arG+PosNpFeziwF9lZMeCGiH5T393kl+/rqLT1g1X76Ke4uEdj2vdxm0/F?=
 =?iso-8859-1?Q?YVT5Disp9NUw6wEBuv2WNq7C8M3p6T6ez4KGYfzCWI5Jdr9OtHkZYOA1zd?=
 =?iso-8859-1?Q?Sge5eerMt6eCqtd3I7J+9Ol3v5Yt3Za/IwpJqP3UlLxwSIjCX0FCnNLfpl?=
 =?iso-8859-1?Q?+TVHqOm5wFW6KeM56OiogvOssYV6vJKmnL4nSrf+knrPE250gbbnY1aE6e?=
 =?iso-8859-1?Q?kGLGqp48GuVLjUeQosCLx99u8ZohRVvIJg0nOHHsXeA2kmi4pPA4gqFjDr?=
 =?iso-8859-1?Q?asdtT0P9YDLknXsvfRsNKQUx2P7BmbUoj82QVJgPlpCy3TvmegyRDRmHkI?=
 =?iso-8859-1?Q?xBWJENoxpecaZqMGPZwjCv9taWQSEKJWyEC44IlLh78IzXw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB372471CFFE8F5E35D81B5E5BF5480@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(105586002)(6512007)(6486002)(2501003)(6436002)(97736004)(446003)(110136005)(2616005)(81166006)(81156014)(8676002)(11346002)(106356001)(478600001)(6116002)(3846002)(4326008)(25786009)(486006)(476003)(2906002)(305945005)(316002)(7736002)(102836004)(7416002)(14454004)(52116002)(256004)(6666004)(8936002)(66066001)(186003)(6506007)(386003)(71200400001)(99286004)(5660300002)(71190400001)(86362001)(76176011)(14444005)(26005)(53936002)(68736007)(50226002)(36756003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lQssiCuu6OmypOwHjYCX0wu688kZOpH/5u0Aa7pAM1SGEo5Grdz6KmlbYgO+MVTqRX8nssm2qSAdOxT694jC52ZAHo43cnBpB7FVu+EfIfTLI9e6RwMkCTkYPdoippw15YmwxlxhKn/0B+/umFh3e/NpEz8EreQ8cULlgZam2RHkmmZnH5z5JkJLXskC2nrkVU/XSlWA5IHK5E8ZHlv84yVPzObY+5YJT9eI3AQJgEsNTmR0kxl3KBAk5HIh11Ht6NrvjeA7uiPKGQcpz1cYH+2qCUh1yCw/hXEVowlQTi24pvBZkmufGEoeB5qoqW0UovGdwd06520xj46pb1B6rm2ulZc4gv68XGeWhoBqcGzhdrl5hba4ZgjqKdlI4TgEVHiR7SC+o4keP1B07342G2m+5u3M1yy3RMk68SGRV2I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e17da0-f5ba-46b8-0be5-08d6a5f17bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:30.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM0 support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi    | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index a09026a..002b0c5 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -40,6 +40,12 @@
 	status =3D "okay";
 };
=20
+&pwm0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_pwm0>;
+	status =3D "okay";
+};
+
 &usdhc0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc0>;
@@ -57,6 +63,12 @@
 		bias-pull-up;
 	};
=20
+	pinctrl_pwm0: pwm0grp {
+		fsl,pins =3D <
+			IMX7ULP_PAD_PTF2__TPM4_CH1	0x3
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins =3D <
 			IMX7ULP_PAD_PTD1__SDHC0_CMD	0x43
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index fca6e50..cffe9c3 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -124,6 +124,17 @@
 			status =3D "disabled";
 		};
=20
+		pwm0: pwm@40250000 {
+			compatible =3D "fsl,imx-tpm-pwm";
+			reg =3D <0x40250000 0x1000>;
+			fsl,pwm-number =3D <6>;
+			assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+			clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			#pwm-cells =3D <2>;
+			status =3D "disabled";
+		};
+
 		tpm5: tpm@40260000 {
 			compatible =3D "fsl,imx7ulp-tpm";
 			reg =3D <0x40260000 0x1000>;
--=20
2.7.4

