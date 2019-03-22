Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD8218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vp397Vb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCVGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:32:02 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:5379
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfCVGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdN07wChgTV2VUDg+CZztCwB7OX6L4SdVvnPV8MJcWI=;
 b=vp397Vb/MXtJjapi//HqmbSgh1YU1Sp8sMYmYyarj+vTR+7Lev62tg9y2QM7UDuxT1Xjc8z5jM/JZthxuy6ApFg9x/ebgd91bWCtmHMxisNswlLuzhMZItSAhyF397/iTiAyclYDganiu80pcnECKdlMnQjGHzekRLU8brlBN2w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 06:31:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 06:31:57 +0000
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
Subject: [PATCH] ARM: dts: imx7ulp: add ocotp support
Thread-Topic: [PATCH] ARM: dts: imx7ulp: add ocotp support
Thread-Index: AQHU4HjyY7OiCgqW6ka54y6RfIEkRw==
Date:   Fri, 22 Mar 2019 06:31:56 +0000
Message-ID: <1553236008-28407-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:202:2::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a74c017a-e39f-4640-b9d8-08d6ae901490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3882;
x-ms-traffictypediagnostic: DB3PR0402MB3882:
x-microsoft-antispam-prvs: <DB3PR0402MB38826E803C2B5E04BF685E89F5430@DB3PR0402MB3882.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(476003)(2906002)(106356001)(105586002)(2501003)(110136005)(25786009)(256004)(71190400001)(71200400001)(14454004)(4326008)(478600001)(97736004)(36756003)(316002)(6116002)(3846002)(6436002)(53936002)(81166006)(81156014)(8676002)(7736002)(6512007)(68736007)(2201001)(305945005)(86362001)(6486002)(66066001)(99286004)(4744005)(52116002)(5660300002)(26005)(8936002)(50226002)(386003)(102836004)(6506007)(186003)(486006)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1KvVUSlPSKlMlFCOzrDOiSKQLDKwdes69UE6mfuWS7DkPAnasMsI4ap+Z13TB+1Yj1tkpMQnRwPqqWFLnFRzIyqOhWmZ/5nBf4Er95uQt2QKPJdEqA8IFxdcuvSEgvoGAGZyCQ1x0/kGMXhiXsvotPrlj/81+D7hVFtgd+fA0YF0rnsipwamrgx4ZFSjQkN6WKN8+BwKjjbNPvqMZWQ+YnIUIdFpy9nSBTKaHXfDng0L1ElabkUmG9iwM9iCvwIXkfEOcqj1jUIki4rq0mNcdZLEA+zNzQBGDPus11dThyWMQs1IM+d6vkiMg371JQq8MoFKToLQyJJzNj7iou6UAOnv1Pj8zQVn1k2dA4Q4Zb77JX6YddR8peU5OfIR/AwZC6709WBPqZZCTQglfdVxo6NabMqNwA4cUTTCCtXRPx8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74c017a-e39f-4640-b9d8-08d6ae901490
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 06:31:56.9791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7ULP OCOTP support, its clock source is from
M4 BUS clock which is NOT available in Linux clock tree,
but M4 BUS clock is always ON when A7 (Linux) is alive,
so just use dummy clock here.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index eb349fd..d6b7110 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -365,5 +365,11 @@
 			compatible =3D "fsl,imx7ulp-sim", "syscon";
 			reg =3D <0x410a3000 0x1000>;
 		};
+
+		ocotp: ocotp-ctrl@410a6000 {
+			compatible =3D "fsl,imx7ulp-ocotp", "syscon";
+			reg =3D <0x410a6000 0x4000>;
+			clocks =3D <&scg1 IMX7ULP_CLK_DUMMY>;
+		};
 	};
 };
--=20
2.7.4

