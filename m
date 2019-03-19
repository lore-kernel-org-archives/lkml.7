Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C26E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DCkHyQci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSHKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:10:20 -0400
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:34116
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727274AbfCSHKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12B47s41r6WVMjNwY2Bys+/e8IDF2fW1ux+7yBvMVWs=;
 b=DCkHyQciplSbVEl/CoQB6WW6gsutMYCOadBGNL5DLM92+w5/aMeoKX1LByc5H+N+hjAABkA1sbPT4LvEOwYA8ikZXKbNDelB8wZAIjR4mGcZ5F5790L4kVPlWMPsyeaBb7sFcYHC044RXpaTov3NYJ6ZUuiJC0p4RYuY6zO7+tA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3884.eurprd04.prod.outlook.com (52.134.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 07:10:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 07:10:15 +0000
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
Subject: [PATCH RESEND V6 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support
 by default
Thread-Topic: [PATCH RESEND V6 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM
 support by default
Thread-Index: AQHU3iLNBitcEBT3h0+kGT3ni0XWDA==
Date:   Tue, 19 Mar 2019 07:10:15 +0000
Message-ID: <1552979097-5814-4-git-send-email-Anson.Huang@nxp.com>
References: <1552979097-5814-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552979097-5814-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e885119e-3579-41ac-6405-08d6ac39ef44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3884;
x-ms-traffictypediagnostic: DB3PR0402MB3884:
x-microsoft-antispam-prvs: <DB3PR0402MB3884A500B7D164AF12775D5DF5400@DB3PR0402MB3884.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(86362001)(25786009)(7736002)(305945005)(7416002)(4326008)(50226002)(256004)(14454004)(102836004)(110136005)(2201001)(8936002)(316002)(11346002)(476003)(2616005)(2501003)(446003)(99286004)(478600001)(97736004)(81156014)(81166006)(6512007)(53936002)(186003)(8676002)(2906002)(68736007)(71190400001)(71200400001)(6116002)(3846002)(66066001)(76176011)(52116002)(36756003)(6506007)(386003)(6436002)(26005)(106356001)(5660300002)(105586002)(486006)(4744005)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3884;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4z8u+JjNTD4hhSJ3QFxQas/CEaRXCl95Jzu7k0X5LuQ6H27+4AkUzPogmxXOU70ExhvJGfQrA51ImY4dYtHOiDW69/Zr5FnEg37+8cniyff5V2r/36j2OfijM7Tm8QyEUMaX/MZ/FYBP9QeBRluCytHRGK8DPVuAFnmznGU3qw3GL57f+wPEyZLWm2vDe1JQUhGrxP/UTbqjBNH4MvYSB69nNJX3tD77Oag8J5xWCwu5wXorecTnujkyeEgFxHaDDlDKdU+6Yn8rGpn4wb7tYXaXA/uIS2nLxfRYN6Xf0J1XBZcg0+FwTiwGBoYvkSIQq3rWvFoPkhMi/eS+pHrH7W4KassjWwn+uzHMf4+ahcFIyDtmMvNNZli47YtZISgyn4r15iF1CqB9m6PXjm1mwaAHQ/n6gM1S93qNIZN57kg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e885119e-3579-41ac-6405-08d6ac39ef44
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 07:10:15.1347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3884
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

