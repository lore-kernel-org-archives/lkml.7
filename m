Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1C2C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208472173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpfLpmN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfEUIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:17:08 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:18407
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbfEUIRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEyyS8ol+HkDpt3Ef1dA2HWrDspdUA7/D/lLX0vQjUo=;
 b=SpfLpmN3jBb1Alxvco4tZRPPWZCtPmMi7XLAPEK9Nj0oPvQszAn4bk2Ve6DSrSkmSM+Piy+ATIkZ5dSzmVqe0ZNXqwQtvxSJzST1bisjhcpmxTiAER9V1aCIAYEFLSKTDFlTrklOkNzUOkWgn7U7QlvVFj3MeC50QYlGebQKlzo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 08:17:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 08:17:02 +0000
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
Subject: [PATCH V2] arm64: dts: imx8qxp: Add gpio alias
Thread-Topic: [PATCH V2] arm64: dts: imx8qxp: Add gpio alias
Thread-Index: AQHVD62RzvRMKJqLaE6z8I6tTELPJg==
Date:   Tue, 21 May 2019 08:17:02 +0000
Message-ID: <1558426311-14082-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e749f0be-a302-4e65-7a89-08d6ddc4b2f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB375528A6EE25645FD1008D09F5070@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(4744005)(478600001)(6486002)(7736002)(186003)(2906002)(102836004)(86362001)(68736007)(66066001)(305945005)(25786009)(81166006)(14454004)(4326008)(2201001)(6506007)(50226002)(386003)(53936002)(8936002)(6512007)(66476007)(66556008)(64756008)(66446008)(73956011)(66946007)(5660300002)(2501003)(256004)(99286004)(110136005)(6436002)(476003)(71190400001)(71200400001)(36756003)(8676002)(3846002)(6116002)(316002)(2616005)(81156014)(52116002)(26005)(486006)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5hl1vKUivANKZkIa2ceJ0ZoeBSJWa41XNHFHhfGaBC8juAY3w7HOO8lV+/keJh9iLfP3aoBGiz9mIVk4NPyAYKe4eMwGJ1atOAwTXjf7MWVIry1Dbi9RIYmaF6aba2Io3D+Vl8/Oz74eMZgDO627ZTZtQkff07LdUiElnJbszzEo+N7fZwpA8wRC8BNwHQrh0g1k6ok6DTMAXOoVjgU674PTYKuwa2l0rWAKA/W4G/m3kOjoV5drW7Uwk8P/DKFKF1pCDfO0X7TYI0cHmru+fF3pz5/NTnmWJdvKQ8uHhu7tG+YbLCoh4UK8WLfOnZIIMt22+pXNODH/ihIjUtLKa/AeidbzWhIjbXDQBJhetrHAMLWkVSFPnxkiPsfpfYH88ewbGh8cZhVPffwuoS6lYUEMwfxkNOSmYRwMaRDb1ck=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A2CABE59647ECC4090163A08D8073540@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e749f0be-a302-4e65-7a89-08d6ddc4b2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:17:02.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX8QXP GPIO alias for kernel GPIO driver usage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- keep the list alphabetically sorted, no content change.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index b17c22e..9f52da6 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -17,6 +17,14 @@
 	#size-cells =3D <2>;
=20
 	aliases {
+		gpio0 =3D &lsio_gpio0;
+		gpio1 =3D &lsio_gpio1;
+		gpio2 =3D &lsio_gpio2;
+		gpio3 =3D &lsio_gpio3;
+		gpio4 =3D &lsio_gpio4;
+		gpio5 =3D &lsio_gpio5;
+		gpio6 =3D &lsio_gpio6;
+		gpio7 =3D &lsio_gpio7;
 		mmc0 =3D &usdhc1;
 		mmc1 =3D &usdhc2;
 		mmc2 =3D &usdhc3;
--=20
2.7.4

