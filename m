Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB33208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 04:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ftwWKH/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfENE5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 00:57:23 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:7343
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbfENE5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqZZaUK8JGU40021vzGXy6vggv81RjTCBm81fC9w7+g=;
 b=ftwWKH/6Un+k0q0cohA7YvMzs9rKVno9XZ15z+Z7fR0CZhPm/7stdlRoCqkpJy4pJRIDig/w9UBd5wBtRkVO6wEA+Bn/Ba+f/Qtz4Q0PUbwv6T6a9jCEsC9hngfEglvCwxb9v4jzzd5GVzL1iwsUsO2wd1h2PDXYRVum/c3t2DE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3722.eurprd04.prod.outlook.com (52.134.70.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Tue, 14 May 2019 04:57:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Tue, 14 May 2019
 04:57:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] arm64: dts: imx8qxp: Add gpio alias
Thread-Topic: [PATCH] arm64: dts: imx8qxp: Add gpio alias
Thread-Index: AQHVChGBhvqur/npCUCFDgMod6JPUg==
Date:   Tue, 14 May 2019 04:57:17 +0000
Message-ID: <1557809536-749-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b7cc21-1006-45d1-b4ae-08d6d828a33f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3722;
x-ms-traffictypediagnostic: DB3PR0402MB3722:
x-microsoft-antispam-prvs: <DB3PR0402MB3722ECA51717CAF4450D4B68F5080@DB3PR0402MB3722.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(52116002)(68736007)(305945005)(316002)(3846002)(6116002)(102836004)(6486002)(8676002)(4326008)(86362001)(6436002)(26005)(2201001)(186003)(71190400001)(6512007)(386003)(6506007)(50226002)(53936002)(5660300002)(71200400001)(110136005)(36756003)(66066001)(8936002)(256004)(2501003)(478600001)(486006)(25786009)(66946007)(66476007)(73956011)(66556008)(81166006)(81156014)(2616005)(64756008)(4744005)(66446008)(99286004)(476003)(2906002)(14454004)(7736002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3722;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4V8l0N/tg7DNLYiE7mVV/BrQS6P/XfjaCRPKEiCPUPIx6Hovr/uO6zTZmIKJObRWKk1u6l/J6hRz7lx4zkIQb99//+nW/ndTDLSR7OqI7hxlVN+8RD2O9iESlqnULLYFQjfGcNk+Egf31Z2CTGCQu8aQlRjAHwIpsVJlN/jj1rGcTb6i5u5VXvl6ZZPuX/B6hLdnrF+Bm8IPn+RDNjMFK1cKaLcmHYBc2rA4WPCLE7kjIPR/+tsER3QflsjF1RDqPzhoAq0USPwywlRFmKwm4AcnJeJ7+1ZaowNAIvH2qe9pPkv6N9FdakspsPQTQkP8YPjpruI6jVopCMprY9xSkWaKaUhyf99Gn5U7eVsvq7razdVvxWQekzsySwoP+RON91OfNJCJyzu4Wy6tN5QDlvlWInq7SWbBM5RgzjzvmGs=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <14512C07EAFE424A98EC3DACC8F6E91C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b7cc21-1006-45d1-b4ae-08d6d828a33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 04:57:17.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP GPIO alias for kernel GPIO driver usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index b17c22e..923705e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -22,6 +22,14 @@
 		mmc2 =3D &usdhc3;
 		serial0 =3D &adma_lpuart0;
 		mu1 =3D &lsio_mu1;
+		gpio0 =3D &lsio_gpio0;
+		gpio1 =3D &lsio_gpio1;
+		gpio2 =3D &lsio_gpio2;
+		gpio3 =3D &lsio_gpio3;
+		gpio4 =3D &lsio_gpio4;
+		gpio5 =3D &lsio_gpio5;
+		gpio6 =3D &lsio_gpio6;
+		gpio7 =3D &lsio_gpio7;
 	};
=20
 	cpus {
--=20
2.7.4

