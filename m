Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F156821872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ksd4I/Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfCOAqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:46:50 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:8256
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfCOAqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKZbQGKmXMprG/U6J+8vXsk40x3k1U4ZvFk+bQ3EPQY=;
 b=ksd4I/Ws48SunXG//9nLx3LpzH55wrAFjtjUW0hFGzfD5kc9B8n/WF9x+iCZ2Q3bBmcS5JdQaRlk8bbRDse1YFZuuXUK97dJNt+TQd44jOvV2Xsgeu+Fm2eqvDauDmt3yk/+dwkazYpM66AtsPZsleL3X/LQ9E+f33qsGBM4sEQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3804.eurprd04.prod.outlook.com (52.134.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 15 Mar 2019 00:46:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:46:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
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
Subject: [PATCH V4 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V4 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU2siQrvk4PRDi4keBPA2qeE921w==
Date:   Fri, 15 Mar 2019 00:46:45 +0000
Message-ID: <1552610505-13568-2-git-send-email-Anson.Huang@nxp.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07e6bfb4-54b6-480f-443a-08d6a8dfb292
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3804;
x-ms-traffictypediagnostic: DB3PR0402MB3804:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3804;23:nk+p5Dh9tWyZ+mZK+jlIrJTRfVF62TUNNoIvk?=
 =?iso-8859-1?Q?9xSTz82HZxDzQomgCg6RYVkV6ZyXV8qpu44ciEXKGpLKtYyvLjvdlQi5+l?=
 =?iso-8859-1?Q?4wysx41ZQEpEGTqCj/y2HlCM3P5lEyK5Hp+SYO03/Kx1PnyxsdnvjbeNKo?=
 =?iso-8859-1?Q?U+qqzQzHcoPwA/2J+O99f4vDUTM6idJzy8nJ4njksPrHgC5wnqhkCtEtQp?=
 =?iso-8859-1?Q?oyegV+NJ/I/XwF/wkx7L84zV0Lu6VbUcPBt+Enh9Upar7fglYhoWSqNbvL?=
 =?iso-8859-1?Q?q5ZQYUI6ZZNDh0dTCTNodKvG6ydxLnkAGxIiRzLMd+tL9lY1sZzbvLfGC8?=
 =?iso-8859-1?Q?KSz6elN8TQZtrj3c+V8YMNqovwkDN/r8LUtdfc++KfbQlQsKkE/q3/oUGt?=
 =?iso-8859-1?Q?T/djXwIjCMteB6lZ4kLkikXaGg+N3NBBicz77mFMy1w+4q1Z/nPa0B3k/A?=
 =?iso-8859-1?Q?Zq9F8boNK3gIXMwx62Yg6B7/v9aQ/CA0L7KTWoZk1qxAERzZW8ywoKrr2j?=
 =?iso-8859-1?Q?IwtgDOpp59jJ9u15X7RX+eHzj6c2m2Lbngh5fUhOurPV/DisBgs2I8c7Fl?=
 =?iso-8859-1?Q?RXnQhtLoIaMw1106PqHdOQtfhh6w2zLoe0hiIeftZkUSqFtgkSIHvkE5Dm?=
 =?iso-8859-1?Q?5PvTLX6WQZguvOdg6fnnUBPzU0vZa0nw5eo4rNEWWJpi3JnAafxmZ3vGxU?=
 =?iso-8859-1?Q?hxamy93QedK/x77d/sDS4+AnltvvGMoS5nUVgrZdkXV/OHtF01qoPr8pyJ?=
 =?iso-8859-1?Q?eZbSXAEZ9so4nDTgwV7M1kYNPx0abz4kegv8ETw+dSah2cqH/xMH/BMcQ9?=
 =?iso-8859-1?Q?jLEVl7L3T+2yMeZXTlHyq8Y4s9Tf0qwmvERp5xrUX3AonEdv+9sKOj3jfa?=
 =?iso-8859-1?Q?OR2xB9p17g/ZYGLK/dpfrYvpKckm067J9AykGnCTMhlfXvFSAh12eCi6rl?=
 =?iso-8859-1?Q?bRBp7cwH1rMDVfUG3XciRqtR64NXHDehxKlC3CldVrVkW9dynDuNCUSCyG?=
 =?iso-8859-1?Q?yjr8UDlObAzCqUajKPd7Fps4RHpGV9EO9HmIdl9ohkn9p5s4RbSM/ZpXgq?=
 =?iso-8859-1?Q?KG0JEduAgM3OQXr0m5iD9GxJNaQ0enLe1dR15eXZs+9bGOAkVAI1iXDxC6?=
 =?iso-8859-1?Q?LiB00W1XBHfa8TScqnWIqZsOxjexOEy/sg3iG2p9mGwzdAerh6LZPZJA2X?=
 =?iso-8859-1?Q?2M+OlXxQCBwMwooxzGYeeDE5r17WYtWkam0o8TzIqvpeOf4uIxgi0zGCTZ?=
 =?iso-8859-1?Q?rvvhr8QuyTspaeMSopn8ZDOi/LL0rk3TY5euQ0kjQXimgBKRDnIcEdDthX?=
 =?iso-8859-1?Q?pt+o=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3804F0AC81D1931C7D5E595AF5440@DB3PR0402MB3804.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(11346002)(478600001)(102836004)(52116002)(97736004)(76176011)(105586002)(50226002)(7416002)(8936002)(81156014)(26005)(81166006)(2906002)(86362001)(186003)(8676002)(5660300002)(386003)(2201001)(6506007)(2501003)(3846002)(14454004)(446003)(256004)(25786009)(476003)(66066001)(2616005)(7736002)(305945005)(486006)(71190400001)(4326008)(6116002)(71200400001)(99286004)(6436002)(106356001)(110136005)(6486002)(36756003)(53936002)(6512007)(316002)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3804;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EERh1gnxCGwNsb/JcDwj7BZtUqzJPZlrpIkpZjJDTIiwvVEHT7B4xxPtfAIrvteL23DL9l8aJ5Cv0i1YUPAqDL6G7CzC9QiJA+g6T/C7779D0kRxIY7Bcx/clS176tHvd9P9qglQ5xoiIW4b3mlwbozJO+IVSrYFQPVAJGx3Hp0kBLJJ6L2/Y8V74AQ+JfCiCy4cv1Pu9e/6vItKqxvXEr56WJT9zupSa84B8LjXkeUkfwM8I6qxPQc+Hckao+PqkHIlIURLyVkrK+KfcN62F2hets4t+KS56XMkdD3XNoOq9v7AcctZ4SEyl2AxZOOWC6q6raOyQ1LRc+Do5YY9Z+Lz1Vujol3YhDRa9kGAS1OvFAJh1yd6CpwHALJ+mNMgFpMEeQzQfr8NDKv7qwm1AopdcFwBJYIdJVksZaiNHvM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e6bfb4-54b6-480f-443a-08d6a8dfb292
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:46:45.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
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

