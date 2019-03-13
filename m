Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19C32183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sL1OT3yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfCMHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:32:18 -0400
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:57349
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfCMHcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F16qKkq27PUkv2mytfwDOBCR6Hst18PTjrgxPcdplU=;
 b=sL1OT3yf+Jhq33VvFCrfZ6qufkf6o5QZgMtq5+eIMPnhppt1T10dzQryYiwoOQuNRIRY3oGT4VVQtgZi+CbDG5TePm6d5qBIJhtAhBYSmKqyXRtcQKAgzN4kZQFlg/JSYUnJSCdvwzO7bFFIzOYnVeC9GjS5ddNLPHUntPvfXZE=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3925.eurprd04.prod.outlook.com (52.133.30.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 07:31:37 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::e052:f2d5:93f2:5f52%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 07:31:37 +0000
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
Subject: [PATCH V2 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V2 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU2W7KsW8qPScOBE6LRVbeC2PIpQ==
Date:   Wed, 13 Mar 2019 07:31:36 +0000
Message-ID: <1552461970-20813-6-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: db31062a-c1ad-4a20-eba8-08d6a785ecbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3925;
x-ms-traffictypediagnostic: AM6PR0402MB3925:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR0402MB3925;23:2YOf5uu8KVIryMJWAIIgJzb/m7dLqBesziCWO?=
 =?iso-8859-1?Q?ZwYdaMGJwwlfPHWYprqWRSwK8vSinjluZvh9d1ZUiVDlMu0oTMiOJ12X90?=
 =?iso-8859-1?Q?FAAZPkM/z2mT4WiIgj9hovTQ4TntCXIBzexRpPOt7qYoWJ37PaP3NSNmRe?=
 =?iso-8859-1?Q?r/oEu9PABbS3JQ+qtCG8t/4av9k649RfT18Hi/dBPuvktDyPIgpLfyR14V?=
 =?iso-8859-1?Q?Eob+cWiEVAVFhgmLcaK6Lt0MZO/xxzAZq1wQGprc0ay7YB8lKXGDSp3E6O?=
 =?iso-8859-1?Q?gkdLhkPojtghlyTX0gsTAPwv8KYGsMFst1LwUAzUxuXVt7NTsvcKl2Tytx?=
 =?iso-8859-1?Q?GE0cqvpNc+weeVYqL2XA03ohLko4PkS0jyiVLhounp97z1T4FCfCD+eRio?=
 =?iso-8859-1?Q?lnhhvgabc/xnoyFH3fVddzB1s3/ug3h2kx9Qa4cCykUn4VUzf69PQ/ao9y?=
 =?iso-8859-1?Q?zBEoz8F6VzXFGbSgVaG9WmXtJUjh3cFJE3Z8Eu/vzxbRilPFzJajFJMztT?=
 =?iso-8859-1?Q?NCrzS7Q7yQfdYA6TDgEDyXNaBvO7vpmtTfnYGWaJHfxM50y+UaE5Kiomz4?=
 =?iso-8859-1?Q?MzDQsIcmzTfVoF3JytMZcDQdKmykUDD83y7KxPpW5BAVv8nEopyJ3nk+eT?=
 =?iso-8859-1?Q?byqRTfC87KO+jcbV91Rd/cONJo44eDORIIIOpfNuyXl7VaVV1qZ5v6/ftS?=
 =?iso-8859-1?Q?N2jLu1MrGWtWLQUD+P7yIltulJcp1Nbi58+710npB7ikhGFKU+gPMYdqKn?=
 =?iso-8859-1?Q?rlt+2/oL5qqbkRxdyCE8/fWr3T0u0F9BlStU0vKe1WGN4rflcYMeY3tieQ?=
 =?iso-8859-1?Q?MFcdHay2lP58TOWHhorJzX9gQsmton5MNI5ECJk8qWuAgxDPOes63nhopR?=
 =?iso-8859-1?Q?HCyaQ0eYPHs5OCQRXt3sEQ7rDhWZDMMLOY4aHP+oLZsgh7Bjxevm2cZY7C?=
 =?iso-8859-1?Q?zMb8Jghkj2kvVqiNxnIB3MMBKJlT3e6F4V+29tv25GoolTzO0E3WuN9x4h?=
 =?iso-8859-1?Q?nTh8Kkkw/aVtZwEZYRPcuHRS85COsPt9sbP8ndufuW3eEiVJ2+EtBovXh8?=
 =?iso-8859-1?Q?k3WD73Pjf6hZRcBe07JOqJ1ZkkeZrjNouzJkRPnfrpOFVkMS2F6jD94He5?=
 =?iso-8859-1?Q?csDZNgTVG2RmM+w7NQU9NzB8x4IZ6K/C46Cgzj+duyJcMqEjEb40fGjzdr?=
 =?iso-8859-1?Q?In/nOW9/TJ8oAQ4T1unjl+DUkj4ZZu5zdVD1obsOSD1vvp1/n+ZsxX5V3i?=
 =?iso-8859-1?Q?pPOYXreMm4wa/Ntvv+iJ5uqniz620gzfrz2LKYGuJ0YJgT8MVPu5fGEZTh?=
 =?iso-8859-1?Q?7nkdKB5SrvXkZOr5kvIrK1DyM?=
x-microsoft-antispam-prvs: <AM6PR0402MB392546885BD373BE368F0D0EF54A0@AM6PR0402MB3925.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(2201001)(2906002)(50226002)(8936002)(86362001)(97736004)(110136005)(8676002)(53936002)(2501003)(52116002)(5660300002)(316002)(105586002)(102836004)(6116002)(3846002)(81166006)(386003)(6506007)(76176011)(81156014)(446003)(305945005)(71200400001)(11346002)(71190400001)(66066001)(478600001)(2616005)(476003)(36756003)(186003)(6436002)(4744005)(26005)(106356001)(6486002)(68736007)(25786009)(4326008)(7736002)(6512007)(99286004)(14454004)(486006)(256004)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3925;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FFPG4Uuw9N/wifBKzABBxLMKgBsBjAaTZkBtrr1rROGtxjXAbuOs2yabhg8IS5guZt8OytKs/JFBvSNth0+xDVDjyJYnIwjTlZH0FqUac+r1BgIlkTDhHN4QdtnwQ0CCDo6JiZEXx7DZPUC2LHS35wrQjahBwy2qLqYaxuRpBPo/9m3wxrUYQsERodtQvbBkV44kJWVGDUfmH2OkkUrvIYMtQ1ew386DXcP+WuYs+FLReSfjvHq9gjZGnzDTckCV/WfuU9ysfsuyixy5MdcheYimcSlnuQTANdxLl6bAGtTCehnfDeJw9dEoIfMr5dQfN84XMr411wUcNiDk52hmCfq6e6eetcZ8GwCnjVMWnS6yuVgzZyRJn083wM/0bvrQRUqM24S9VflSWzR1hJA0poc3x2GiWyTrOVzG+BpzIDs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db31062a-c1ad-4a20-eba8-08d6a785ecbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 07:31:36.9337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7ULP EVK board MIPI-DSI backlight
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index 3f5ea18..f90f2f3 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -22,6 +22,14 @@
 		reg =3D <0x60000000 0x40000000>;
 	};
=20
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&pwm0 1 50000>;
+		brightness-levels =3D <0 20 25 30 35 40 100>;
+		default-brightness-level =3D <6>;
+		status =3D "okay";
+	};
+
 	reg_vsd_3v3: regulator-vsd-3v3 {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "VSD_3V3";
--=20
2.7.4

