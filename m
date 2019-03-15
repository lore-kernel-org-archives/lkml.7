Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD55C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C53821872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCnHoOqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCOAru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:47:50 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:16401
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbfCOArt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F16qKkq27PUkv2mytfwDOBCR6Hst18PTjrgxPcdplU=;
 b=GCnHoOqa12zMqMDp1CtIBcs0b7SL8RThdRt26k5aU0qKNFE3lfQMEdUQ5rLsi3Bhz1svVw/ISpS8WYnpwmBPXO8Our21/LVwL1Wq0DcNvLiYmQzbQ1To54548B+8gTzKI0kjrDUdpsg9nx0FnvdldMu8irFQruQweAs5jEvOlcg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Fri, 15 Mar 2019 00:47:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:47:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
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
Subject: [PATCH V4 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V4 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU2sifngGaSxbRp02UJpkSaqws+Q==
Date:   Fri, 15 Mar 2019 00:47:10 +0000
Message-ID: <1552610505-13568-6-git-send-email-Anson.Huang@nxp.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75373aa7-58c8-4d9e-50f0-08d6a8dfc1ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3772;23:WtQyllOVR7sLuqAXFxh88gOzTJLWMgBK7hTzh?=
 =?iso-8859-1?Q?3Tk4SAMZw27QcSX5yo6Do+EkGiJZnSAqrUWIRiq7n5MCd5rmhM8CnA5q3a?=
 =?iso-8859-1?Q?AAVogvggda2ewam3b+HAdR1W7epTQgy/pCEevmr//AB17Se0MwFXZzQYeN?=
 =?iso-8859-1?Q?LfgUI365buVHzYaHO8g+xTfh8IxHlcf+2lDqGGsnVucPv4N6mtYIUr1uRp?=
 =?iso-8859-1?Q?2SGlBtJWisurf+Xfk43z4aTY9MMtqsZaELUlQw3BE8WR+F03uZstIH9GxS?=
 =?iso-8859-1?Q?UWdkZyRb3L8M/FnPF4ZysEpnRtUycfbkLc26aH0w6/vX4CkT4301QD0ugq?=
 =?iso-8859-1?Q?58MRf40qanaPDTw7jpNYcUfeWR7VQHhtSaErsrrvPbWRuXD/05jRK/HgZT?=
 =?iso-8859-1?Q?YrhZmV1gD0O+pT7+rI/T7akPtkwmWLNIHW0SUA+sIwiBicGp9kFX1xEnJH?=
 =?iso-8859-1?Q?0q51OOAj9xiBAViweLEEqP74oFOb21j+YKXFCFEDa7za7Onf21UPWpwvD/?=
 =?iso-8859-1?Q?XOwimbzJahocjdSy2xKwgHUJuEfuCYHC2j1Oq2ha6wFzdBIkuPztWrN552?=
 =?iso-8859-1?Q?bZ39yaTINm6M83WCjN/npmM/RfHVGXE88m5B4iwpq5A7t0K7meBzLQGPPS?=
 =?iso-8859-1?Q?6pi/mOTppcZ/X0n/ME+d7xHAQBxj3mBZMKfXP+rFAU/Km3I9ap3psLFZMk?=
 =?iso-8859-1?Q?taTMesRoGIhTVAM8KugDxxWs9W2HYtYyVxg4N8NvfQ8PhWWZ2prMlGG20I?=
 =?iso-8859-1?Q?MHZNBJglpSLzwHAhFX9A9Vn+xdQ7g17j6UhbvOSPCHWs9yIo7FLIM3drpO?=
 =?iso-8859-1?Q?XftR3VtrV2AoV/uBPVwDqlN7ErPxn1h/lKzwvF6LMShDvBKi+VsTiABzMQ?=
 =?iso-8859-1?Q?v3ZKHnpFoq4A6JDSO5N5AhGuKB6XARe5cLmiKSpxuORUhF1Kta/CsZ+1qr?=
 =?iso-8859-1?Q?Q8eMNnpR10xFu6W5bGkxChHkk21e1iIvg7mYQ7t5jCwHFt+8bbfHUKXQQQ?=
 =?iso-8859-1?Q?0il9hk7Q+LyIrmZYKyJ/TBazaP+ufL43f/BCwCAkJYQ4p2e8VPj4AfvM4/?=
 =?iso-8859-1?Q?EKgYBfCVm0eU0T5e3mdGLCCRCb0gFWzXi2aVqbnK/zc+/VllVj1vo/C/ZN?=
 =?iso-8859-1?Q?edaY7/Uy2wZbSDlT36lonwLJxlkWSZ0BmRqGjgZ4k/wU32+s8T6BLSiQ4q?=
 =?iso-8859-1?Q?jK0eAW+ds0GJgw/nvu9kE5b0VDdlcsxLJiJD3p6s7wrXOxiASMsokxNLIw?=
 =?iso-8859-1?Q?AqfOSkGm3BW5Ff3dB7oHilx1gBVUaNS8rLRjkmq6fo1HOE2fA2ILZgWLjC?=
 =?iso-8859-1?Q?hdD6BL0/7kfpmHWk3jwDld0dqdILgTOMl2dFxOmhTYMhUhA=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37728FABE02DDCA74A4A7995F5440@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(2616005)(7416002)(66066001)(97736004)(186003)(6512007)(11346002)(446003)(2501003)(53936002)(76176011)(7736002)(2906002)(476003)(6346003)(305945005)(106356001)(68736007)(102836004)(81166006)(8676002)(81156014)(386003)(6506007)(105586002)(4744005)(52116002)(50226002)(316002)(6486002)(110136005)(486006)(36756003)(3846002)(5660300002)(478600001)(6436002)(6116002)(256004)(8936002)(4326008)(25786009)(14454004)(99286004)(71190400001)(86362001)(71200400001)(26005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZVDedJHfRGcsAzIOtrIKNeD44RZgpxS8Rydm75iN9WNvTjjOcIW92UKOZrHGTOWXjOtWa0yNNRqzOXkhvc7aLL1AamVN/1k9guxz5SIcEuRe3FS8+CMj0r+qq+QZYCVhxIAZd0SZ8S/6o7liEY18QjBPgN/d+OKPRAZxO+6ipG+5PHievZ6nnv/ogiP148qavg13qtl2zyFbi+v7UfwtCXg3DFlnGnNDVedpqfAnNDZhOTL48gbeuXtOh482r608YLjS/zOUK/RZZI02gFtKy4qeSVbn4nutCO3wLlALAxE5AYV4zBbSg6GQCGXVhM0q9qFSTWpGsykuQvMCGM3mxicnQOAL4KvdkT4dRmwuG+O5WEjIrNITEaqdkAzdnTKx529fHLf7so38mMOom84uwWzA8B6Ta9CnLEAdJAJvDk0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75373aa7-58c8-4d9e-50f0-08d6a8dfc1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:47:10.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
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

