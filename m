Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743C92147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BajxlEvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCSGu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:50:58 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:21732
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfCSGux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp7VCvA7299O45IcomPYmegmh/PENzW/dackYQzSOag=;
 b=BajxlEvTG5nn8BKX+WTPbX8K/Dnts4Lm0sPee+FrwV8u81dtDJ/GF/PXRTD/AP6bMMDuf9lun/5/21b4HTPBUFdtN5OKkUYJ+pXnsZXPe3hpU6TF6mer+nqHxRA7uJibqx6Q1TmICaSpKryN00lncQUG1lAsgknN7yFqDkZCgus=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 06:50:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 06:50:36 +0000
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
Subject: [PATCH V6 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V6 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU3iAMiOS8d63V+UqZKwB9b+CcKw==
Date:   Tue, 19 Mar 2019 06:50:32 +0000
Message-ID: <1552977898-5590-6-git-send-email-Anson.Huang@nxp.com>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0082.apcprd03.prod.outlook.com
 (2603:1096:203:72::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b60d7f6-4d0b-485c-7459-08d6ac372e66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB378822895CAAC2458C511956F5400@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(6506007)(50226002)(25786009)(8936002)(14454004)(26005)(76176011)(256004)(4744005)(386003)(4326008)(99286004)(110136005)(305945005)(8676002)(81166006)(68736007)(102836004)(446003)(81156014)(316002)(7416002)(7736002)(186003)(2501003)(105586002)(106356001)(6486002)(11346002)(97736004)(6436002)(2616005)(3846002)(486006)(2906002)(476003)(71200400001)(66066001)(52116002)(478600001)(5660300002)(6666004)(71190400001)(6116002)(2201001)(86362001)(36756003)(53936002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b1d/H6efG0hgx2icnnMwzUIgzFuL2rhiCoMaQK705bLPOYdKCDBSoG/sk1ZfQODWMcrFVHjHTSuFvwUTbY0VXb06Hb6B4lyD0P6/n+gXfglVtfCNBMKjyDO/VX1kxsrSxi+Fqhe9Rsq3OvZD/FxAYwQTQ81rivJlCI/AYOe/U3NL+kH3HnxMObSKRzFWcNkLHL9hnPm+Nv9u5T2k4fxLoIGl5G6EKZ+l8ZdT4SCR1HiEqKqfkEuBKxMGT0Tm5WOfsa4pm1HTVfM1WpRxk6O3DojPTHNH9VYXXk8szWDZ0Tsvszf7EzS6P6RO0rGMui7Ng+2kKovnzfDUssV1dfgQC85wAQQcxUzCYiqXSxAVed1fq1Wu2LfdXypRB0NicsQoxkbCrThAE7cJ6X93mivdnmF7YxU3gjI9mBkxOY25v+k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b60d7f6-4d0b-485c-7459-08d6ac372e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 06:50:32.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V5:
	- change #pwm-cells to 3, add polarity settings.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index 3f5ea18..7c44ffa 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
=20
 #include "imx7ulp.dtsi"
+#include <dt-bindings/pwm/pwm.h>
=20
 / {
 	model =3D "NXP i.MX7ULP EVK";
@@ -22,6 +23,14 @@
 		reg =3D <0x60000000 0x40000000>;
 	};
=20
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&pwm0 1 50000 0>;
+		brightness-levels =3D <0 20 25 30 35 40 100>;
+		default-brightness-level =3D <6>;
+		status =3D "okay";
+	};
+
 	reg_vsd_3v3: regulator-vsd-3v3 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "VSD_3V3";
--=20
2.7.4

