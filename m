Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9760FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A725206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SXtErhEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCKHRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:17:15 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:53313
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfCKHRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUAq3WQ66ErTWwcJmRKrT+poDi4bUoGNapPM+AjpM20=;
 b=SXtErhECQo01exCJtANCg70U9Qz68btHxsI33kLL285lkuKbUiFVIX9dHCFANtGMfbqmmQ8bA5jh6Wf40ssw55knd0uw6vLgj8yTt9+lw2+rL52y6y1N+AlkpG3nIMOlyCtb9vstcnn5BoZMTcaqcRGXQ6XqzPcmHSFPYr5cwmY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 07:16:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:56 +0000
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
Subject: [PATCH 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU19pdorqa8Sk1YE6WpQPvp2fT6Q==
Date:   Mon, 11 Mar 2019 07:16:37 +0000
Message-ID: <1552288273-31028-6-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 17d5d829-efd5-41d2-3d0a-08d6a5f17fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3724;23:S6vN3io0doOPuw7uWMiF1B8d40fKV6S5jkwXS?=
 =?iso-8859-1?Q?X2Nq9KHZ4sw9maWKDo7O4qN1GNj374oTJmww5VJHPVmcE2u4Luk8kXWeRL?=
 =?iso-8859-1?Q?9htWboElOpzMLLMp1IRsvBI0hwxKOcwQ8KXNa6V53LNexoopfbsd0jRoho?=
 =?iso-8859-1?Q?ANd/WPBCnhYzezjQXaqzoIjxh6eloNH5FOFPCnMAl8xlGjHr/ahFtLCeyT?=
 =?iso-8859-1?Q?iRZmWIomlIGf3EgKI9e1Y1aqip0alTgYp07MhqPueEh6tgiNCUKo6u9srm?=
 =?iso-8859-1?Q?LsAQpdubSuPtcYdGQQBIQObFS7Gp4i0CA5SqcDhLVN9NlSnOZv6kBnrmZc?=
 =?iso-8859-1?Q?8vxW/jFiLxfkVtWzy+2tJ/pfqkacFKkgokguqjieJlEOicRPHgEc8kjRT0?=
 =?iso-8859-1?Q?bHD1pZxpfrul+0ldDARSfGcHONj5QAvD7+jnQie6/Vis78NSKF5C+ym7af?=
 =?iso-8859-1?Q?4Vgf2pLW6W2H2vyOe+58F8J0UtL6esVlMPDqE5bz5Admy8HQC1MfNG19yr?=
 =?iso-8859-1?Q?aaYdsY4KU+rKaMyCik54SQLAiW8feFfEO8Smoj6MxQwEcQgRJg8iFSGSYR?=
 =?iso-8859-1?Q?M8Ses1Y2FeY3rgwkdA1UyYtQZvy/SR2c/5s6lPHVCqGUla5WC0qpH1rOjm?=
 =?iso-8859-1?Q?rA6N5rUf/Lgp8gZV6NdKaLXM2KBAU/JE4u6yvI7pvkl7Ql3WlRnnzvegrb?=
 =?iso-8859-1?Q?3tcZLDtzyf5jSgmUjJS6aqXO1WOsSFEyYtl2RNKGkbFimFfqgDTmlqwbtY?=
 =?iso-8859-1?Q?oZJCpnOk+8N6GHqvGNZFWl1Jwq5GOma82kJWfCy/kDP0ZYENipeUnab1tm?=
 =?iso-8859-1?Q?wnG6VbWV2e7cWRipbnDTD787kEYhUf3tNDlek3Cdsowa0MY2onLXp/EqWr?=
 =?iso-8859-1?Q?BcjbGn0rquRXLrwiW+2hbqLAOETad0JGdL6tPvZCWVfd3d8YEr1h0dvYuN?=
 =?iso-8859-1?Q?GOfjnRykPP6GH3PG6y0GPR/rAOCBp5/WNq6N3xIge0kLgsJv0f43M3GujQ?=
 =?iso-8859-1?Q?0JnIw2Pi3NPIVK8EQ1MLFVZHQPHIrmXiISSQ+FErvs+4jtr/6srSEZJlXH?=
 =?iso-8859-1?Q?nxWow7+h6G1nBGYwq0beHj63NEWll1hxNARqf6zfugM2TUjictIqQGjvKt?=
 =?iso-8859-1?Q?5s1nmoU2NwKehsoTfHtOeY0u1qIwvAi5PH6TBtexoUb27W+d2jK3fS+rMG?=
 =?iso-8859-1?Q?kf6+bbi5y1brKArgdwYF/+xCrRsKl89h+6JlukPvPCdGxqhSowGNAUgL21?=
 =?iso-8859-1?Q?OhPSfoVluTSgqSzzJQYDvSlkkU5ve4f6APK99tYOZ4lLqmpe58tcyuj7yw?=
 =?iso-8859-1?Q?sIdxquSaxtypHtpHp0qgdEUdgNWvIWAAea/9CzxDT150hOQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3724EA78170FA9699B061035F5480@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(105586002)(6512007)(6486002)(2501003)(6436002)(97736004)(446003)(110136005)(2616005)(81166006)(81156014)(8676002)(11346002)(106356001)(478600001)(6116002)(3846002)(4326008)(25786009)(486006)(476003)(2906002)(305945005)(316002)(7736002)(102836004)(7416002)(14454004)(52116002)(256004)(6666004)(8936002)(66066001)(186003)(6506007)(386003)(71200400001)(99286004)(5660300002)(71190400001)(86362001)(76176011)(4744005)(26005)(53936002)(68736007)(50226002)(36756003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 44g6VKLRyjGSQ65TCSDp/AI+sb57tSemafFRgKMDHLTcewqFbnqVtGIIQzehJ4s8La0/G43QGfFj9YjNJ3zn9gLfGMIuRdXL3WU4xuWZApOK5qgLC/WcKFBBOhHPpv4DxXXwFx1HN2283V0fn3RqfrNH2l2K3ofWTP/WIWoEu77ceropkLG7eVDxwUB3TVS9w9svF+wL/ji+MWZxmJTdr+rIBvgrr6x49R40rZMCjq0Z2dKPk77MNjw2XIhJR0Bi3gb51mxebWSZ5lAQrcN34+c5KZC4y0mlKBuV7DplJlxjWHOH2tda3adiBtkgrV/o7mi9k+GtffFBq2+d+QpXmsM4kwkp4rE7My3+v5JGm5I74D8MwDRqN3rVcYeOpe4DN1Je3fc9W5qIx0VNJNR3g4/bU6Fr3xt5c9I+lmC9tU0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d5d829-efd5-41d2-3d0a-08d6a5f17fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:37.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index 002b0c5..f5b9828 100644
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

