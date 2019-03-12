Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZL1MPkiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfCLCYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:24:19 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:63415
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfCLCYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFjqIuzdVbsTrC1FsD2cyc5zSWardwQDNlJBlzjnTtM=;
 b=ZL1MPkiSnEP+qqASHJQvqTfdfOs/yKMbOQPmEGb5A8UkXQ/SsbDW0puFRnynWMKii7VFM+/cnEHd0FzeYPEZ1WxjhT0PjwWgRfx8UV0UYxFU2qk04MAA6yWBYYxYm/F5EjvOidT9w8kj6i9e7rQMbr/GDc/TsRqf0l/AGHdUDqs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 02:24:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 02:24:12 +0000
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
Subject: [PATCH V5 2/4] ARM: dts: imx7ulp: add mmdc support
Thread-Topic: [PATCH V5 2/4] ARM: dts: imx7ulp: add mmdc support
Thread-Index: AQHU2HqutMl5kcK+HUCOTAyMt4buIg==
Date:   Tue, 12 Mar 2019 02:24:12 +0000
Message-ID: <1552357127-1283-2-git-send-email-Anson.Huang@nxp.com>
References: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b443592-6a54-47de-2390-08d6a691d0a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:gy/7d1/nhsYz50gLh3Ih6T1JdwczcFlnW/9XS?=
 =?iso-8859-1?Q?IHb2Q4XjG96DEP0NVedleDOKYux3CPKvGL7G5hkSFKwH8+Ue1Wltf++LXI?=
 =?iso-8859-1?Q?4pCjU3cikQgpYWOxI4XhTRHV8yXirOJfT+yZfpSSb9GlZCFGxOZA5Fg0DD?=
 =?iso-8859-1?Q?AjLBQeTZfhQFOw4/orCY9xRuLlzsy0fBCVfmxS7mjVKYcLrj7rLRKqSkPx?=
 =?iso-8859-1?Q?F1EBGkRF9xHh1KWjaGJ4jrV8/SFiwTsJGSM/L+WpHjMCw1rGGwDG4Wok/v?=
 =?iso-8859-1?Q?a8+jwY2cpVQX6eEgxmBGqfsj9rwFYNMMLkKbwGSy0mbY7Ri/2wccHwWe0t?=
 =?iso-8859-1?Q?fpXtHHNKDCx3WNk+8H9/DXIvRJQ59EfirGJNey3AG6hoJtnpfjZXqkL253?=
 =?iso-8859-1?Q?8+vQ9Zwfi81pwp/VBDWLIeWmEbSY8HpVPrQnB1O+IccGLaRG1IBX/722Yt?=
 =?iso-8859-1?Q?lAvyUQsvEDs1PVy5yE9CeYHdLj4bIzWK+imYlYQIfYFu2VJ/8Ky3CTwMpv?=
 =?iso-8859-1?Q?IxdzYYS0szrTtYVX/kvlyUXGEDkHiLOZ6gB+xIT3ZWjipE59meOA7RAxQW?=
 =?iso-8859-1?Q?auvm2q7tC655x93bG+P2mfgHel7I4YfEisavHHP53pPBbcQ9Ak8MZhUtf+?=
 =?iso-8859-1?Q?BX7de8QVhlI83aYC7Ul2fERfZx9/6oFX1nXmtXklviZEIfc8Z2ao60DVmx?=
 =?iso-8859-1?Q?uRYgBMTbjwy1qJqJGPSpzB7A8ytJ/u6hT6LUgONG5RxUGQ0noNfeIrjcym?=
 =?iso-8859-1?Q?ICZykT0oeuGsAVFlvRP6onEvl3Z/rN06UeE1/w9EriVD4MnV4jy/G1Qbe5?=
 =?iso-8859-1?Q?yWn40aTvUSl7KZeOMBGftqty2z6XL9nvy2Ugnydftd8Sh0RbVvhaIPvDBL?=
 =?iso-8859-1?Q?hxSamAd+EIN7lYjpNMxSucfUccnl5nOw2oAhGePO1ewqm4Hsq8y2Hzd+ss?=
 =?iso-8859-1?Q?cCGJxUNgOz4Rw873w+NGHbjhwGNHcxb8H9P0P0cgRfvJhjvaxkrkYRHTzq?=
 =?iso-8859-1?Q?P4GGISpGUo5rnyJPaASB1C6DEUiW85LosGg2HdFfypuiH7DIEw5DzNjl4L?=
 =?iso-8859-1?Q?rurnO/b42sf8+g8vPD5Era5QABxRhc1izJDMbLPp4QA1XY4+c/E2QLFXh+?=
 =?iso-8859-1?Q?dEgAhUC1FNAFJHtDUhlINAXr/m2U1gBnje4OjZFgsK6XbVgsRd//pQZpd/?=
 =?iso-8859-1?Q?G13Z21Mg2uttD0CnKsMu0+S/4AeSYudJoHQvJX84Z7FYO2VXl6HS/daPLI?=
 =?iso-8859-1?Q?AS1hBrB5pRSDVxjwQyJY4FQJuhA02PyJmZN+LdiBfnIQ3IIBZy/+4Xwprz?=
 =?iso-8859-1?Q?2S3M=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707D51922431D12B42748B5F5490@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(2906002)(106356001)(110136005)(316002)(7736002)(486006)(50226002)(476003)(305945005)(6512007)(97736004)(4326008)(6436002)(3846002)(105586002)(25786009)(53936002)(86362001)(6116002)(2201001)(6486002)(14444005)(66066001)(14454004)(478600001)(256004)(71200400001)(4744005)(71190400001)(8936002)(26005)(8676002)(102836004)(36756003)(81156014)(11346002)(81166006)(2501003)(186003)(76176011)(68736007)(2616005)(6506007)(386003)(52116002)(5660300002)(446003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BP2cdbCMmbdHDZ2NQL9+oXGW/1YyXNozgaSNfjiTA3hx40JIkX0YMDnMEbVZi39ZyF7iYjAzNDhG4fHGXXUmazMftQ6t9sy0uyPDD589SAvnbvqNUMgNBN9uq83NQ1aPdO66EqFiKcFzxSeawggCgqg6YP0PF+PWswrbuH+eyR+lL8ldOYtejwA0XYTDw59xyzoxHK7qcb4JTLirfxDOzxZgqlcK6XJBlpc3PH05qOdyqv24s4aWomO4ZsYWzo3RNc8gsB8r1zFbCAeoMCk6AISbKuuhJJWn3AhPDWoNL2iVZHzyRW8M6CeXGfleiC6rQ2StaCBcTTPfZeqFsxVabGdjsxeSkoC6YBAv1XLi2ka146/CJs74j9sCg5ur5sctJtU5PwTCNeRPNEUQlufdcLhGSMvstq2uOFeJqNsUT4U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b443592-6a54-47de-2390-08d6a691d0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 02:24:12.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a MMDC module to control DDR, it reuses
i.MX6Q's MMDC module, add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
No changes.
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

