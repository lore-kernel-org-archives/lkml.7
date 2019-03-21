Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC599218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eNuFXU10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCUAr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:47:56 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:25504
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfCUArz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7bljD9lZ4mC6RRtcbDDnwWpJtn6NgXSS9PeBDD/6xM=;
 b=eNuFXU10C0MCtXqANx8MrjX5qVikinoc9lHVnC7UrwlAZ4FE1IYTAMq8EoXArIPEy4JPnyC2/Pq0wMno+OprTIPeydB4VY35BEbGWjLdtRq1N/ZZvJbCd8biZpdOcxgW7fkcfkrIPBOwgTtZWL3QrMfKx/22labIgTyCgIXdebg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 00:47:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 00:47:51 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V8 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V8 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU33+2twaJC+64skCGXSGjTeALwA==
Date:   Thu, 21 Mar 2019 00:47:51 +0000
Message-ID: <1553128960-17923-2-git-send-email-Anson.Huang@nxp.com>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:203:72::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eb53297-58c4-4777-c755-08d6ad96d87d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-antispam-prvs: <DB3PR0402MB373843D6E57436DF16E4BA70F5420@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(11346002)(53936002)(2616005)(71200400001)(486006)(3846002)(478600001)(476003)(6486002)(8936002)(6116002)(446003)(36756003)(66066001)(25786009)(102836004)(14454004)(26005)(7736002)(110136005)(186003)(99286004)(6436002)(7416002)(81156014)(4326008)(76176011)(81166006)(305945005)(6512007)(97736004)(2201001)(105586002)(386003)(256004)(50226002)(2501003)(68736007)(6506007)(8676002)(86362001)(316002)(5660300002)(52116002)(106356001)(71190400001)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q20W06kBPcEtV4VDttB3pFxsTs1d4vA4EpUvUPCPzY1VxmG0HlI1Yk1OwLYxd5GsFp5RhG7UEQRo1GOFhP03Sb3Pidmboy93zfyRdijwrUfx0ylN2FCcSpBlwfFMvTMXi6jC5NqpUlTwH5p+K/QBgrIYAZFbd96ETwDeZ2Z10GTNzYinhHDzzAWJlmRaJcBCC+nknmofxoZp6oBPeXGl/35t6ZV9Ts05OYA/5BRLPTbhAWvil9Z4yNPF7ewa2Fg4yAcz43VdUAy4EoXUrTukgsZJ8sqXZhs4S/XVMlU6zc+9lQW6JPb6JpM6Q5wMdOE0N/NTR02tvoCTEqw2ykHdcuP1ZrQnQfyy/oIv3ABxSKdAleXsKZ/zrWAF0TDjfBi7n9vd/PZcnwQ6xUi7oq1jnEUF9WJRwXLosLuO571olr0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb53297-58c4-4777-c755-08d6ad96d87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 00:47:51.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
---
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++=
++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..94f1ad5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,22 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx-tpm".
+- reg: Physical base address and length of the controller's registers.
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description=
 of the cells format.
+- clocks : The clock provided by the SoC to drive the PWM.
+- interrupts: The interrupt for the PWM controller.
+
+Note: The TPM counter and period counter are shared between multiple chann=
els, so all channels
+should use same period setting.
+
+Example:
+
+pwm0: tpm@40250000 {
+	compatible =3D "fsl,imx-tpm";
+	reg =3D <0x40250000 0x1000>;
+	assigned-clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <3>;
+};
--=20
2.7.4

