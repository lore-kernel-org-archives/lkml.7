Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466FFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7F6217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wz7QAwnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfCNG2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:28:05 -0400
Received: from mail-eopbgr130045.outbound.protection.outlook.com ([40.107.13.45]:6118
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfCNG2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdPZdefMlR11EsR1dcFUJvBNlMnMCH+KCLCitU6k2ug=;
 b=wz7QAwnZr/U+Rc6V5Ai8MjRB3OfQZT9ikvdgrbfM+Tv8bV9L5SeSlMFDCRlSjz74lil4VWIYe4fot7F9WfOAQIRrVFWklwmjuN2h3s0T2vnzaW0Ud+FbFZ0tllidN8kFfBFSgBZAPM0wLwc//Lu7pSsBYSf/ITObyZSCclyV1HE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:14 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:14 +0000
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
Subject: [PATCH V3 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V3 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU2i72zzo0rb3VYkmOa+LAQ/I+7g==
Date:   Thu, 14 Mar 2019 06:27:13 +0000
Message-ID: <1552544534-5295-2-git-send-email-Anson.Huang@nxp.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b4bf22e-ee2b-4565-a579-08d6a84618a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:zdHCvWz+b+/i4G38SG4vT6ckOZcheKhmj4qJI?=
 =?iso-8859-1?Q?GhURAAnsxCpzZiMLjIEO7/usYQgef9n6vIXW8mwFYB92dpEV6tCx5Bzdm/?=
 =?iso-8859-1?Q?tvm0UMuuhLz1MftPzxckulRS47Ais76nVVa3xiTjIgAPr87mWYq9vJDPXt?=
 =?iso-8859-1?Q?7z8OfeeBx2XteFhDDweBNmPfdkQ8m9Bu1yVSfXJHktQJ9voUkor313cBiV?=
 =?iso-8859-1?Q?bvfVmkwUe6xI1ExZWXCOQJjG6wjFUUxx9MG5fxUNVNmD3CnxAUVxdYsoDN?=
 =?iso-8859-1?Q?fHfW9GrAH9kKPDCjA74iLPUB1CWft22qXP0qDv7LS/nnyrrW53ln9guheO?=
 =?iso-8859-1?Q?0h1jN3Bp/6BttY/AhpMSCZ1Hw+3+G7I1Kpo45mRHu4ODC3vhmmWq3XgKWh?=
 =?iso-8859-1?Q?Snte/52XsmrDpWHFXxiBEHQE23y4CbYhfIquhL2ciqbQ4qu6ObNuDiCBsm?=
 =?iso-8859-1?Q?89ticI1mCdGIaJSPl2SxRbWjjuZQntZJxQdZmxE8EfKX3pVZhtCaIPNZy9?=
 =?iso-8859-1?Q?mPF4J0w/DIGYFigm+GESNJNZM3oz2IO60X6WfeTqwFybT/xB76nshDlaE1?=
 =?iso-8859-1?Q?zlVZub9rNTjtpTPgwJA8kO5OfMLhsCgOXCRGVZCfoYYB0K5NLCs0HOhSDE?=
 =?iso-8859-1?Q?QuSUfziyJxnSE3gLTi+rCW2E7VQ+zDc2EsJUhB4qHm+rmasBAjJlz7TdwQ?=
 =?iso-8859-1?Q?OFYs4dFOxepOR41VNfIMPjCL+k+X1EIn4ba8IPTDTaL2U2XlajRtIuVih4?=
 =?iso-8859-1?Q?wziLrUBWHnNL1bpPP+1piNc8302axKAAnYdX8hrpZERaZpjLDoLjvSIvmc?=
 =?iso-8859-1?Q?gS8pWhr+ScCXLUyJAoQzSjp8flz3WqhE1GwJdHd098NA08eRA70XhKR72D?=
 =?iso-8859-1?Q?oEPfY9L/EuP6fsm9rOgomq1Z5khnk6uP+C6aPBG1b+UQk7e/P5c/jr2iht?=
 =?iso-8859-1?Q?vTlQHJxquMpXosN2SEisqpWLWPcUkDy8MK8Jq2SyxA0DcRmDfUrroe3b87?=
 =?iso-8859-1?Q?BzDbuW29s42uYKvq3eRzVvtz0hQNlrXQJ70qVO9LqgKRkBdTxkyGNYXoxR?=
 =?iso-8859-1?Q?EYjvjy997+K6Ep/ygUlqjuCnkkCBTqYWgSqA3FJ8mO4eqVjDfk3Ldenx74?=
 =?iso-8859-1?Q?cJnTiB0EMjI4TibDuGmq/uI9DKzZo/bgXf9z7SJ8AmtOq8lCMAZBF23EZG?=
 =?iso-8859-1?Q?1/HBQvUgu4qkGDa1MGXpExM+G1rzt2X2TAvyr4TmQ8jdnNb4V2KI/pXUpm?=
 =?iso-8859-1?Q?U94NN/m9H3rBFlx1QbMutoI6bEF4bycooWIOGhZg6SVjBVKjq51qgjjmYl?=
 =?iso-8859-1?Q?oNSc=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707D8462CF14BACDD803574F54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(8676002)(102836004)(386003)(446003)(81166006)(11346002)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1aAi7PB6irw/SCxZRSIHjg6+kPToBo9kJmEwaRXuKmp5O8b/t1RUsiPEAbtRJo7jn7sFnyUywB730rKv/ZRDZwzh28CorOhgR5wyfnPJuSeFqGEFcx/e5x/Lrji9SUHYoCHdqi2fKVS88PJrP8y2IRx16W+cqjqocLVlmZHQwmp5xh+dJpIWmV6PeDZKi/48lVGouvRwB04qzx0fDZAU4z9kh8iUNRbepTY78KWIsRHo+tyyultG4njedGbuKH2DW4rOROQ+Fi7q7XfwD6gqphZf1f7dV9OrRAWFz85A4K8No8wENuVqrMdrRXykpFyEVfN234xjQwUO/Tb8EYTQVVWDlYAIuaFi4yIWTuf8cqLu7S1cUkNzDeJz/kcwDcHrwYlqWaRPN3T7KUCC6x3JEUSFXz3peRDKx51zTkSscJ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4bf22e-ee2b-4565-a579-08d6a84618a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:13.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
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

