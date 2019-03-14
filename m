Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB9EC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749B6218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RzjQcC9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfCNG2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:28:19 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:6118
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfCNG2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FauWeT+tV23UZQ744308vYRnA1pOsFH79oFYp7lwyU=;
 b=RzjQcC9KkmtthEga0TBzoioLpnW6Pig1eAl8XZ8aXoMl6S+qE+PpLr4/WHV4QpaXQl/Wmxt5XWL4bia55qm8TvZ5bslsjeYCrD+cEsYUrXnzP+c2D48hrQNprmYLWIEXU8yMxPw+GU17KlaGcg5q9ekqJ/b8O9SsnjRYpI4Gfn8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:39 +0000
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
Subject: [PATCH V3 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V3 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU2i8FmItWdww/9kWb4S5OVGCesA==
Date:   Thu, 14 Mar 2019 06:27:39 +0000
Message-ID: <1552544534-5295-6-git-send-email-Anson.Huang@nxp.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72ced3ac-3d55-4ceb-99aa-08d6a84627a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:AqGSnj4RBx6O1UdLAgprU3cbm8mnnUqZX+fb9?=
 =?iso-8859-1?Q?nnH/Q28ttH+lRrcjiT5CSh0s4i4D3hrTpCIcarwlTjyHqm+jbcrWuFjzEI?=
 =?iso-8859-1?Q?x4lk7eE/HW6cO7wy6QWCKKOh15ZMs3WZURYwVrIfdADFMUi09K79sTzLW2?=
 =?iso-8859-1?Q?nB5xGSsaIw5QKot4qv2iuMZGtYZPWuiIcLxEhO5qZLF4ebsanzb9cjfXGo?=
 =?iso-8859-1?Q?XAqHKudMAoAwbgABpqt1XhYjShCiWRaMsvE60h0B8YO0iWw1mriFg11pKC?=
 =?iso-8859-1?Q?fqvcSwoyewQhZSh9Cjbz6pCjaFg0nie7TojQeXqkMML9+tkdHZ2Mgm6r3W?=
 =?iso-8859-1?Q?L0N15CYH4JMI+MoC5tR4OoYO6YinWqc7SqQHuE/+G01RLrLjY7Ey1boJa5?=
 =?iso-8859-1?Q?xsGIszRi0doL3Dx8En2jl2fjYdwkQU/YOZnbI2YYcePOGHYuOPjQAWmq0L?=
 =?iso-8859-1?Q?A84gtnOCdNCZFWohh3z6UXOMMoprixp5c/ETsbqr0HBHtZnQCxJ1VGaVc0?=
 =?iso-8859-1?Q?jhVlCZmnpaxtVlj4pcM+h1Rhch+42FG6GwvZ+2N1Qj0sL33iArjlqy0Vdn?=
 =?iso-8859-1?Q?iXjDd6MqqjR30AQ5IneX0LosZutxM9mixP4USrthqp5pqBkv6ZyrnQoiQQ?=
 =?iso-8859-1?Q?loB1Yw+9CIPH3aErUXU/NxbFI9R2SCA3WCrsJlBeRqGy630BltAEAAZ65d?=
 =?iso-8859-1?Q?mopZi74g81JRPgMlfqwyYM+GvFwlNrYjrJoTj8er+r5r+I7zsVNO2JkbzV?=
 =?iso-8859-1?Q?HXFaDc2o71zyHvjlB5ko3ThXe/Fwsz5BG+J69jdZirv7VZ7AFQJzqhio0f?=
 =?iso-8859-1?Q?lWwCNJ8VH8adpt4+kn61m/AYuXfq5UCZ+Mm0b+I+9U4Is5i5BfZVohvx7Q?=
 =?iso-8859-1?Q?7j7mNUKH+XcEe4Nhe51qhVYs8C+hOPRw9jGv+79ZN9wcT6EiPfqxCk2FlV?=
 =?iso-8859-1?Q?gSJSuUAKAalvqjIFJCfoNM1O+c2ZdwEcweYzOMRbJX41Zune8Q1hKkjWQY?=
 =?iso-8859-1?Q?8lkwvu0EQaWseRVq3aLFpi+9iP0K2hdbUsNzPbicsnMNInwK+yT9jmbisa?=
 =?iso-8859-1?Q?uyy3yhq/MnQy7wjZJqiPPwMzcbuc7185GKP3dv7Ri6FeZeDecud9obp7yE?=
 =?iso-8859-1?Q?MHbW6Ra3KBMW4KFTSzbu9CMNIGs/U+5zhpr5sfiWKEfq7xukPIB2LnTPnO?=
 =?iso-8859-1?Q?YyQZBNxBKSe1SD9MmLByiAyz+p8idm6spyaVyNEgGaEERhzzhwjudgwHo1?=
 =?iso-8859-1?Q?s/Ghb0STd++Mr7DeXAvgbnl3Kjgry4dS9bYeoVqkppq3L6cyZNk8+KNjwy?=
 =?iso-8859-1?Q?B8O3Gimx6OuuTGyy9F8djC/BP?=
x-microsoft-antispam-prvs: <DB3PR0402MB37070958D8A16FE1B9C9D18AF54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(4744005)(8676002)(102836004)(386003)(446003)(81166006)(11346002)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MC0Bdtn1HR8KHGbR0bW0EgsFZH2k2Lvzf7TH/9snnHlcU3wghF9BG0AxnsxwOXnYvLU1Z3SN/7nkHbxj7/IxkFCx+GhVnDkW8xsxnYMxiDIVsr+ngyeWkMKRL981bYHd8eSGI4s+RslqH0uz45SREWOpg+rhcqimpZ22xXX0liksXnz0/kACE1LR+vVKibbaKNk4oaf4KxXr7gaJx2uuH6Wzv4iWLjK8S+c3147Vgt/GhmbFsS6iE7SyQo5QkCs4aSSp9okKvJO0+SM9CKaJ3hNGl6oHwZUqwsm/IGoU2xhLOuZ+2kCrNVT7QTTIf0I1u/xnTLz2TdR+MoeGLmRQy8O64fv9HAtsEYSInEeoJEU6l60tpxQsTuoGt9o+A0Z7jMXfo8/sQJZNL8fChYjFeFC+5HGtD78EqLdoprQpD00=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ced3ac-3d55-4ceb-99aa-08d6a84627a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:39.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index 3f5ea18..f90f2f3 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -22,6 +22,14 @@
 		reg =3D <0x60000000 0x40000000>;
 	};
=20
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&pwm0 1 50000>;
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

