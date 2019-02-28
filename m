Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2961FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27D02186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7sGdF4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfB1Csn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:48:43 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:63313
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfB1Csm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KMjtMrjMl5ZbxUjf4/lbrtX+30ye1bi0W+ahmO2RDA=;
 b=V7sGdF4CUDW5oT5DLUNo1awVrk/Sk2qZr0Pj5hXXV3XfLi1z3OnfjscrzTC5+IyO/wxI0ZbPCN5HLI7INOwCuL3g6OShMPy21OzD8AtLw1dW/bN4PwinpTceOvi/yWnAsk2FPiGV/wspbY08HcIiWy6HZt0nM6+VJIf7bKu963Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 02:48:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 02:48:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V3 2/3] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHUzxAbAI7hDwl+2kasEymlcTx29A==
Date:   Thu, 28 Feb 2019 02:48:39 +0000
Message-ID: <1551321831-11597-2-git-send-email-Anson.Huang@nxp.com>
References: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32fd6787-a4cc-4f48-e875-08d69d273dd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3833;23:A/Jmdpb7Nt3UCIleVHvPYwWldy/UGpEuufGh5?=
 =?iso-8859-1?Q?NAzbdbW4BPObOFDuTUe22RnaSTp2qA2w7M75rjc1Ruq62VE16wYATB52gg?=
 =?iso-8859-1?Q?CT2chIUtZO4ij+xonhUfg3FfuiWq1ptL1cQZ3rX1bWtQFI61mrot/9qJNL?=
 =?iso-8859-1?Q?RITdgsAbIPhHimZHfiail+EdWbEHcznXgERP1VXApxdFB63tKOSzWMABmk?=
 =?iso-8859-1?Q?hfLBSjraZ1YZ+KQaBUtVCykBqjUm1UOqhGWNj+sG+0cxSiDJ6AHiu7txdM?=
 =?iso-8859-1?Q?T0JVmVLNbZEkPJXf2y93N5qnTD2n82B1DRGwviRWcDNxuhle+7lkvWdYrJ?=
 =?iso-8859-1?Q?/HLLZ32fGxN2BSgGQP2uc9woV80sdT6selG7WUOJSm+q3IH4KmULCaPGxO?=
 =?iso-8859-1?Q?OGckkduc7PJCvEFLZusz/ji1KYU1chc8TeZYFXyFJWiojB7zDKkn8WbZcV?=
 =?iso-8859-1?Q?xet191QGPM84au+x61wv9cL+VApX7flgc4IeDgx0hUC0skGx4mMvFcWRHe?=
 =?iso-8859-1?Q?RkB9Jb5EDFLqN7fNCXVO5CV/kA1Z0joNLINEcU7P+glrKVqjIjGaQiqOgS?=
 =?iso-8859-1?Q?g01TonAbuDjiZ11K4VPmo9IN/TA4rgEAETlo0wFVugpg0dNkDzNholrzQF?=
 =?iso-8859-1?Q?ehto2mVXrjK074IrECWXvgA60CMkMAtYR2/610P2L/IVre46lQN+K4c5eN?=
 =?iso-8859-1?Q?/Mp0mH8NsJjBPqSikfmB9nXBoAVNG7BgEcsYnzjspuj5ibGTQS8tUcdWXq?=
 =?iso-8859-1?Q?fXX/cJx5D/PiOmDEOSX18XJ+GifNvnF/t6ZF3ggBHOSV+8NC9DXpuR2q5v?=
 =?iso-8859-1?Q?qFS29N3B0PvSvVmyZ+9KCLl1U8AgveBFet5SBC96nLcUXwzrotOPUgk8Tp?=
 =?iso-8859-1?Q?py9h2Zr3gdhf2iT/w7ZqW8gkGXjNE7N+9MAf5+6EGEhbe8s1Hs9bC6ADJY?=
 =?iso-8859-1?Q?iFqaGiUkviIU7SEXUvxXRVtFJikKjQsR3MdtlRuLSCZrBdZVwBf5+klg6n?=
 =?iso-8859-1?Q?/FR7Pck3YjP14X4gzbF4jYAKbHcK/JpI6K6uImER4OxI9DriBzVlPDIppN?=
 =?iso-8859-1?Q?2zsMUZIiHIz5AnhkD9K8HdwDzCLjvmnCJa1ByL8ztVWE6wwxCSXsbm6QOi?=
 =?iso-8859-1?Q?EhWJsxHPZu+lRQianJlia7H+VZ3eSSpbYgQxPJcguSVGkTcR/025Vf/kvd?=
 =?iso-8859-1?Q?m/gS4p1c39o0xQiucstZSpvgIroTWMIMUOgssaWEF5YGLQQWUp757UtNm0?=
 =?iso-8859-1?Q?q4KzBTLWbhLiWoj/HBCn7n6QExHWIvCD2fFs2evbscG/duvCDIHkg0GCRn?=
 =?iso-8859-1?Q?k52c=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3833E5B8DD323E41BD3DA3E7F5750@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(97736004)(102836004)(316002)(6506007)(386003)(186003)(8676002)(486006)(99286004)(81166006)(50226002)(81156014)(76176011)(26005)(2616005)(476003)(52116002)(36756003)(5660300002)(14454004)(305945005)(7736002)(14444005)(256004)(3846002)(4744005)(6116002)(25786009)(6436002)(86362001)(71200400001)(2201001)(71190400001)(66066001)(106356001)(2501003)(53936002)(110136005)(11346002)(8936002)(446003)(6512007)(6486002)(478600001)(105586002)(68736007)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +HS3zaRlclAkl8zEa2sftWeJ19JEW6BY5doUSkbgc/PH+W/VLCu9t8wKx1aBIdWdqHF/eO52jfxCsMB5aBL8BPZfugy+2hn+WcT+TcAhbXxliluasXnCyNG7Yvs7SYsfYud98ZwqPwuMvTXfLJHTe6A7vToAhO4Eq925c2zQyGu6AoM+WWm72AEqLtLikrq3FSl9e37h8jj0gQSaXq3CEa/8IcRRypC6rYbazKrJjWpanHZTUxgu6nuK8NthvSQsAG4qOThioSWzo7kY4Kh3TpxsgWacW6sxLaU8pm01Szu8BY5YRgALkgku/byJEEMCowaTOLq6nnhz6fmCkeysaDdc+U0mc1DtbkosmXHAqbyWQ602/yrRyZDqAOHit3oFc4BAHatJCMOgTOlKwkpkoc82qFUx3Xvyj7t3A/N+PQw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd6787-a4cc-4f48-e875-08d69d273dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 02:48:35.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a MMDC module to control DDR, it reuses
i.MX6Q's MMDC module, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- remove mmdc label.
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index fca6e50..eb349fd 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -286,6 +286,12 @@
 			status =3D "disabled";
 		};
=20
+		memory-controller@40ab0000 {
+			compatible =3D "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+			reg =3D <0x40ab0000 0x1000>;
+			clocks =3D <&pcc3 IMX7ULP_CLK_MMDC>;
+		};
+
 		iomuxc1: pinctrl@40ac0000 {
 			compatible =3D "fsl,imx7ulp-iomuxc1";
 			reg =3D <0x40ac0000 0x1000>;
--=20
2.7.4

