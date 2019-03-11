Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA139206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tdGsuNYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCKHRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:17:08 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:53313
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfCKHRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odki9Frc0DwnU/rq1sLu4a5ByLSfihvbXXJQiHs+qXk=;
 b=tdGsuNYGKX4p1Wxun8HyepKDdlpmvRInqmIDBiW+a7EVB41HBAOJVNBgmFdLZdsuW0ukhEMOiccFGaXFUABotROHrfN0rYBgjw77XOIA2/HKCBXp7PsFkDgymiW+tBcOLL9aOdw/58yPprRTmNWAyEhj/lrVYDvEhR5IPQayVWM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 07:16:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:54 +0000
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
Subject: [PATCH 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
Thread-Topic: [PATCH 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHU19pVDtRnQ8LdMEGOzIyB1Z+udw==
Date:   Mon, 11 Mar 2019 07:16:23 +0000
Message-ID: <1552288273-31028-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 9985b908-6aa6-4f1d-9241-08d6a5f1779d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3724;23:z4mMUcFRQyRK4h1UPgaoXm5yR+cfLmVpLNUOA?=
 =?iso-8859-1?Q?VAheCxyLWDMd90OK+gJu+GgV5sW6IhgxM0WFks4Kse8geg4pBX5Hc6HmwH?=
 =?iso-8859-1?Q?RqzpRqv/gaFepNiTI81aI3Un4ujJWbWt08/pUwoaTgDJ7SozF8UEKWpVoN?=
 =?iso-8859-1?Q?Fevu+jmIRhcbqh8R/wtO026rSI+1yaOuEfaeoXC/zLntjz53jZHwH8aPcc?=
 =?iso-8859-1?Q?p55KRMpXXIq3ytZxs5Jn68DqrO0f/p9Hc+u+/lOKuMQeKK/sx4IagoSdUo?=
 =?iso-8859-1?Q?0u/pj5WKomD1HiYu8ojvsP1/5B6fAh3KRSfb0962iDb/ROpguvwVBSbACk?=
 =?iso-8859-1?Q?lXqdvLjzOAzVe8M0exJInyoyeUrxPDHV95EG/esf7kcUQI0so6/Uk4kxvo?=
 =?iso-8859-1?Q?x1HTTQ6isZckHZEce9i/RFNnPI3LF5aPrdmG5i+xg8TA6OXl69zfAvTbAh?=
 =?iso-8859-1?Q?t3oruZh/+Hok9E1QX+gfLv8JEp6EDKPZ5nzAz6SHIBAIzY43EAm9MMsRqH?=
 =?iso-8859-1?Q?64wjrqiRDLRitEfT3JNTmRNLrFNGKlbhNAxf8J+KEZgBjvrV0c0Os+DrJj?=
 =?iso-8859-1?Q?zlomA02eEcVmYWj31jLHPYlAVKcqQ3cpW9mywrmKEnQtng/oDgVUefqoci?=
 =?iso-8859-1?Q?bwexEriP3NnSkzaaWAsKOFfZ3QS4f+qmVAKPxUE8eOtO/Rp49c3z+A1LZd?=
 =?iso-8859-1?Q?+VSVrMsbiYvHVKglO8lQc91PYL3dH+fbOEnKhsCcm1vanyGUg8RPzeWO+/?=
 =?iso-8859-1?Q?lqK/doq27H72LbviX7V1w0eYcWrQwM0YZvZkqFexIB76xEGBxh+D6TU9NO?=
 =?iso-8859-1?Q?utq7dE2Nvxe5U4KKPUorzPMKELwgJSW39dMZc7Cx2IF/8drUg/zy36z3BG?=
 =?iso-8859-1?Q?n48L1CFIHfOgxDdbIuwhWig1ZUgdKnD8qwvkwiZYYGlFuLUGHXyR6rjkPG?=
 =?iso-8859-1?Q?tDVmmUmYJYKWQhkBa5FMU5DDJnSzNQjO7CDOWQZZRkS+UDPxwJ/sa75lBf?=
 =?iso-8859-1?Q?Xl8o1YZMUm9LgkeJkAztaNomoxeTViCrIemTHPHP4eivJoHEe2XOs0drAQ?=
 =?iso-8859-1?Q?6uKoHlO8J9mj0J15tJ2ybIl0uGTmXuxh1/UtI9xpii7nQGvNvtgBVOpLUy?=
 =?iso-8859-1?Q?gtpyc6+gb6o6AKu6HY2OmL/BNvoto/TU5YM+HTDju9pxgpfRcHlGzUQoSu?=
 =?iso-8859-1?Q?vPcpfQyo/dX1Jou2v9mS2S5pfxHTd0cqVthDrpqAwDESPZ2CxHgIALMog6?=
 =?iso-8859-1?Q?+p6CLf6Kke7itoRBxhfW2k8CvcKsZLSxZ4Mocy5PF1WNX/sdtTXg9n2WqC?=
 =?iso-8859-1?Q?uxDsReTvNmF46AQlwUI7Nwh0KDzJY8QMTgO2sxQmCeV5eLg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB372488905F6856909C102A32F5480@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(105586002)(6512007)(6486002)(2501003)(6436002)(97736004)(446003)(110136005)(2616005)(81166006)(81156014)(8676002)(11346002)(106356001)(478600001)(6116002)(3846002)(4326008)(25786009)(486006)(476003)(2906002)(305945005)(316002)(7736002)(102836004)(7416002)(14454004)(52116002)(256004)(6666004)(8936002)(66066001)(186003)(6506007)(386003)(71200400001)(99286004)(5660300002)(71190400001)(86362001)(76176011)(4744005)(26005)(53936002)(68736007)(50226002)(36756003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BgvyVJ7b3sA7Ko14gnY4eXVmjiOSr/TUlmHbf1YnId7C1RuWcoISGpdeSHnXZqNTl4VW+5hNRDUanwsf3anevUK96r4dL+0hYE+hzkW93bJHYZ0W17ohebScG2uPlPmPp5Na/mCWCg4HwC3JHkLjRByrpLdVyTJb7q632RyVny3WCzEm1/8hIAQLAICa8Y3pTSvvDiP4Ioj/Obsxtc62RxRpzp2j+dsyoOOe1UOdQclrB/LdprBifMpoRDsb+78xt4veNKBsR9kbB9EsfEauzucSYIRBJ8ZenBd1e5Ri1MlRwsVblV3cVYoimIwASuVksmctHiSTyB4bRl4xzrjvGcdubv3LHdhf6GQX4KuNOUk13bmI2FsE5Rs5fUOZvUnXGDdFV6txRrD1SGhtk6epc1kha+66/PWHvoSDgv/WHIU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9985b908-6aa6-4f1d-9241-08d6a5f1779d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:23.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_PWM_IMX_TPM by default to support i.MX7ULP
TPM PWM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
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

