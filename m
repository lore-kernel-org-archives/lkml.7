Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA6820872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hn+MisWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCRDKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:10:06 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:41926
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbfCRDKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlmavye9Rr2x9E8R913JFvyBynt+aZqXly5InWB06sM=;
 b=hn+MisWlUR6INuhPGbF38wM1d1I4KVboHVMljn2e/zpoKOet9XqvWdsNi0aAlsseydYh7IHZo4p1RgbagMlIHgfmhXsUHBJ9LmKOH6LdeQC9kW9uLeir+QZX49prxiMIYNeZopD4pA56bufbFbmYtKjFlCposh489k2C1nxXqE4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Mon, 18 Mar 2019 03:10:01 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 03:10:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V5 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHU3TgTn3bXWJXBOEWgcftGL3uMWg==
Date:   Mon, 18 Mar 2019 03:10:01 +0000
Message-ID: <1552878291-22866-3-git-send-email-Anson.Huang@nxp.com>
References: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf9dd39d-86d8-45f9-676d-08d6ab4f3582
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB3883A4B33EB93ECD3C48242CF5470@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6512007)(256004)(386003)(6486002)(6436002)(97736004)(106356001)(6116002)(3846002)(52116002)(446003)(486006)(6506007)(186003)(26005)(53936002)(4326008)(476003)(316002)(11346002)(76176011)(2616005)(2501003)(2201001)(86362001)(25786009)(7416002)(305945005)(478600001)(110136005)(99286004)(7736002)(5660300002)(36756003)(50226002)(68736007)(66066001)(2906002)(105586002)(14454004)(81166006)(8676002)(81156014)(71200400001)(102836004)(71190400001)(8936002)(921003)(32563001)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxbJO5VrMZHWQ7WdPHLJSQyYGuFipiN9Pn/I465R5TWLn6gzFU3gZBVC1OcJaPZrTR6zu485okieg2r8Rh7S4bUizqoAmqMbWIZhbe8yEnFv+Z0yT6EoHV9DAfQmYVxfRPFHJZJlNHZ3alvwzfAgYIwJbx2T1++Bm+GxXup6iymjm06cjdRgduDR+Jaduh1VpJNj0uEV7A7wRA8A4uz8NM3eyOWqhfprUvnvfuyq6Ljnp6c9FOMTfPZgcZtbRRti/XoAdZavN5pZ4edd2TzK4i6IH+ouMlYyyEAFaWfpOueKKT2f/cMnSapwAP6VZsz280rddjmRklPE9ObrvCM2K1z5eQi/Nqq1dtBAMFd+32od8gmF29dxe2s0zMEDT4Z9ruhY0vGDRF6PSAig9fAVJ9U3ehxZIq4Adol/HSZ/F3I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9dd39d-86d8-45f9-676d-08d6ab4f3582
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 03:10:01.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify
user for IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox
RX doorbell mode is used for this function, this patch adds
support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 4c3dd95..f0a9224 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -21,6 +21,7 @@
 		mmc1 =3D &usdhc2;
 		mmc2 =3D &usdhc3;
 		serial0 =3D &adma_lpuart0;
+		mu1 =3D &lsio_mu1;
 	};
=20
 	cpus {
@@ -87,7 +88,8 @@
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gip3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -95,7 +97,8 @@
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
=20
 		clk: clock-controller {
 			compatible =3D "fsl,imx8qxp-clk";
--=20
2.7.4

