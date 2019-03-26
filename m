Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8DC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5zyZnOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfCZGw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:52:57 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:36502
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730738AbfCZGw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZHwqa9wci6bGD4+NYfZnzn8uIavTg7e9CjM0N1N2UA=;
 b=W5zyZnOk26YZaHUIWhTMEZ6Upasexr1SLbHS/BSsapa8Oi0iA8cUjet6rM0oAQpSEHJpRttIMdrqQKAB4fh5bT6OeUM5+TOnnAGbNQYXaug2ke8lmFrr1nkgnpJB/VEw8u/uqTmVcWvLGXrmKyluy+dnznCOiIG5kzTU+8V5HxU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 06:52:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 06:52:51 +0000
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
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V10 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Topic: [PATCH V10 4/5] ARM: dts: imx7ulp: Add tpm pwm support
Thread-Index: AQHU46CHAPuBkFxjY0aAWAXvv5VYKw==
Date:   Tue, 26 Mar 2019 06:52:51 +0000
Message-ID: <1553582817-29519-5-git-send-email-Anson.Huang@nxp.com>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a00a5f2-ed5e-41d7-7a18-08d6b1b7a9e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB3675D77F1244A60280B023DAF55F0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(66066001)(486006)(105586002)(186003)(2616005)(68736007)(11346002)(446003)(2906002)(50226002)(6486002)(71190400001)(2501003)(6436002)(256004)(81166006)(8676002)(81156014)(97736004)(106356001)(476003)(14444005)(53936002)(71200400001)(26005)(6512007)(316002)(99286004)(4744005)(305945005)(6116002)(6506007)(25786009)(386003)(86362001)(2201001)(7736002)(52116002)(478600001)(76176011)(4326008)(14454004)(7416002)(5660300002)(102836004)(8936002)(3846002)(36756003)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7RqvOLbtHeKQWd0vlx39402YfCmzZ0zytFjVmPjhasgKq4T0TEpG0vDPyqaRN4gp1JER4fMStBNLSM0ef/wW9ndRRh1n3weUZ5DililoE7SqhPTPOVe8uVmsYnj7uVl+oCI2wLCFF9PkSTqFQcB11iwh7enDzCktlJY9FkcRpugCO0PUQAOIEZcJX+x5X0Wvc1EGbF6l+MR9QDDb7KYiZmNQl2M/8eiuFpDhFG9DLhPYs9m5rmjSXaZhoaXii/EAx6RULxMZXISYvK/Hje0WKUMIQ86gUtBbxlKmFZzYsm/LgjpymO9kw0oUqX/o2OC3o5NlHcHRbSzdB84BINhTTN8rGANrI6cqpOayw6EhuY/CUoGlpPKjS7eD82jgh61qUqrDoB9R2ddXeFkHvKzplyOiXuNV5Z4LfUaPB6dSkz0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a00a5f2-ed5e-41d7-7a18-08d6b1b7a9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 06:52:51.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP EVK board PWM support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V9:
	- update compatible name;
	- update node name and label;
---
 arch/arm/boot/dts/imx7ulp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index eb349fd..2ee893d 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -124,6 +124,16 @@
 			status =3D "disabled";
 		};
=20
+		tpm4: pwm@40250000 {
+			compatible =3D "fsl,imx7ulp-pwm";
+			reg =3D <0x40250000 0x1000>;
+			assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
+			clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM4>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		tpm5: tpm@40260000 {
 			compatible =3D "fsl,imx7ulp-tpm";
 			reg =3D <0x40260000 0x1000>;
--=20
2.7.4

