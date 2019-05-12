Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6AB21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NStWGiXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfELI51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:57:27 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:41188
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfELI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzJpsZXPD9zD/JA0xH5Wy3U6IfLBo8uuPbcPUcgS0nE=;
 b=NStWGiXvaiT3KaiUYN21JoaGIfvS8aTNHZHmv+8qJT/U0wjc0YSH6Xl6r0AxWIGrqxNFcA2ZiMu1WCFGSGdFmiRPxblQcjQEhjdA3FkKdez++CKurNheC9/flPJ8YW85tC49SW/JP2udvevDdJEXLv1FXnOFNycXyjecL0iaJFQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Sun, 12 May 2019 08:57:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 08:57:16 +0000
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
Subject: [PATCH RESEND] ARM: dts: imx6ul: add clock-frequency to CPU node
Thread-Topic: [PATCH RESEND] ARM: dts: imx6ul: add clock-frequency to CPU node
Thread-Index: AQHVCKCyUPBMYq44Sky2cK4SYDJN/A==
Date:   Sun, 12 May 2019 08:57:16 +0000
Message-ID: <1557651135-12109-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60e347f6-f58f-4d82-b69c-08d6d6b7d523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3802;
x-ms-traffictypediagnostic: DB3PR0402MB3802:
x-microsoft-antispam-prvs: <DB3PR0402MB38020B9E60A964B912090DE5F50E0@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(66556008)(66476007)(66946007)(73956011)(8936002)(256004)(14444005)(36756003)(305945005)(66446008)(64756008)(6512007)(478600001)(110136005)(2201001)(5660300002)(14454004)(4326008)(8676002)(6436002)(81156014)(81166006)(25786009)(68736007)(6486002)(53936002)(50226002)(71200400001)(7736002)(71190400001)(476003)(2616005)(486006)(6116002)(386003)(6506007)(52116002)(26005)(2906002)(316002)(186003)(102836004)(3846002)(86362001)(99286004)(66066001)(2501003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v8wSCxpeejuUb87JKiEDhDQE+XZ1ekFwg3bvwv5LXOActHtaP8PiyMahQnWjpBCdkLTylSK/pUDXEQ2ya6iWDwTWCnoqu4EUsjSrq7hndryoheHB2qm4bPsmwAbWUZRJg9/X9Z5baQYhhbJ7qbGlGMCCFQs/C8CPv7WINwN1URt8pkIWbHLdTMOa4pbFvqH0x83seIi2eLTVDMYm3UEnr49/KFLE/Oe+efhRzR1V2gQPCCPFALaiptjch8VJKVxXUf1rWZPnnMg+Mx2CILDDLz0dOLs/f5MPXHJ2JvUfW90HNnapEvcrN2p1qd3+jmATLofD1xeAT/B/vfwjeZO3RTXr8MMtzFuZ06m83EXvuVMa12kFAQnxTEzbjJwVNzIj5PUv4BSBsZQ1Bkq99opWTSeb+1pvjRWZKfrSWF/QvRk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6D9007DE5A2E53489B735BE3A21E20B6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e347f6-f58f-4d82-b69c-08d6d6b7d523
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 08:57:16.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock-frequency property to CPU node. Avoids warnings like
"/cpus/cpu@0 missing clock-frequency property" for "arm,cortex-a7".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No code change, just resend patch using correct encoding.
---
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 arch/arm/boot/dts/imx6ull.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index bbf010c..fc388b8 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -59,6 +59,7 @@
 			compatible =3D "arm,cortex-a7";
 			device_type =3D "cpu";
 			reg =3D <0>;
+			clock-frequency =3D <696000000>;
 			clock-latency =3D <61036>; /* two CLK32 periods */
 			#cooling-cells =3D <2>;
 			operating-points =3D <
diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dts=
i
index 22e4a30..727b92f 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -12,6 +12,7 @@
 /delete-node/ &crypto;
=20
 &cpu0 {
+	clock-frequency =3D <900000000>;
 	operating-points =3D <
 		/* kHz	uV */
 		900000	1275000
--=20
2.7.4

