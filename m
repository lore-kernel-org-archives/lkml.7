Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90759C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB2E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiGUTdC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCLCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:24:15 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:63415
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfCLCYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXyH0iMdQTNu69pcdyxJt851tpAl5j0EqDhU9ffFz04=;
 b=PiGUTdC51Oy0ILIdXdl+irZS8rieb7lp9RItMSw/MyVHk7JwnyGVkbhWVI8VgrII/lckeagWBVWmBfahXzIfr/NJ8DpoOriTe39HE5wt68rJFgJ6VIuOeRsBG1oNDm4sSkqn8U5/Gpkjy8OKIeHsIDEbVNHZBQVMocfVnVyGNVI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 02:24:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 02:24:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/4] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Topic: [PATCH V5 1/4] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Index: AQHU2HqsZ6aEQ4hxA02MUUfLD04Ndw==
Date:   Tue, 12 Mar 2019 02:24:08 +0000
Message-ID: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c276ca2-2cc2-40b4-cf78-08d6a691ce60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:a6rtqpvpHrdczs+Xdv+h/B4kMw7XaQD0Hjy4B?=
 =?iso-8859-1?Q?apxylZGc1cWWqYwKMjH6HSxR7ozrNgg+ObBRGrZGolV1EgDRBKxdPuQGLt?=
 =?iso-8859-1?Q?wVYLZUKS4wRcDrOzkhlBdYvzdG2OvyOgF9VdAgagBnNsv9F3cHP8b+7QIy?=
 =?iso-8859-1?Q?XIKGc1pcCTxUD3OEnRC/qYj8Vx2o0FpMTReg3tdTJ1EDVFNrzUvrEDVnvB?=
 =?iso-8859-1?Q?XtRMH/uaq7oaWb63ZG7svPzPlzmd/JAsjLU5LANyBIk//pcDIRdShzTcRd?=
 =?iso-8859-1?Q?4GcaoAOTt/uBm7YY2oz91kyGaDu67ZNdcuy4SmrCnRUZ554pYmqrCmhf45?=
 =?iso-8859-1?Q?n+YgpEzuCBvO276Zc6LcaEs5A0+1hmSWErR5rf5vf6CSlr89rxzsCPh/Av?=
 =?iso-8859-1?Q?47QSzvEaaaWKDXLgw/nep+g6urQAdwJRf5rocxnkUx5VQYyDZItxZdrox+?=
 =?iso-8859-1?Q?nehz7VARxGWE1kspb86xF8CoLkKOczWaxxWIrIOOjdxLIETdOk1gvaEdU5?=
 =?iso-8859-1?Q?ZBvA3LdX+qo5GL1runra5lKZafuehEMT9ZP5ZzHjksuNAdef/Mu71HVE9O?=
 =?iso-8859-1?Q?K89+IVPfgOJII3lAiWSuK4vRpdw4eIkjfVc+F5vjvltjQxwS2ywtCt3QWY?=
 =?iso-8859-1?Q?9rbakSko3qT1G5jm6rNZnpCh2o/97+Gebz2BL3k/Eq31g30LZliGT8Al4i?=
 =?iso-8859-1?Q?HKZu8GlTbdpo3mRt7NSXvcel9Nml18FGgyrO8TlK9yKf0mLwS0Lv/ptsT5?=
 =?iso-8859-1?Q?03CthxldFN75arp8COk6A2Tutb3A0Kh2ULPdpAUPF8UqnOZxuhW/WMW8gA?=
 =?iso-8859-1?Q?Bmdy2t7Ipymh0gNK7Z2VtUR/I88Q4i9JcUsFjQX2ykYEN0Dgi3nmdl0VVv?=
 =?iso-8859-1?Q?pyNXNeHs/NMgYiPSppR+KKxZYyNH27Zw6+LuhgtURoWho0QB53GmFGMjKV?=
 =?iso-8859-1?Q?fBmA4tjSClfoNIeHE1xtj/yFJRi05SWdYGdzGph0rQt1iX/UZCpgmZ5C2R?=
 =?iso-8859-1?Q?ZfbPBfKcPZ3qg87OSU09U4rxNtpEKCQqeovgXicwIW0ZO878e3UPhYzyum?=
 =?iso-8859-1?Q?vvjwic8nHLgJtdkyEeZwqrcd2/UKsbJc09Y6O4iFcP6acKGttzLzWfgYQf?=
 =?iso-8859-1?Q?ssJLqI51VN0vbK2bV86/zOUlpYOmJIJWbWJq40/Fk8Tmyqum/rNuj8sBtC?=
 =?iso-8859-1?Q?IFNb83nmU4S6cZknCK8P6b6CPGn6AD4wKmw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707A0500DBE8DAA03AE2A4FF5490@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(2906002)(106356001)(110136005)(316002)(7736002)(486006)(50226002)(476003)(305945005)(6512007)(97736004)(4326008)(6436002)(3846002)(105586002)(25786009)(53936002)(86362001)(6116002)(2201001)(6486002)(14444005)(66066001)(14454004)(478600001)(256004)(71200400001)(71190400001)(8936002)(26005)(8676002)(102836004)(36756003)(81156014)(81166006)(2501003)(186003)(68736007)(2616005)(6506007)(386003)(52116002)(5660300002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ng1qQkgVyA2SnAyJHPEqGNnNyDz+86Fbbjf7rV4A8qXH7WlPOAQxXBIQTScTeoHOa1nigALunrP+t9M6oCLwXnO2uqiKl6l6+/lv5yTP/Nc5pAa4NZUSV8AhpxMznZRdAatqOyRDxMXT7armTJL0QDxMMsfZKlXXSdw4HM2FqvkTRLVuCri0fBnFU3AT7sieuY6y86hARLecwTdAIBoAafVUv5goeWAhzsLavbGvJhCTtaoakMI0DrT4ctCmAn3c5uKNEz/O3pFMcgtjMOFWa4v5+mq4JhBkJxiyQ7yYETpPq+ufDV0SzJqQqfC6gC+GWxyQpxVfUnD6R9+btmpXSGg2lb9Y1CfKqAropgnc799e3N0oPrDYzWqzh0/Qa7oCqiZX/mRNiWUOeUE+8yFwFQkI0iAAGcgKkc5yIEIx3H0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c276ca2-2cc2-40b4-cf78-08d6a691ce60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 02:24:08.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MMDC (Multi Mode DDR Controller) driver is supported
since i.MX6Q, but not yet documented, this patch adds binding
doc for MMDC module driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V4:
	- update mmdc1 example.
---
 .../bindings/memory-controllers/fsl/mmdc.txt       | 35 ++++++++++++++++++=
++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fs=
l/mmdc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.=
txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
new file mode 100644
index 0000000..bcc36c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
@@ -0,0 +1,35 @@
+Freescale Multi Mode DDR controller (MMDC)
+
+Required properties :
+- compatible : should be one of following:
+	for i.MX6Q/i.MX6DL:
+	- "fsl,imx6q-mmdc";
+	for i.MX6QP:
+	- "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SL:
+	- "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SLL:
+	- "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SX:
+	- "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6UL/i.MX6ULL/i.MX6ULZ:
+	- "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
+	for i.MX7ULP:
+	- "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+- reg : address and size of MMDC DDR controller registers
+
+Optional properties :
+- clocks : the clock provided by the SoC to access the MMDC registers
+
+Example :
+	mmdc0: memory-controller@21b0000 { /* MMDC0 */
+		compatible =3D "fsl,imx6q-mmdc";
+		reg =3D <0x021b0000 0x4000>;
+		clocks =3D <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
+	};
+
+	mmdc1: memory-controller@21b4000 { /* MMDC1 */
+		compatible =3D "fsl,imx6q-mmdc";
+		reg =3D <0x021b4000 0x4000>;
+		status =3D "disabled";
+	};
--=20
2.7.4

