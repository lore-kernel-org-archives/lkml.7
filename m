Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54582C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1714621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yc2dwkr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCOArE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:47:04 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:27465
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbfCOArC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12B47s41r6WVMjNwY2Bys+/e8IDF2fW1ux+7yBvMVWs=;
 b=Yc2dwkr6OBGdbkxgeJi/p23bL3TwH746nLtTXi9eTPSkenK3ka+WWtUavHoNGy+GEe/bnZiteWFVpJqQwjiimbfgt7Qnh7SG1TPdLGakPGU25v4+Yywfnt4cDOORDDSjGQmp6f2LoudH8E9MX/6TOypy+MS24qqJtAeUK5ZhB2c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Fri, 15 Mar 2019 00:46:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:46:57 +0000
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
Subject: [PATCH V4 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Topic: [PATCH V4 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHU2siXNveq16jIGEqOubfboS5ATQ==
Date:   Fri, 15 Mar 2019 00:46:57 +0000
Message-ID: <1552610505-13568-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 30a50802-bf8c-4d0f-ba05-08d6a8dfba31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3772;23:0MZIsMNGwjnIjUWOoD/Lfv5Abcj6LHiXqX1Qz?=
 =?iso-8859-1?Q?Mz8Mh8f1DXVJrmledc9ZAvOPxyA+bVIgp4vvd68Mz9tWsqKvXegY9J8zfN?=
 =?iso-8859-1?Q?3hJIH9FmAI4mLwFzXnHQxzc0j0RUN9ktp7cRPSUPPd+JFtm+ZjqfgnVvUb?=
 =?iso-8859-1?Q?Jkjv/4MwGw042eQKuFz2JdjlauUZ2f9MXhOobsCZyJ0GXKBDHZy0eBq1UW?=
 =?iso-8859-1?Q?tKpr3V1dJpCnHuN2eR+MK+s3kuVjtauAG+6JJ3rvmTD+BDJ5QiU/k+pzz1?=
 =?iso-8859-1?Q?5nu2zghdI5Ybke9xCJBQ2JTxP8AFKsC1gPVKbmcJojhiFKpjvbhvM1ThSF?=
 =?iso-8859-1?Q?PxfbzXDPnD7kLSr/680UKLvHjU7cvmOQmjQ9np1PqwHH04k2rOHUOUZvWT?=
 =?iso-8859-1?Q?VK2llwFuKv6YJ03n3ijTD/CSHfYUF6nbZB/Oo0giO+rT3VXIQEde3KRzOk?=
 =?iso-8859-1?Q?qYaivkV/x/xw6B0FWCtfX1+sbEhlcq9z/yHaCjYPdUHmgHB6cOYa5Csekj?=
 =?iso-8859-1?Q?w/Mwm5d2OLh/QXZmtCfsLCZDhBUnBFdJouoeG8WP58J8aG+2eLy1agkcsf?=
 =?iso-8859-1?Q?5odj9r8BI3C6nbb7IBlSFoM7RtToEI2nT/je6mAoGDRrs632ji7Kz/3N9B?=
 =?iso-8859-1?Q?ZtHl2Ie3Dc9Bwb0Gpd19q369m7/7Vr/yGIuWcwILKfemzpth3VRXq03wAA?=
 =?iso-8859-1?Q?9TgtzXvyj2c4xExUuNKA23c0PdVAIE/cgHGuLVaCx7lQTGlNPpqaX1x76l?=
 =?iso-8859-1?Q?5MRut54mV/9/uawJt0GCQyQKa7eQ2jwPMm32BECnGXBRaA+paExl63wtz4?=
 =?iso-8859-1?Q?AqDdHMpuz53uHIzEaJPMleh+zMRknBkUktxZKXKb6RA+bDEhCAulMfvwSd?=
 =?iso-8859-1?Q?8/gs5EGJbIcUfNv2xTULZzekRe28d5fabhLXa38SRRJ2/Cd8q3Ev8SAVr6?=
 =?iso-8859-1?Q?yebP3fpE3pc8RN/zkgMR11Yng1Ra6cqS4URAsSStmv24IJ1FkxI45TzKRV?=
 =?iso-8859-1?Q?kqjasq5NRHVR4udskxn7rXtHaJPtki4Me7rtCf/B9tWD9sft2+fs+fkhF/?=
 =?iso-8859-1?Q?/ga98KaITlrs4YIoffmlenGwDrQjEr/56c2dB4Fceyb9ixCBBQTjkzcw1c?=
 =?iso-8859-1?Q?lmgBq5d8ihOrOZhoO1mm/DiZ7WNr+zZZV1UTnN9QdF0uhVPAvBGG4zx1pL?=
 =?iso-8859-1?Q?ksbTV9pyYSN4EHOMRbyTX7LIPurmK3Ee9fJSXJ3EovDK/B0NGFtTxHeelz?=
 =?iso-8859-1?Q?otJpBXzZar+aHo5PUgzKKwGPtYJepYazppPFLjFTPZ68rdQrewcZ4ezo/Y?=
 =?iso-8859-1?Q?WfxJOnSN2d7XvzyK0O8bUxIJEyVM4ZcnWCj3p4iEu+VFwag=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3772A0F7FDCE17309EDAB14FF5440@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(2616005)(7416002)(66066001)(97736004)(186003)(6512007)(11346002)(446003)(2501003)(53936002)(76176011)(7736002)(2906002)(476003)(6346003)(305945005)(106356001)(68736007)(102836004)(81166006)(8676002)(81156014)(386003)(6506007)(105586002)(4744005)(52116002)(50226002)(316002)(6486002)(110136005)(486006)(36756003)(3846002)(5660300002)(478600001)(6436002)(6116002)(256004)(8936002)(4326008)(25786009)(14454004)(99286004)(71190400001)(86362001)(71200400001)(26005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gPJqjeQ1O8NU7JcuBIsdtUCc7DxQv+46axEuewNAbvdi6lXhiTWoiycvpuoXsdDXnUBebi9SYArD/aDLqu0xOxrnftgKjwLniPqUJiD1Oy7PG2t0hhmtonSXIQY/OZm8FsOPqPHRpKnTH6E2SWRjudUln6MY8YmeAwjwXKYTQnrxAIJaWqxX3B0Zj2ibcr//L7mtSulk4p1REOyDDIXn+CuJ0dk3qJrOCdP71nAFXz1NeeBS5ozw41hO4QRlKHnaJOHGL6+WlA7U/6iTWfXWFdsb1L+p8HWfj8y93eXDGtltbCV5VBmn+CdUm+GZvm5E1QOFWaMcKUrk8HBAM5BcjcZWM6Wom+zysSuagbdKDu+1aWW3CBgN/IjBzQqNyemRg4IR858x8UTaSGXHQOpW+PYIOJuYVRv3F5LeaLjpWEg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a50802-bf8c-4d0f-ba05-08d6a8dfba31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:46:57.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_PWM_IMX_TPM by default to support i.MX7ULP
TPM PWM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6=
_v7_defconfig
index 5586a50..57862c6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -399,6 +399,7 @@ CONFIG_MPL3115=3Dy
 CONFIG_PWM=3Dy
 CONFIG_PWM_FSL_FTM=3Dy
 CONFIG_PWM_IMX=3Dy
+CONFIG_PWM_IMX_TPM=3Dy
 CONFIG_NVMEM_IMX_OCOTP=3Dy
 CONFIG_NVMEM_VF610_OCOTP=3Dy
 CONFIG_TEE=3Dy
--=20
2.7.4

