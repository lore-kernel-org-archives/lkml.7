Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C592171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="srbhadSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfB1I4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:56:11 -0500
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:46966
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfB1I4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mf/GujjeDOEyc+QoKy/vckhsH59dxJUPWO93L4I0dA=;
 b=srbhadSamOBVLuZcot8zkSPMGBFLJ4sivNEkyMfSjzeVIYWft+OvH7ILnzNdYuw+rW+i/h9fXGn6qKEIxX1AqhqvPYQsKIDPx05BBlyPc2LiAV2GBHtx36yczAf1miGf9oSA3kJMingIBI/5jUhuWphquV36j3NuERTtr5SEyd8=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3491.eurprd04.prod.outlook.com (52.133.48.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 08:56:05 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec%7]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 08:56:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] dt-bindings: clock: imx7ulp: remove SNVS clock
Thread-Topic: [PATCH 2/2] dt-bindings: clock: imx7ulp: remove SNVS clock
Thread-Index: AQHUz0NwqoYIieDDakemr1/jTgIWjQ==
Date:   Thu, 28 Feb 2019 08:56:05 +0000
Message-ID: <1551343889-6674-2-git-send-email-Anson.Huang@nxp.com>
References: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45a92af2-4912-4c8c-fe5a-08d69d5a92ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3491;
x-ms-traffictypediagnostic: AM0PR0402MB3491:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3491;23:o4w5EwTz90uSmpnVwNY3iptDFihmvmcFIRqtP?=
 =?iso-8859-1?Q?oMI1M/fWxBaz0Z66U8ByvJ/bKLMxq1PMP32P3DUKOzBw488bd2PsBtJvBK?=
 =?iso-8859-1?Q?0PKuHKnec2X10VzrWPvjMOiyIq6SM0qqKgZd/Yt3orpb3jx5bJ3xtEQD0Y?=
 =?iso-8859-1?Q?hqH/6c8OChsofQ6qCJsl4D+x0R5Ev3l39FWZoPwgnPx/ainTPumplFPxrO?=
 =?iso-8859-1?Q?ss9dxb7e1mOtJ4jczfqOa/DiAtwtzoDpeKFZigz+mv1GLx+kdSWh4R2YDe?=
 =?iso-8859-1?Q?FTYg/eK5BNm11d5q4cazmix7wIWKqNrHr4OY5YA0dnbBjeBP2Rexvbxz0X?=
 =?iso-8859-1?Q?9ThlGMgjFMkrcHFqw46CPFpaw+qOo93vTTt4k166Vaoswrxx+kb3dtc/Yt?=
 =?iso-8859-1?Q?LnrSg26cNcMTAHdePsiVzqj3mYQoVTfEkgOttUpIYNli273hfmH6sHelDb?=
 =?iso-8859-1?Q?XZF8ynj1GUTmJY35S5qYBNuCwzTBPXKO4Ja2ShIlIWV26EuriSyru1TWzp?=
 =?iso-8859-1?Q?53XLLKIOzBd1ka3PvSOaDSXB+YgH1Dr64crmjCRFlUTaUAxgevyQ9GUb2v?=
 =?iso-8859-1?Q?u/6JxI5R551s7NPTU5lufeXjnCV5C9WjW0UvwVBuL6+Gv0FlRHV24jmNLY?=
 =?iso-8859-1?Q?4H+iFtqsq5hRkjNtY9NsEZ2sbJ5HvHaSRCiHU5k6lCHrpTuSFjBysbDJbr?=
 =?iso-8859-1?Q?YTqB6sIdnyR2vKBWC5VHoj47nLZUOMwRkr0Bfq+QRPVK3blzMoR5AinsP0?=
 =?iso-8859-1?Q?sK57pj9jYpbjEwDjFMgxgekY3NmVlBWzVDKAvBtvBumsrO/qTWz/bARvjn?=
 =?iso-8859-1?Q?VENzINNH5gSe/2KLcvJYY/Qr9ZpGqPTQxCmkJEZT9QN2wnqP73Lwzbubor?=
 =?iso-8859-1?Q?Lk7IojFTgxydvkyxM3ENdDOA1pp+Pd2vKRENLAsdxSscyBcop6Y6sDljNb?=
 =?iso-8859-1?Q?4pxhqAsC0klERrMT+h8yCq7hY20wOI8IDyAyHqoOH6ULLb5efuEDaE0QON?=
 =?iso-8859-1?Q?AZyPinH3a7U62437CBVvV3r5msi/IlcUQW6aBhbupKKMz3skxHrPYCSMBk?=
 =?iso-8859-1?Q?EzH3K/rYIySOmucQljKSmkP8TxOYNkHov7UTRb+ZRjdQ7AoEmlE6YdVoQT?=
 =?iso-8859-1?Q?IAj14h8heayiNsAbZImizCQ0jh7nKqtohKIGClGAqWQ+vm1P9HnJByzR4x?=
 =?iso-8859-1?Q?DYKyuIgVHCKQQRrpu0T4b11X5sp9otAl9NftMEOixamjkY57WEgHwTlRss?=
 =?iso-8859-1?Q?ecdywP0skaUkwu1urmmtUs4o+LwLUi3FfVBV9MFDWGLVqVpB/Eet7A+1qS?=
 =?iso-8859-1?Q?y+J3xf8MCP9R9vpJNfqqK/V+Ivk0otmx04iKBmPLgaLYVpQ=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR0402MB34917D776CD4C2D9CE41C92EF5750@AM0PR0402MB3491.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(256004)(4326008)(14444005)(2501003)(99286004)(2906002)(76176011)(66066001)(52116002)(5660300002)(110136005)(71190400001)(2201001)(4744005)(316002)(86362001)(25786009)(71200400001)(97736004)(3846002)(6116002)(478600001)(6436002)(8676002)(81156014)(81166006)(26005)(446003)(6486002)(11346002)(106356001)(2616005)(105586002)(476003)(14454004)(6512007)(7416002)(486006)(186003)(7736002)(53936002)(6506007)(8936002)(386003)(102836004)(305945005)(50226002)(36756003)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3491;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TPZn5zYeLvXOFTJlcAYMXW1LGlJso/eZ4Yrcnj0gvB5lqJAd/BxnLq9GvZuNweqBj1eTnj+ZGLXjSt6FpBdTE5qVDnmuJiKWqKxzb42qsaYuCd9z44XPQ8szR/kssgLSEFFXTIF9soSJ9fAKpbGPx+2dLVY5oaXfxbBBlN8d9kwkY/NERHMpQ40a8kTgTmZcU07N9NDEnmRkXnwbHBvdz6P/t8n9N5EyTUPauUFa/13NnYcuva0/f0z5n46hmAx1URZ4PPbqtx+sqFGDCvvmM7hJk0FVmfzFAXDchNspRmEqRcLY9Wje0/fW/UwWKZG0VHvb7vNLxnbw8w8p8XJR7pe9oTK1BaR1TwrrAGADdL53Gv122KKO6qvWZ1Z31w5ntOLDzNn4SlMIOmXLZrljjDVe2ux75BGcX+K3diadrS0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a92af2-4912-4c8c-fe5a-08d69d5a92ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 08:56:00.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i.MX7ULP B0 chip, SNVS module is moved into M4
domain, so remove it from Linux clock table.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/dt-bindings/clock/imx7ulp-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-binding=
s/clock/imx7ulp-clock.h
index 21d872e..6f66f9005c 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -65,7 +65,6 @@
 #define IMX7ULP_CLK_FLEXBUS		2
 #define IMX7ULP_CLK_SEMA42_1		3
 #define IMX7ULP_CLK_DMA_MUX1		4
-#define IMX7ULP_CLK_SNVS		5
 #define IMX7ULP_CLK_CAAM		6
 #define IMX7ULP_CLK_LPTPM4		7
 #define IMX7ULP_CLK_LPTPM5		8
--=20
2.7.4

