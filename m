Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A95C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654D22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="V9MAzuXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCEL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:26:56 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:53245 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfCEL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:26:54 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="24834064"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 04:26:44 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 04:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myVXLw/9ASojCdyCf1IEv/Hrqc/HX0WSddPg/0VW97M=;
 b=V9MAzuXKLfDFgniQY/5QxIj+1TGXCwvIAywqs1i3W3IL1ocZtsV6xmppkR2oMd0QElquEh0DuU0H/zTOwuTbGheQ95vQVgKJ0wOfTycNpmIlg1QMHSt9zuOl6RyQO9Se+0dYfWa47YxHiKInH8m5xwn1cc//xZKgZ71DVTVkPnM=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1382.namprd11.prod.outlook.com (10.173.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 11:26:42 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1665.019; Tue, 5 Mar 2019
 11:26:42 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Cristian.Birsan@microchip.com>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S
 Multi-Channel Controller
Thread-Topic: [PATCH 1/2] ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for
 I2S Multi-Channel Controller
Thread-Index: AQHU00ZO5cHGuq9xqkyVRhygPbt4Vw==
Date:   Tue, 5 Mar 2019 11:26:42 +0000
Message-ID: <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0072.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::16) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb3ab6a8-160e-4ef0-bd96-08d6a15d7113
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1382;
x-ms-traffictypediagnostic: CY4PR11MB1382:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1382;23:0wqXiwD354e2EqgqU9U7WFD0yCn1nv1g7tRsGXd?=
 =?iso-8859-1?Q?J+0Uqre1WHeo+oVrupBfIFMuENn1YuSQ6Ff6TwtIHJmgroYMNKF9mDe6jo?=
 =?iso-8859-1?Q?nUEXK/T8UpTueCewzrNzOmvCF0WjAvTjuUCwgFtFCHzJq6ZrSrOFjx8Ld0?=
 =?iso-8859-1?Q?j17s9vZ0iG3EaJ+a0ah+5IijGAT7jDSf9gNwGdmilfpzGNyaWEidhHTFFv?=
 =?iso-8859-1?Q?LTtoW3KdMy4TrZYt1V2kaYJy/j8zqA76Dr9VdWBBe2pDHepZGuSx8leOLY?=
 =?iso-8859-1?Q?jvtWHhKa/udvnBLmO9ICvaEIbW45ePzk3QuZ+NH4k2AINcqZz/TsZGqi9Y?=
 =?iso-8859-1?Q?hvQQAWq/X8rcpyE1F3zvSOJ+dKDECQEAc1JY54c5J06ixkJ7LQLGu5Ptxn?=
 =?iso-8859-1?Q?2YpbDrU1qbjxdnb21wzfTXNC9Xs4NwYF6HDvvArdaO9QCddf5nivJZscF4?=
 =?iso-8859-1?Q?yE/rg+4xmVd6e4+JBXpKS3plwLy3i00DjDIduDKg8qRn2FLRekvrvwmzjj?=
 =?iso-8859-1?Q?gNXi/1UtepBHi+qdnw14aSdc6umHmdFjfTNU1w8Ay8fbOjcjyF2SIhomWI?=
 =?iso-8859-1?Q?ymlxrBc2tgztkFosR5prtyPQpReV/Wj02BRGjKMFKWwb36pa5hcyRLTypC?=
 =?iso-8859-1?Q?oJ9z4DTUjhJBtbFnoRKLPqmQVwbSNyFhRLBjfLYcYBinOpvJ/DSgbh85si?=
 =?iso-8859-1?Q?2bBDf0Yc/U7+5vgC8SwUe+YnJ3reQsULn40MBW/DHIxAmoM3BV1P0Pz87T?=
 =?iso-8859-1?Q?7DGUhdlSFaPXuYDHHfKB81kaxVnhJQNCGQSVZJmP2a5UA6+xsdKeGQIMqd?=
 =?iso-8859-1?Q?bJS4i48zXYBRjbqCGcu9Qg2Mp0GRKGOk3RlK8Up8whYqXB11RTFdNBtNDl?=
 =?iso-8859-1?Q?ZXqP1HW8GOum4cHaahbDhPk7SPkkJSgrp1AUeq/5nALZFnOULLB39O2rAW?=
 =?iso-8859-1?Q?WSPLpCz0bcnBTzUl1p36TTa/lTZyEfjfPUGmxzhhvpcqOPTZYveGpggreC?=
 =?iso-8859-1?Q?O/bdVlbGaS38wauVgA+prD5JuaajktVEzOnEm+iZUpnmJ/hcmhlWtttWzS?=
 =?iso-8859-1?Q?v7qk4CDntjSxAOd2mCnrbroWA0tbcjzwsAhGoXU+K6S8t3uc+6KKt2GXL2?=
 =?iso-8859-1?Q?QBK7YENTlDAWzqpLnVetxfLAfUJnX5zVmZJ7Pl8yHwjdaz48/uPjcMozD6?=
 =?iso-8859-1?Q?WVT4rVEixG9jQ1SxihbJd4CeJVcfcvwKE0hyYvGkhNLtelrpaQ7zzjGPFn?=
 =?iso-8859-1?Q?BFUxS8xQq8QTn7QPO/ryZnMBLMjFum4q2nZmgTcAU3gcVzTzIR9AIhXXeE?=
 =?iso-8859-1?Q?Nc=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB13829F230B71D694BBEAB0BEE7720@CY4PR11MB1382.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(2616005)(81156014)(5660300002)(6436002)(256004)(110136005)(86362001)(107886003)(386003)(486006)(186003)(50226002)(66066001)(25786009)(476003)(102836004)(6506007)(2201001)(68736007)(4326008)(54906003)(1076003)(99286004)(26005)(316002)(52116002)(14444005)(81166006)(72206003)(8676002)(6486002)(53936002)(6512007)(8936002)(97736004)(71190400001)(305945005)(7736002)(478600001)(2501003)(106356001)(105586002)(36756003)(6116002)(14454004)(3846002)(71200400001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1382;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S92wkejXv3SLp4E/nR3vW6SHSYh2reijL0r8jYkAm+bg6QpjAJMogEvbn61/+xtcWj+N7T5/9iaIkdvvcpJEV0DJxZ3qC+/ybFHfLwKVM/4eQgBJdi1IwtayOJrydTsb9/gxNPdW2z+AqmbB5lqCr/1Y2zC7FcRbywQ1zKLcZuJVabfqgeElZiIknFNANg/a6V0vBkseXDjh5DYUBiK/vhA9jiO8eJe4HXI5TfQIlYVWj9E0kiRQY8pdVUPjAV1bX44UEg/RN3Aa6E+VfQbukZM5U/4fz7ixX2ZWcHUjKW3d/S6NMB/qb3AJE80nYGs6mkrdr2Sg6+/eaqgiAMnnset6ihAsBA9MwsrwTpp3lqQCJaILoo4IKeRsHbtULUnGpQHLLrCBNeNudQsl5yh5/ljyIYNAYSxIqmmsFWLttJ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3ab6a8-160e-4ef0-bd96-08d6a15d7113
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 11:26:42.4516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1382
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

This patch adds DT bindings for the new Microchip I2S Multi-Channel
controller embedded inside sam9x60 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.tx=
t

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Doc=
umentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
new file mode 100644
index 000000000000..91ec83a6faed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -0,0 +1,43 @@
+* Microchip I2S Multi-Channel Controller
+
+Required properties:
+- compatible:     Should be "microchip,sam9x60-i2smcc".
+- reg:            Should be the physical base address of the controller an=
d the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be one per channel name listed in the dma-names p=
roperty,
+                  as described in atmel-dma.txt and dma.txt files.
+- dma-names:      Identifier string for each DMA request line in the dmas =
property.
+		  Two dmas have to be defined, "tx" and "rx".
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles=
 list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controll=
er.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock is option=
al
+      and should be set mostly when Master Mode is required.
+
+Example:
+
+	i2s@f001c000 {
+		compatible =3D "microchip,sam9x60-i2smcc";
+		reg =3D <0xf001c000 0x100>;
+		interrupts =3D <34 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas =3D <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(36))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(37))>;
+		dma-names =3D "tx", "rx";
+		clocks =3D <&i2s_clk>, <&i2s_gclk>;
+		clock-names =3D "pclk", "gclk";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_i2s_default>;
+	};
--=20
2.17.1

