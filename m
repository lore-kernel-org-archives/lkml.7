Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F07C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD592133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CsPKtOdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfELJ50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 05:57:26 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:13798
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfELJ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eC9I5D+cAfU+szLh7+jf4PbPFgis6Ji0nPmqGtftYEo=;
 b=CsPKtOdYZIIUltrHeSnwdorRn7IS+H+fjM7mJwb3pUqCEJ2N8K67Oz0D//Sko/Opg/TPvihugPjCpjOUZZg1t8f77WqRWEpkd8y5LE+SPgJLYH/P1xhb/8o1th5l1QjhjqOnmGpt5eJ2WorTJJOwHaFsvt0RujMU/7j7/PiYxBA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 09:57:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 09:57:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 1/5] ARM: dts: imx6qdl-sabresd: Assign corresponding
 power supply for LDOs
Thread-Topic: [PATCH RESEND 1/5] ARM: dts: imx6qdl-sabresd: Assign
 corresponding power supply for LDOs
Thread-Index: AQHVCKkWIDCu1RGdv0ae984Hox6HCA==
Date:   Sun, 12 May 2019 09:57:20 +0000
Message-ID: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12916011-75ab-40d8-a110-08d6d6c03902
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899C158976575ED297C56E6F50E0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(66476007)(66556008)(25786009)(486006)(66446008)(8676002)(2616005)(476003)(73956011)(4326008)(14454004)(64756008)(8936002)(50226002)(66946007)(6512007)(53936002)(2201001)(7736002)(26005)(102836004)(71190400001)(86362001)(71200400001)(6506007)(478600001)(386003)(81166006)(81156014)(305945005)(316002)(2906002)(110136005)(6116002)(3846002)(66066001)(256004)(5660300002)(68736007)(36756003)(186003)(2501003)(99286004)(6436002)(52116002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TbqxxPr6YHOcKRtqJMXO2WjoXRVzpxEW0C0z+VoDWOJpUONUfpI651x+JyCJn3Ofy6OLGr1XXv4O+d8X+Vk7WTrsMVdAzmu3Dz80OqqPzcijG9woGIU9jNnIVwF4HEJFSCpcN7SE+NNxrg5veRtfmwS4P89q7evIhjUftwhf2RQbY1Ft/1via6vEAp+pEZTsddowG+zpdIILgqhupiXA6lKtJd3jZ3nRbfIDst4zbkMuAGVEeHwOldEHrIdQZgj9SfIz8iV37/8ToeFdL4VkvNHIXiQGt5JjT/jXjwyicjWbbSQC5R9YF/JoQNhpbGihdLrVzCt3zuVyvmrZLGZ19/FsBablQTbxHmtHt5rF1ML11FlH/ebvjd0MUm9KhLvv36s7kMbzEvSmHQ1ce1taZ63HTTYkzmJAK33M0SYFKUU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <32D5768BD4DE3F43A90899F857CA9E6C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12916011-75ab-40d8-a110-08d6d6c03902
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 09:57:20.2935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6Q/DL SabreSD board, vgen5 supplies vdd1p1/vdd2p5 LDO and
sw2 supplies vdd3p0 LDO, this patch assigns corresponding power
supply for vdd1p1/vdd2p5/vdd3p0 to avoid confusion by below log:

vdd1p1: supplied by regulator-dummy
vdd3p0: supplied by regulator-dummy
vdd2p5: supplied by regulator-dummy

With this patch, the power supply is more accurate:

vdd1p1: supplied by VGEN5
vdd3p0: supplied by SW2
vdd2p5: supplied by VGEN5

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No code change, just resend patch with correct encoding.
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi         |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 185fb17..11103a4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -745,6 +745,18 @@
        vin-supply =3D <&sw1c_reg>;
 };
=20
+&reg_vdd1p1 {
+	vin-supply =3D <&vgen5_reg>;
+};
+
+&reg_vdd3p0 {
+	vin-supply =3D <&sw2_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply =3D <&vgen5_reg>;
+};
+
 &snvs_poweroff {
 	status =3D "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index 664f7b5..929fc7d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -701,7 +701,7 @@
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
=20
-				regulator-1p1 {
+				reg_vdd1p1: regulator-1p1 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd1p1";
 					regulator-min-microvolt =3D <1000000>;
@@ -716,7 +716,7 @@
 					anatop-enable-bit =3D <0>;
 				};
=20
-				regulator-3p0 {
+				reg_vdd3p0: regulator-3p0 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd3p0";
 					regulator-min-microvolt =3D <2800000>;
@@ -731,7 +731,7 @@
 					anatop-enable-bit =3D <0>;
 				};
=20
-				regulator-2p5 {
+				reg_vdd2p5: regulator-2p5 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd2p5";
 					regulator-min-microvolt =3D <2250000>;
--=20
2.7.4

