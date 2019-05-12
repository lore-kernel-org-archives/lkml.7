Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35502C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BAA2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 09:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBnL2/jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfELJ5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 05:57:41 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:65085
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfELJ5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NMVWKYbJsN0w/2n1SRPa3yNu1bwqvH72oxYV1w1de8=;
 b=nBnL2/jItQn5BRs67r7SG5fTswUt1E8CJlDacvDOQT5128s9p4QvFwGHzk8jSywx6rbRf1HaXvVI61IdzJCgZR+ZH4E45ci2vJ7XCXNdFClTp8ZbcwykmXEME5Sf3IFYmDiE8C9QFUTufi3jZQZeFLhqWjflO/i1MkzSmdZdJss=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 09:57:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 09:57:32 +0000
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
Subject: [PATCH RESEND 4/5] ARM: dts: imx6sll-evk: Assign corresponding power
 supply for vdd3p0
Thread-Topic: [PATCH RESEND 4/5] ARM: dts: imx6sll-evk: Assign corresponding
 power supply for vdd3p0
Thread-Index: AQHVCKkd6h1kC5KmL0udESVTbpHl/Q==
Date:   Sun, 12 May 2019 09:57:31 +0000
Message-ID: <1557654739-12564-4-git-send-email-Anson.Huang@nxp.com>
References: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f67eef36-d9bb-45a7-bdc4-08d6d6c03fe6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB38994173571E3153F33B68D9F50E0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(446003)(66476007)(66556008)(25786009)(486006)(66446008)(8676002)(11346002)(2616005)(476003)(73956011)(4326008)(14454004)(64756008)(8936002)(50226002)(66946007)(6512007)(53936002)(2201001)(7736002)(26005)(102836004)(71190400001)(86362001)(71200400001)(6506007)(478600001)(386003)(81166006)(81156014)(305945005)(316002)(2906002)(110136005)(6116002)(3846002)(66066001)(256004)(5660300002)(4744005)(68736007)(36756003)(186003)(76176011)(2501003)(99286004)(6436002)(52116002)(6486002)(138113003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bp5sB5QAC62tiq8AO90unsW2qcra9eklP0StNn7XJjOKWoNqSTLuU/bozJCR++8wQIfx82g4ssGuBfnCVtBBcATRHeTkljzXwv3jnq9QlYfYN2JKvycAHH7WycXzv5jziGu0AnwN7TiOI6Sttu/m6WVfqLF5drLn/KPJCYuvqHVe6duHFO+leCmENikHSSUlQuQKVfbiAR/8gY53Z5tZx6vVAid9og1Re150KAl75Q4+Pwl8aqC0YyYGo1Ts7H/cWua7cLnSGIbrQiGECmeKSjFrVywfRcs6kVrOEATpuxAjnwGby8JxZu2ezT24QXEaAMwYIs0DeuQ1pDJObUv0aIVhrruIIWinhRmyfpRIzdQ8oD+R+NM3cD438pmmQub3/M9HUhXDQv0XF/ZxUEMsORBI91pvxRHqRQkDRj5Kht0=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <077750D89E1A5C4B9C170FD55306B912@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67eef36-d9bb-45a7-bdc4-08d6d6c03fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 09:57:31.8708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, sw2 supplies vdd3p0 LDO, this patch assigns
corresponding power supply for vdd3p0 to avoid confusion by below log:

vdd3p0: supplied by regulator-dummy

With this patch, the power supply is more accurate:

vdd3p0: supplied by SW2

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No code change, just resend patch with correct encoding.
---
 arch/arm/boot/dts/imx6sll-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-=
evk.dts
index 4a31a41..78809ea 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -265,6 +265,10 @@
 	status =3D "okay";
 };
=20
+&reg_3p0 {
+	vin-supply =3D <&sw2_reg>;
+};
+
 &uart1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_uart1>;
--=20
2.7.4

