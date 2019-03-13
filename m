Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB3F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+R/nyIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCMHbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:31:13 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:47009
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfCMHbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZwNtO3Do0nWx1TSfgkL+POMPkC8qXWsQS+BiNqZ/AQ=;
 b=X+R/nyItfmg5CRlSucThzrYQv9dkfsDUlhqYnW+WRhOtf8SLCm9ni5XQ1CNzg0iGw78IElYFfbfAXvVgxT+2tnOo4TkPkP51SFakQ7Csi/ynCcewk9mcQhCkdGL92LVNeotrPy/Dxa+Kjw6rSb7MVRE1pOOKbSWm3T5TkKkDnLY=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3768.eurprd04.prod.outlook.com (52.133.30.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 07:31:09 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 07:31:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V2 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU2W66swSo6p9+PE210IiJ5APc7Q==
Date:   Wed, 13 Mar 2019 07:31:09 +0000
Message-ID: <1552461970-20813-2-git-send-email-Anson.Huang@nxp.com>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd694d1-4bd5-4259-acc4-08d6a785dc42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3768;
x-ms-traffictypediagnostic: AM6PR0402MB3768:
x-microsoft-antispam-prvs: <AM6PR0402MB3768B28A6DA7CB6AC47F87C8F54A0@AM6PR0402MB3768.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(2501003)(26005)(102836004)(6486002)(110136005)(316002)(478600001)(186003)(4326008)(71200400001)(71190400001)(53936002)(8936002)(50226002)(2201001)(81156014)(8676002)(81166006)(97736004)(7416002)(68736007)(386003)(6506007)(52116002)(14454004)(76176011)(305945005)(7736002)(486006)(256004)(476003)(11346002)(86362001)(446003)(2616005)(66066001)(106356001)(2906002)(25786009)(6116002)(3846002)(99286004)(6512007)(5660300002)(6436002)(105586002)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3768;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 33aTIxSiksZSTJOIKLPsr2UBi/bkNr2GtugWbAYbBNGwicb2/Wm4Jea2Xoz+01OpKIIPXcW2VATCrWHlkZYOAiQ6rkzHhCgLBZN9lXRONjR/qZiqVRZd8e/yUFbAi7BMVZXUlUM6qUCzCPPE7Rm9ivGCg7+GMp8TNqxTgokqAI5bDuaNwCoHxcrsDT8SkgNoVC0WNUU7Hp9tjA6At9ualnsvDuEzTuEBk4J5WmpjL6J0Jk3UXoRdX3slRJtN6/wS6UMOwE6TbGBBVteH966ZndJ+OTyQXZspk7/pP0nYqoYz21DJ2i5fWSzPWtmxpwdh/ywVivSidHQbwNc8UM7wy6gqmJmY+5PQF1WfmgAfN5PPTVJbtNspOypDEGlCQE2/YpVbGilGXB+7a0VWHu8YSIMuCevp/ogv1B7fANXOnDQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd694d1-4bd5-4259-acc4-08d6a785dc42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 07:31:09.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- remove optional property which is no need now.
---
 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++++=
++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docume=
ntation/devicetree/bindings/pwm/imx-tpm-pwm.txt
new file mode 100644
index 0000000..d47b8fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
@@ -0,0 +1,19 @@
+Freescale i.MX TPM PWM controller
+
+Required properties:
+- compatible : Should be "fsl,imx-tpm-pwm".
+- reg: Physical base address and length of the controller's registers.
+- #pwm-cells: Should be 2. See pwm.txt in this directory for a description=
 of the cells format.
+- clocks : The clock provided by the SoC to drive the PWM.
+- interrupts: The interrupt for the pwm controller.
+
+Example:
+
+pwm0: tpm@40250000 {
+	compatible =3D "fsl,imx-tpm-pwm";
+	reg =3D <0x40250000 0x1000>;
+	assigned-clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	assigned-clock-parents =3D <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
+	clocks =3D <&clks IMX7ULP_CLK_LPTPM4>;
+	#pwm-cells =3D <2>;
+};
--=20
2.7.4

