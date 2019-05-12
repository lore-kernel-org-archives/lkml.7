Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796B0C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE602086A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCv+DQCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfELKCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:02:18 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:45717
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfELKCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f95xEAy3BNcdb7ffIAeaX2Mwx9y9DtEwpFRORv9wkaQ=;
 b=CCv+DQCC79ierZiJsnVXjbTYebWKb1RH2a4lsrT/UEeklzKxXleu5tef1Qg6mhFxBSMu0AIE2BWqK/URYX4V6/qWQhYgUfkWCE+KgrN98jRXAA/29npD8K0b9Ou2jWoR9f5GkTfpJPvc9G4nwUg7vceeohDSKBBecxf8qEcGmJ0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 10:02:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 10:02:14 +0000
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
Subject: [PATCH RESEND 2/2] ARM: dts: imx6qdl: Assign corresponding clocks
 instead of dummy clock
Thread-Topic: [PATCH RESEND 2/2] ARM: dts: imx6qdl: Assign corresponding
 clocks instead of dummy clock
Thread-Index: AQHVCKnF4tjTdRl/wkOJUp/FW8AbFQ==
Date:   Sun, 12 May 2019 10:02:13 +0000
Message-ID: <1557655028-12654-2-git-send-email-Anson.Huang@nxp.com>
References: <1557655028-12654-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557655028-12654-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21fe96b6-5133-4f5c-2feb-08d6d6c0e7fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3913;
x-ms-traffictypediagnostic: DB3PR0402MB3913:
x-microsoft-antispam-prvs: <DB3PR0402MB39134440D66A0812CE743404F50E0@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(446003)(36756003)(81156014)(52116002)(50226002)(81166006)(99286004)(76176011)(4326008)(8936002)(25786009)(2906002)(486006)(110136005)(305945005)(7736002)(4744005)(5660300002)(68736007)(316002)(6506007)(2201001)(14454004)(386003)(6116002)(73956011)(66066001)(256004)(6512007)(11346002)(66556008)(14444005)(66476007)(3846002)(66946007)(66446008)(2616005)(64756008)(476003)(71190400001)(6486002)(53936002)(478600001)(186003)(71200400001)(8676002)(26005)(2501003)(86362001)(102836004)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gsNwIosckeJmtfmFhTq+ivhDgMjJXnm7gYHmn7HS627IBpcUNB/VuV+Y5jd0csyLqRpy4fnQjkeOmnTyVDLGXPPxqDZyw8CsKFqMQnodnaPOUzlYE9/wcgYWCRflDYs4pl8S+iytTLcu5BeXe6HEWmajZx3qacpHRb5E5zlAA8LV1McdKirFfbUURY9hGJ1b4/5IWf98aIrJNKfjJdGjR6d8LhIAhF8/nnTaWtN4pkbvvKZ09FCN5O9xhBv9aRrh29Kr+2QDnq9Uxg66jtCBykEKjQI57a6Fhya42A+gUEd3yhtJ+/mwvBMjr0WAd4xmrdyOlrdH6i9We9BGoMZ8eZINViHtLBJ3+6LtZsuu4UGxsv/xhuEVS838EjJmelFdfIQEnHMvzRy8RDpGSmrbpL0ypKyYivTGM04HOSA+XAI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <690554EFBD99D94FBFE3185571A98004@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fe96b6-5133-4f5c-2feb-08d6d6c0e7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 10:02:14.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6Q/DL's WDOGs use IMX6QDL_CLK_IPG as clock root, assign
IMX6QDL_CLK_IPG to them instead of IMX6QDL_CLK_DUMMY.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No code change, just resend patch with correct encoding.
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index b3a77bc..664f7b5 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -675,14 +675,14 @@
 				compatible =3D "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg =3D <0x020bc000 0x4000>;
 				interrupts =3D <0 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6QDL_CLK_DUMMY>;
+				clocks =3D <&clks IMX6QDL_CLK_IPG>;
 			};
=20
 			wdog2: wdog@20c0000 {
 				compatible =3D "fsl,imx6q-wdt", "fsl,imx21-wdt";
 				reg =3D <0x020c0000 0x4000>;
 				interrupts =3D <0 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks =3D <&clks IMX6QDL_CLK_DUMMY>;
+				clocks =3D <&clks IMX6QDL_CLK_IPG>;
 				status =3D "disabled";
 			};
=20
--=20
2.7.4

