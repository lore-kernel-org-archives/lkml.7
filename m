Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C9C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YA0kpDbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfDACvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:51:17 -0400
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:50245
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731593AbfDACvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0uA4vG4l3jiA5srVGGjy/BOPUl5LI5VE61okPN6SWM=;
 b=YA0kpDbl02kyy0PZ1t2uFOP7G6ZUDjkKKpWBkk0yk1KXGwa3ixlXPq7kbLzagsdzZpz163F/mukGfdCdyZDIJgExs4u1qvMLqUM2N/wkUse7+qywS+LaRP3ohMvMf7xJMHUvFKSs3llbiU/bikCzm0qxN0m7F6p+zWm9WNtri7M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 02:51:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 02:51:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sll: add cooling-cells for cpu-freq cooling
 device
Thread-Topic: [PATCH] ARM: dts: imx6sll: add cooling-cells for cpu-freq
 cooling device
Thread-Index: AQHU6DXDCNSkL22MVkqRuIjoEO0bmQ==
Date:   Mon, 1 Apr 2019 02:51:11 +0000
Message-ID: <1554086786-3691-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07b8a305-5a41-44ea-11b9-08d6b64ce5fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3881;
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-antispam-prvs: <DB3PR0402MB3881DBF08294227F3C9A1FDCF5550@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(81156014)(4326008)(478600001)(53936002)(66066001)(110136005)(6512007)(71190400001)(2501003)(2616005)(71200400001)(4744005)(99286004)(476003)(52116002)(2201001)(3846002)(486006)(305945005)(256004)(7736002)(97736004)(8936002)(14454004)(36756003)(6116002)(25786009)(186003)(316002)(50226002)(86362001)(2906002)(6436002)(68736007)(102836004)(106356001)(5660300002)(386003)(81166006)(105586002)(6486002)(8676002)(26005)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3lMB4T2Se4qHNsbwaBjq0VB2wwNcRA80xVnmEyYifuchOx1AHGQSPsXrSUqwaF7LJGodOL4l90kiKtBqpOedIZCX3Nkzbtr7ikUsJ+Rknx9uDNlRrBwyL9cSBpWVWGTNRoMlPx+JpwFyuPVYP8IxQZhhTHQsn1OpBpmU8GOMzdujDupduMIrAJeBc4ey+vB/J2W59AoKzW/b/jWCFyX06ivohCKBqni6EaD03b10aezhjdcz3+UlA0te11x8OYFGbpnRuyhV+xDKdRRhgRiwaaDyn33sANmL9XnhhebZcL9OSf5wkaTQceDcln3bbmHTQy4DmOWtr0YGcNrPnSXseYGWp8PFp9kzvIW8ZN8GRxjTZepOOwBJJ0cPVgTFqeFOYnsLXCa1wAzTQlaYorhugm/I6lZUEvR52KR7J8YgThk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b8a305-5a41-44ea-11b9-08d6b64ce5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 02:51:11.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #cooling-cells for i.MX6SLL cpu-freq cooling device usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dts=
i
index 62847c6..bffdad1 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -64,6 +64,7 @@
 				198000		1175000
 			>;
 			clock-latency =3D <61036>; /* two CLK32 periods */
+			#cooling-cells =3D <2>;
 			clocks =3D <&clks IMX6SLL_CLK_ARM>,
 				 <&clks IMX6SLL_CLK_PLL2_PFD2>,
 				 <&clks IMX6SLL_CLK_STEP>,
--=20
2.7.4

