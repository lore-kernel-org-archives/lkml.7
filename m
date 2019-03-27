Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77AC206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jm6puoGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbfC0TDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:03:21 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:60614
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbfC0TDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7k5DM3JooaUo1Ma05zFDuYTJPhvI3BuVzS7j7MkROY=;
 b=Jm6puoGsxZad4FvYk5WqBU3iR7jAD6f9FANh3zmewMzkQ0MvT+g7Y+ESJj5wD3mA1pwXcM6QVYfiq1+eFyflmiqr3ViO7oFZdy6GDi7C55kF7VwZW5JQqFiW9nYn442kkeVmXP8dmGy1IjRdhuHPtxaRPAd5ToD3Prh1QLO9MkQ=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3646.eurprd04.prod.outlook.com (52.134.14.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 27 Mar 2019 19:03:10 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5%4]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 19:03:10 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/2] bindings: fsl-edma: Document fsl,imx8qxp-edma
 compatbile string
Thread-Topic: [PATCH v2 1/2] bindings: fsl-edma: Document fsl,imx8qxp-edma
 compatbile string
Thread-Index: AQHU5M+4wON1mdWqjUK0/cm2XGej6g==
Date:   Wed, 27 Mar 2019 19:03:10 +0000
Message-ID: <20190327190244.9208-2-daniel.baluta@nxp.com>
References: <20190327190244.9208-1-daniel.baluta@nxp.com>
In-Reply-To: <20190327190244.9208-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e428a39b-8d6a-4876-53cc-08d6b2e6daca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3646;
x-ms-traffictypediagnostic: VI1PR0402MB3646:
x-microsoft-antispam-prvs: <VI1PR0402MB36466B4E40192AAE41AC7FD6F9580@VI1PR0402MB3646.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(2616005)(476003)(11346002)(5640700003)(6436002)(446003)(44832011)(486006)(4744005)(6512007)(8936002)(50226002)(478600001)(68736007)(6486002)(386003)(6506007)(105586002)(106356001)(25786009)(99286004)(4326008)(52116002)(76176011)(1076003)(26005)(2351001)(256004)(305945005)(102836004)(71190400001)(5660300002)(14454004)(53936002)(66066001)(6116002)(6916009)(3846002)(2906002)(36756003)(7736002)(97736004)(316002)(8676002)(1730700003)(81156014)(81166006)(2501003)(86362001)(54906003)(71200400001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3646;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bxllR/z/vzceKh0WaSZrdgUIfNLA1pyedFbpdzsYDA3VhZYdgHjig0M5rUR2CarufgMXQIk2YwaKcKRM9Qyca89xLg9r30mAmcKGKurYsz0ZWQC9HUqEa93RYYc+qOxbIiFWO+J+U9ocYWqG/xb5hDxUKcBb5y0apPqLieNiINpugngs4jYglF/M8d4EHTA40/c86M3SOLT3OBauD+qE2lXZM1sY45fkopK8otdfwMw2G8+JHj3zYnuGkmyOfAPWa3+DNU7UHt57I39nhCWTDQmCwzN1o1B98o5cYrzTqSRMqkX6GgyAwgP1GGzhc21nwux0ToOlpNIFIyOTcitqZhPplD3UHFxHFQwc+xOV1GD7OJuYq1eIhWDT/gynzzpPtBrsG5gsLP5IR6U5C2uCilCcc6Eosz4no0khBHE4+Oo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e428a39b-8d6a-4876-53cc-08d6b2e6daca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 19:03:10.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8qxp edma support.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-edma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documenta=
tion/devicetree/bindings/dma/fsl-edma.txt
index 97e213e07660..3fab727746dc 100644
--- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-edma.txt
@@ -9,6 +9,7 @@ group, DMAMUX0 or DMAMUX1, but not both.
 Required properties:
 - compatible :
 	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
+	- "fsl,imx8qxp-edma" for eDMA used similar to that on i.MX8X SoC
 - reg : Specifies base physical address(s) and size of the eDMA registers.
 	The 1st region is eDMA control register's address and size.
 	The 2nd and the 3rd regions are programmable channel multiplexing
--=20
2.17.1

