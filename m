Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E772147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JZTD0mCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:50:49 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:21732
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbfCSGur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12B47s41r6WVMjNwY2Bys+/e8IDF2fW1ux+7yBvMVWs=;
 b=JZTD0mCAHZ1ghEfR+sHdP76HbsaFQcU1oRbRP1k+5/hoiEGtO3Yqe5vFr6HO7ftl8zvdoKgHCdWQT+T84HvmikKzw26gxCpZPu8BkzsGaGwX+7723qicqc+nNjK8kCEbzaCEhr3OZerHUVcth4h3IKRw6zhtZr4O94GtZUAb8r4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 06:50:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 06:50:35 +0000
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
Subject: [PATCH V6 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Topic: [PATCH V6 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHU3iAESFeFT5cbG0KV4gflOBwXRQ==
Date:   Tue, 19 Mar 2019 06:50:19 +0000
Message-ID: <1552977898-5590-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 144c9133-9fe7-43bd-9534-08d6ac372693
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB378829DFFD2DAB06DB56AF9FF5400@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(6506007)(50226002)(25786009)(8936002)(14454004)(26005)(76176011)(256004)(4744005)(386003)(4326008)(99286004)(110136005)(305945005)(8676002)(81166006)(68736007)(102836004)(446003)(81156014)(316002)(7416002)(7736002)(186003)(2501003)(105586002)(106356001)(6486002)(11346002)(97736004)(6436002)(2616005)(3846002)(486006)(2906002)(476003)(71200400001)(66066001)(52116002)(478600001)(5660300002)(6666004)(71190400001)(6116002)(2201001)(86362001)(36756003)(53936002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PT55T+lS4pcdajZjDruPUio4bTr9tuJWqRN1lN2PaaOZ8g86KHEw79AbYHfeguX+O7PwOIcfL/F3sispxpyNJAq5nHFl8H+DmdFSlgjlPgNuUIK9Fe4obpJn90yNmobE/QyeUAEAN26MkKgFMsgJil5JhvnCCiGbTO4UVvLs9Me5IaPV7VM06zYYxnKVfY22vzUW+TaezAo/i+LMBbEgwYbdkapmciRdHnuqn0X/IcDUUGNefoWZtqT9Kg6tkexilI5tb1WjCA9NzKOGeek3QusQ6qgtfpZcGUEAossYNP4StShAZAXm8Pkg9IEW57N8hhoFgNum0J1lPyCNAdNZaT5vOLCrhH9s+fPpXwNI1tO+9ltAx8wJL4kIdUbY9nRtpUKqqFGXXpEOgQ2ce37mWjNF8hmAYi1mah9FaM/8AzM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c9133-9fe7-43bd-9534-08d6ac372693
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 06:50:19.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
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

