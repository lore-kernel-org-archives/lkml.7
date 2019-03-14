Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949AFC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59440217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uUCy7KHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfCNG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:28:10 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:3846
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbfCNG2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gTHfcjiexnSbDP/670+KFMkFbyN9c+rIoNNgTOcxhI=;
 b=uUCy7KHCxz84JgtyDy+H/KWLaQ+no5A5jJ6ImlGpdQzav1mmrb+OPOwk9Y9RhR+oguV+09+11w+YhKUVWsJ1LZK3/gN9BrPvQ32NRg5+U3KATtg0u20q20Dyha7sfIfOOHz52vR2WiXuvwtGk1uDxczNnyyvtIduTg/dDgDNgWU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:26 +0000
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
Subject: [PATCH V3 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Topic: [PATCH V3 3/5] ARM: imx_v6_v7_defconfig: Add TPM PWM support by
 default
Thread-Index: AQHU2i7+VjzpvxX99EK8ApUA3XFttw==
Date:   Thu, 14 Mar 2019 06:27:26 +0000
Message-ID: <1552544534-5295-4-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 41ec71bc-dd39-4ec2-f507-08d6a846204d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:p4ZKMVUNVaQVsQLVnTFFp/N9Ti7CbLVlcqKvA?=
 =?iso-8859-1?Q?UdDEODy/5YEx3+aFimdcIFxrVWAl2GZqntaoxYVyGszPZ1LVj+bsDK8xjn?=
 =?iso-8859-1?Q?/ebusJ27wE0yCZU98FOBF9rUsXH/GNFBD3XEVdFm0JvBAn/Xy/Z2stEjk0?=
 =?iso-8859-1?Q?TYkpAlcaaNUp2Q/BR+lfCcvVi3xkgj4X+yWh5rrNgxzP5xmZpIBiUqtbBL?=
 =?iso-8859-1?Q?/mEPwQQmcFa4flioAGMfX+YSqT8VX6t+m5n7Wg03gcI8vHDvCScufZQYtp?=
 =?iso-8859-1?Q?1zsX6YdX1sasCuxW808ODV82KOZuYqipGx1wX3AcEF72Zf2vkLpXjEXr0o?=
 =?iso-8859-1?Q?JdBuaqWfjLEbr/gGaSrrHzAP1urn7yZFM6nTIoj5+WaPdr739qJB+iKkSV?=
 =?iso-8859-1?Q?eT0n6AbewjxOIphNnQ7zr7p7JxmY/G0QhM97+hAhfX+VPY8mnUxjLPjTCf?=
 =?iso-8859-1?Q?Wa1BwWL232jlr8nKo7R4BfqpWe6MB3fRiF0nHsFbzr+h7F6QdDluYm3w6B?=
 =?iso-8859-1?Q?xpt/f1GR5T+XC5dHyGsIxq5DKcqRedUgyAMpQZO1ZLuxmS3B7Z0nHcus7X?=
 =?iso-8859-1?Q?GE9A8cmz+Nf5tReLoFrJfvfBzFUkuTRkt7e2zTIFY+f87PonVUcLIVNkMh?=
 =?iso-8859-1?Q?z8yenPp/4NcrvoTQo5ZuGHSIrzC8ds5t+nZmEDsRoKPyZL3CjQpfYF7Qil?=
 =?iso-8859-1?Q?2SpTx90vCaHW+qOk4PkMotqlSo3aqycj9MPdvF0N5YAmCVJtHmUGxO5Qma?=
 =?iso-8859-1?Q?Y2Ecwz2CoJwyjZ3yEk77GtF+v+z5E4lz+pKLdqonwYN8iF/5XfzJ4Hp8RM?=
 =?iso-8859-1?Q?mnGD9g6clornYpxLgqCQ+uO/brHL2gZzrL01otrui4N7+wS2lXK5Qa9iup?=
 =?iso-8859-1?Q?VirNsgNkj3fq3b7tByX+ckYjA/dKvNbI3p5mZg2B27Dk+wqIGpWDjEgIc/?=
 =?iso-8859-1?Q?PI7Ujy78HiegX6zDr+H+asxpqLSt2ZKIRI1q5iEiFmunEfNMETpIqAwbS5?=
 =?iso-8859-1?Q?d9m26MG/FUKWxsdNIMLWCsStLbOcdzcUVn0XlQOLopaX99lBvFrc0p1863?=
 =?iso-8859-1?Q?qiH4LDhcYuTSRUHT1hvbO9RtKzCzp72q4C6/XZuJBpFuMnyv9lbAfVENzu?=
 =?iso-8859-1?Q?pImoKSOJkftHNCFyj7GjPA10AXL34QM78uAxCsJcjNHQRonIRFl8kn+PIs?=
 =?iso-8859-1?Q?QMQdWaa2Y2X4NVu/yRej3vKKy+AOMxhlF7KcIdh2J2rcyQo7N+AhIOfeP+?=
 =?iso-8859-1?Q?oJ7WQ7S62SqDRIp+M6zqBm2TL4te76ETJO6Ai+CNyJANI8mC2q07VIAG1B?=
 =?iso-8859-1?Q?rZTYz9jchiV8wK5OXUp299NGh?=
x-microsoft-antispam-prvs: <DB3PR0402MB370768A12F0C37FBB08A8266F54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(4744005)(8676002)(102836004)(386003)(446003)(81166006)(11346002)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HQOdKrkNBluIcMOLwKXdjmOFndhtXfFKwFw5SXGYaTev8c7enki250vgnQt60QhzDwD4gMsEvPBY4E7NpFhp7IknnAmy2LkoXeXojrtGLIp97u6S7Arqx3ovVuboJQi3LRvlMvLhU4fNLbGvnxpQRhkFqgA7b9GkjgiG5WoinGYb0Xjr4xgA1QkgbXv3rP9kWB9Ls3NmhO5spVva83/AO8ve3thCMFdvjbEq9y3xZjSrFQ9X3dhdZSYODrhxsFJjyfdgrnbEru75ZjaT1NOG8abDdU9jubW1Qri+8xjQeUCSK9RRLJ6AyZ2ez2BQsOFvFP8d2OyuqPAGQKDjSUwKVunXfEj0Ov7OKVFkERTajEViH2xVqoBGlwQC/+36RR5LBDTjWaD9/spapPqBqGyRJshgRsuAscOjn4gn6cEFVFY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ec71bc-dd39-4ec2-f507-08d6a846204d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:26.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_PWM_IMX_TPM by default to support i.MX7ULP
TPM PWM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
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

