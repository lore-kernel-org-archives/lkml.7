Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB72082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWu9sxdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCEJvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:51:13 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:18277
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727317AbfCEJvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6znYDt6lPM7W+JTK6Pw3vVlv7AHOEik8BzXciQoy14=;
 b=eWu9sxdg3Ci3In2zxdf8TytuUk7G5g97u6q6JkWmP93NyyXemISf/v2o8ThTBNTP6JMgKfHpipymTtgP7XjlUe69zc0qJg3bGXFfLZLrn9fNv7wSJkqCp0EgI8jf+CXJpf3/+Jg/EFdVODLg2EQKv6fIlHRprj+LxGgwnhPDpSI=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5745.eurprd04.prod.outlook.com (20.178.118.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.17; Tue, 5 Mar 2019 09:49:16 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 09:49:16 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Patrick Wildt <patrick@blueri.se>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps
Thread-Topic: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Thread-Index: AQHU0ziyUrOqOGzNAUGITeZr+qRjmg==
Date:   Tue, 5 Mar 2019 09:49:16 +0000
Message-ID: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:69::30) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1ff736c-9b6b-4a3b-669a-08d6a14fd4e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5745;
x-ms-traffictypediagnostic: AM0PR04MB5745:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5745;23:9LZaaZ4xUBZhlwasTMYHu5uGvFWJXsg/2rGxHc7?=
 =?iso-8859-1?Q?fImaA+Z4tOEBXjgYFqJ+x9haoFegtvOKBAaZH2yPekDh6BWug//QZl4kM9?=
 =?iso-8859-1?Q?NLJHcuXxwl4wf8+insHA2wqgUajfDhAdkDUJzyg2MG3GB7lJzsKFYQf4Ek?=
 =?iso-8859-1?Q?PK7I1HdQiO3h9pPExj7qPLEE7RsLgRp1eGuxJKZ/RyxOFFFmWzQGPtLCCP?=
 =?iso-8859-1?Q?k/Fq2GQtGXOkXd0gvgYu+FMkW7Dz3Mz7iCcpl6o/nt2xkViVOKNFRfxMWh?=
 =?iso-8859-1?Q?vSJkCvHyzAngA1xnRxobNbYZKLbF1doaHStvZ200NN0kdYAetvZvrCpumC?=
 =?iso-8859-1?Q?3C80jw6MjZCZaZfjKNQCaETk/r8R8KS60f4dX7Nq9rjkEl2kwnaUkoYHg/?=
 =?iso-8859-1?Q?xLeQGsFu48q3OSBd0fzeK45l1TTnknhzy7TBeatOYMyo+NZD5dSt0Zmb04?=
 =?iso-8859-1?Q?kunS1ajD//KZJ078yXgHJHOpzifecbhEJvTdyL/XQBCUi/xt9+N4dLVFR9?=
 =?iso-8859-1?Q?ZR4XO8Xb+wZ5JwIz1uX6duXs7oRjW7k3X06xhAuAf0jdrdmg6ZkQEQtby1?=
 =?iso-8859-1?Q?1SYoRwBjjP41J5w41VHbugHA+HPuPGIe0YwAkX+8ibGgQ/MiSrrXuqVvYX?=
 =?iso-8859-1?Q?A5KvNOOoTXDDXgEb6SxHoCl4BfsI2sEG+PkMWjSZRwU9RaMHPwSSgPZCYA?=
 =?iso-8859-1?Q?71xbFOBRnGJHLfelv4URr46k4+TRabu6H3O/5qwwwAsZKTD+XOekxZ07iu?=
 =?iso-8859-1?Q?8JBzY1jJa4jIo6WnTdqbhEVrQLBbGUlYE1sHji3QAEYdZcKpSjP4DBTj31?=
 =?iso-8859-1?Q?VFYeno9E8OGkTGKejGFCFg5F/TArJ7KF8B+qf3FL6t5f71kaesqBljG3Ih?=
 =?iso-8859-1?Q?jNGLcceGi5ALHbMrDxivEkl4ULr3H62FJNdGWqc/OiqdgbwTC2s/5DCNor?=
 =?iso-8859-1?Q?ATLrYW+gQC6KPGDkv2pUH76Zz4avb+y+M9Uvfyf3nb13XL+uvGPDlF9WVx?=
 =?iso-8859-1?Q?KwNN9A//DjS5jIRDLRHzF5rT/vk2q8iLYZZxiG9ZYRrryztnfBCEIoV+bG?=
 =?iso-8859-1?Q?qvod0Zx4DP2uWoWm9yRBC5YUuejI5UtgKzkZ9MUsIzr2tNamXfci6HYL5s?=
 =?iso-8859-1?Q?lbWAmcCpQG4OonzjdMD3i1A7NCVnx9jUJg5VVHtQDSMjzWgkRrmhtB/ztt?=
 =?iso-8859-1?Q?o5n1XDj05+b3NF05+a0ezJRNzIkYSh5EpOPCnXMTlzj2+h3zCF+9QoWuzF?=
 =?iso-8859-1?Q?gVakWHdADDr6wxhcK?=
x-microsoft-antispam-prvs: <AM0PR04MB5745BA9B6B8BB2678CBE15DBF6720@AM0PR04MB5745.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(7416002)(71200400001)(71190400001)(6486002)(316002)(106356001)(54906003)(105586002)(68736007)(256004)(50226002)(2906002)(36756003)(7736002)(8936002)(81166006)(305945005)(8676002)(81156014)(110136005)(97736004)(53936002)(44832011)(52116002)(186003)(5660300002)(26005)(66066001)(486006)(99286004)(6116002)(476003)(2616005)(6512007)(478600001)(6636002)(6436002)(102836004)(3846002)(14454004)(6506007)(25786009)(86362001)(4326008)(386003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5745;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: knCnEYteBQMujGuhKd5VuYILnLDVT7QRJkhOgUEKUw4oztqfB4e0l2cXuOnPhSUG8GdBCTVCy/QSo1EeMlauY3jqFP0BOSg5vNtQGVX/dayXY8HCZpNo08GCOz980YKBnw4JYEeOOZjm9KbILccHKx2x7b24OI3PktHMo/FH9NQf/q15wMiDNY2GogtDgwxFYgAPmEQxFrtkAw19kjVYTDfOLgjNCE9hONUAAyfypAJ/0Og0NANTkrE69L9NfbadPhS/j867Eqx38lcXJTShxFtdBMOucLZN036hRz4xNXPbIOxguUhDU0huEbeFrVBWRZotCnCXv0qQDI9MbR5FhZ7u+mT3h5g+MzC+LbOA978Z3DNAhtAWQwOCwel+cVaHEi0Ykt0Fj8eYx4W7aBi5VzAFKLMpN5NfCTH3VDCyors=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ff736c-9b6b-4a3b-669a-08d6a14fd4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 09:49:16.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX8MQ_CLK_USB_PHY_REF changes from 163 to 153, this way removing the gap.
All the following clock ids are now decreased by 10 to keep the numbering
right. Doing this, the IMX8MQ_CLK_CSI2_CORE is not overlapped with
IMX8MQ_CLK_GPT1 anymore. IMX8MQ_CLK_GPT1_ROOT changes from 193 to 183 and
all the following ids are updated accordingly.

Reported-by: Patrick Wildt <patrick@blueri.se>
Fixes: 1cf3817b ("dt-bindings: Add binding for i.MX8MQ CCM")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/clock/imx8mq-clock.h | 220 +++++++++++++++------------=
----
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index b58cc64..6677e92 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -245,160 +245,160 @@
 /* USB_CORE_REF */
 #define IMX8MQ_CLK_USB_CORE_REF		152
 /* USB_PHY_REF */
-#define IMX8MQ_CLK_USB_PHY_REF		163
+#define IMX8MQ_CLK_USB_PHY_REF		153
 /* ECSPI1 */
-#define IMX8MQ_CLK_ECSPI1		164
+#define IMX8MQ_CLK_ECSPI1		154
 /* ECSPI2 */
-#define IMX8MQ_CLK_ECSPI2		165
+#define IMX8MQ_CLK_ECSPI2		155
 /* PWM1 */
-#define IMX8MQ_CLK_PWM1			166
+#define IMX8MQ_CLK_PWM1			156
 /* PWM2 */
-#define IMX8MQ_CLK_PWM2			167
+#define IMX8MQ_CLK_PWM2			157
 /* PWM3 */
-#define IMX8MQ_CLK_PWM3			168
+#define IMX8MQ_CLK_PWM3			158
 /* PWM4 */
-#define IMX8MQ_CLK_PWM4			169
+#define IMX8MQ_CLK_PWM4			159
 /* GPT1 */
-#define IMX8MQ_CLK_GPT1			170
+#define IMX8MQ_CLK_GPT1			160
 /* WDOG */
-#define IMX8MQ_CLK_WDOG			171
+#define IMX8MQ_CLK_WDOG			161
 /* WRCLK */
-#define IMX8MQ_CLK_WRCLK		172
+#define IMX8MQ_CLK_WRCLK		162
 /* DSI_CORE */
-#define IMX8MQ_CLK_DSI_CORE		173
+#define IMX8MQ_CLK_DSI_CORE		163
 /* DSI_PHY */
-#define IMX8MQ_CLK_DSI_PHY_REF		174
+#define IMX8MQ_CLK_DSI_PHY_REF		164
 /* DSI_DBI */
-#define IMX8MQ_CLK_DSI_DBI		175
+#define IMX8MQ_CLK_DSI_DBI		165
 /*DSI_ESC */
-#define IMX8MQ_CLK_DSI_ESC		176
+#define IMX8MQ_CLK_DSI_ESC		166
 /* CSI1_CORE */
-#define IMX8MQ_CLK_CSI1_CORE		177
+#define IMX8MQ_CLK_CSI1_CORE		167
 /* CSI1_PHY */
-#define IMX8MQ_CLK_CSI1_PHY_REF		178
+#define IMX8MQ_CLK_CSI1_PHY_REF		168
 /* CSI_ESC */
-#define IMX8MQ_CLK_CSI1_ESC		179
+#define IMX8MQ_CLK_CSI1_ESC		169
 /* CSI2_CORE */
 #define IMX8MQ_CLK_CSI2_CORE		170
 /* CSI2_PHY */
-#define IMX8MQ_CLK_CSI2_PHY_REF		181
+#define IMX8MQ_CLK_CSI2_PHY_REF		171
 /* CSI2_ESC */
-#define IMX8MQ_CLK_CSI2_ESC		182
+#define IMX8MQ_CLK_CSI2_ESC		172
 /* PCIE2_CTRL */
-#define IMX8MQ_CLK_PCIE2_CTRL		183
+#define IMX8MQ_CLK_PCIE2_CTRL		173
 /* PCIE2_PHY */
-#define IMX8MQ_CLK_PCIE2_PHY		184
+#define IMX8MQ_CLK_PCIE2_PHY		174
 /* PCIE2_AUX */
-#define IMX8MQ_CLK_PCIE2_AUX		185
+#define IMX8MQ_CLK_PCIE2_AUX		175
 /* ECSPI3 */
-#define IMX8MQ_CLK_ECSPI3		186
+#define IMX8MQ_CLK_ECSPI3		176
=20
 /* CCGR clocks */
-#define IMX8MQ_CLK_A53_ROOT			187
-#define IMX8MQ_CLK_DRAM_ROOT			188
-#define IMX8MQ_CLK_ECSPI1_ROOT			189
+#define IMX8MQ_CLK_A53_ROOT			177
+#define IMX8MQ_CLK_DRAM_ROOT			178
+#define IMX8MQ_CLK_ECSPI1_ROOT			179
 #define IMX8MQ_CLK_ECSPI2_ROOT			180
 #define IMX8MQ_CLK_ECSPI3_ROOT			181
 #define IMX8MQ_CLK_ENET1_ROOT			182
-#define IMX8MQ_CLK_GPT1_ROOT			193
-#define IMX8MQ_CLK_I2C1_ROOT			194
-#define IMX8MQ_CLK_I2C2_ROOT			195
-#define IMX8MQ_CLK_I2C3_ROOT			196
-#define IMX8MQ_CLK_I2C4_ROOT			197
-#define IMX8MQ_CLK_M4_ROOT			198
-#define IMX8MQ_CLK_PCIE1_ROOT			199
-#define IMX8MQ_CLK_PCIE2_ROOT			200
-#define IMX8MQ_CLK_PWM1_ROOT			201
-#define IMX8MQ_CLK_PWM2_ROOT			202
-#define IMX8MQ_CLK_PWM3_ROOT			203
-#define IMX8MQ_CLK_PWM4_ROOT			204
-#define IMX8MQ_CLK_QSPI_ROOT			205
-#define IMX8MQ_CLK_SAI1_ROOT			206
-#define IMX8MQ_CLK_SAI2_ROOT			207
-#define IMX8MQ_CLK_SAI3_ROOT			208
-#define IMX8MQ_CLK_SAI4_ROOT			209
-#define IMX8MQ_CLK_SAI5_ROOT			210
-#define IMX8MQ_CLK_SAI6_ROOT			212
-#define IMX8MQ_CLK_UART1_ROOT			213
-#define IMX8MQ_CLK_UART2_ROOT			214
-#define IMX8MQ_CLK_UART3_ROOT			215
-#define IMX8MQ_CLK_UART4_ROOT			216
-#define IMX8MQ_CLK_USB1_CTRL_ROOT		217
-#define IMX8MQ_CLK_USB2_CTRL_ROOT		218
-#define IMX8MQ_CLK_USB1_PHY_ROOT		219
-#define IMX8MQ_CLK_USB2_PHY_ROOT		220
-#define IMX8MQ_CLK_USDHC1_ROOT			221
-#define IMX8MQ_CLK_USDHC2_ROOT			222
-#define IMX8MQ_CLK_WDOG1_ROOT			223
-#define IMX8MQ_CLK_WDOG2_ROOT			224
-#define IMX8MQ_CLK_WDOG3_ROOT			225
-#define IMX8MQ_CLK_GPU_ROOT			226
-#define IMX8MQ_CLK_HEVC_ROOT			227
-#define IMX8MQ_CLK_AVC_ROOT			228
-#define IMX8MQ_CLK_VP9_ROOT			229
-#define IMX8MQ_CLK_HEVC_INTER_ROOT		230
-#define IMX8MQ_CLK_DISP_ROOT			231
-#define IMX8MQ_CLK_HDMI_ROOT			232
-#define IMX8MQ_CLK_HDMI_PHY_ROOT		233
-#define IMX8MQ_CLK_VPU_DEC_ROOT			234
-#define IMX8MQ_CLK_CSI1_ROOT			235
-#define IMX8MQ_CLK_CSI2_ROOT			236
-#define IMX8MQ_CLK_RAWNAND_ROOT			237
-#define IMX8MQ_CLK_SDMA1_ROOT			238
-#define IMX8MQ_CLK_SDMA2_ROOT			239
-#define IMX8MQ_CLK_VPU_G1_ROOT			240
-#define IMX8MQ_CLK_VPU_G2_ROOT			241
+#define IMX8MQ_CLK_GPT1_ROOT			183
+#define IMX8MQ_CLK_I2C1_ROOT			184
+#define IMX8MQ_CLK_I2C2_ROOT			185
+#define IMX8MQ_CLK_I2C3_ROOT			186
+#define IMX8MQ_CLK_I2C4_ROOT			187
+#define IMX8MQ_CLK_M4_ROOT			188
+#define IMX8MQ_CLK_PCIE1_ROOT			189
+#define IMX8MQ_CLK_PCIE2_ROOT			190
+#define IMX8MQ_CLK_PWM1_ROOT			191
+#define IMX8MQ_CLK_PWM2_ROOT			192
+#define IMX8MQ_CLK_PWM3_ROOT			193
+#define IMX8MQ_CLK_PWM4_ROOT			194
+#define IMX8MQ_CLK_QSPI_ROOT			195
+#define IMX8MQ_CLK_SAI1_ROOT			196
+#define IMX8MQ_CLK_SAI2_ROOT			197
+#define IMX8MQ_CLK_SAI3_ROOT			198
+#define IMX8MQ_CLK_SAI4_ROOT			199
+#define IMX8MQ_CLK_SAI5_ROOT			200
+#define IMX8MQ_CLK_SAI6_ROOT			201
+#define IMX8MQ_CLK_UART1_ROOT			202
+#define IMX8MQ_CLK_UART2_ROOT			203
+#define IMX8MQ_CLK_UART3_ROOT			204
+#define IMX8MQ_CLK_UART4_ROOT			205
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		206
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		207
+#define IMX8MQ_CLK_USB1_PHY_ROOT		208
+#define IMX8MQ_CLK_USB2_PHY_ROOT		209
+#define IMX8MQ_CLK_USDHC1_ROOT			210
+#define IMX8MQ_CLK_USDHC2_ROOT			211
+#define IMX8MQ_CLK_WDOG1_ROOT			212
+#define IMX8MQ_CLK_WDOG2_ROOT			213
+#define IMX8MQ_CLK_WDOG3_ROOT			214
+#define IMX8MQ_CLK_GPU_ROOT			215
+#define IMX8MQ_CLK_HEVC_ROOT			216
+#define IMX8MQ_CLK_AVC_ROOT			217
+#define IMX8MQ_CLK_VP9_ROOT			218
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		219
+#define IMX8MQ_CLK_DISP_ROOT			220
+#define IMX8MQ_CLK_HDMI_ROOT			221
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		222
+#define IMX8MQ_CLK_VPU_DEC_ROOT			223
+#define IMX8MQ_CLK_CSI1_ROOT			224
+#define IMX8MQ_CLK_CSI2_ROOT			225
+#define IMX8MQ_CLK_RAWNAND_ROOT			226
+#define IMX8MQ_CLK_SDMA1_ROOT			227
+#define IMX8MQ_CLK_SDMA2_ROOT			228
+#define IMX8MQ_CLK_VPU_G1_ROOT			229
+#define IMX8MQ_CLK_VPU_G2_ROOT			230
=20
 /* SCCG PLL GATE */
-#define IMX8MQ_SYS1_PLL_OUT			242
-#define IMX8MQ_SYS2_PLL_OUT			243
-#define IMX8MQ_SYS3_PLL_OUT			244
-#define IMX8MQ_DRAM_PLL_OUT			245
-
-#define IMX8MQ_GPT_3M_CLK			246
-
-#define IMX8MQ_CLK_IPG_ROOT			247
-#define IMX8MQ_CLK_IPG_AUDIO_ROOT		248
-#define IMX8MQ_CLK_SAI1_IPG			249
-#define IMX8MQ_CLK_SAI2_IPG			250
-#define IMX8MQ_CLK_SAI3_IPG			251
-#define IMX8MQ_CLK_SAI4_IPG			252
-#define IMX8MQ_CLK_SAI5_IPG			253
-#define IMX8MQ_CLK_SAI6_IPG			254
+#define IMX8MQ_SYS1_PLL_OUT			231
+#define IMX8MQ_SYS2_PLL_OUT			232
+#define IMX8MQ_SYS3_PLL_OUT			233
+#define IMX8MQ_DRAM_PLL_OUT			234
+
+#define IMX8MQ_GPT_3M_CLK			235
+
+#define IMX8MQ_CLK_IPG_ROOT			236
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		237
+#define IMX8MQ_CLK_SAI1_IPG			238
+#define IMX8MQ_CLK_SAI2_IPG			239
+#define IMX8MQ_CLK_SAI3_IPG			240
+#define IMX8MQ_CLK_SAI4_IPG			241
+#define IMX8MQ_CLK_SAI5_IPG			242
+#define IMX8MQ_CLK_SAI6_IPG			243
=20
 /* DSI AHB/IPG clocks */
 /* rxesc clock */
-#define IMX8MQ_CLK_DSI_AHB			255
+#define IMX8MQ_CLK_DSI_AHB			244
 /* txesc clock */
-#define IMX8MQ_CLK_DSI_IPG_DIV                  256
+#define IMX8MQ_CLK_DSI_IPG_DIV                  245
=20
-#define IMX8MQ_CLK_TMU_ROOT			257
+#define IMX8MQ_CLK_TMU_ROOT			246
=20
 /* Display root clocks */
-#define IMX8MQ_CLK_DISP_AXI_ROOT		258
-#define IMX8MQ_CLK_DISP_APB_ROOT		259
-#define IMX8MQ_CLK_DISP_RTRM_ROOT		260
+#define IMX8MQ_CLK_DISP_AXI_ROOT		247
+#define IMX8MQ_CLK_DISP_APB_ROOT		248
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		249
=20
-#define IMX8MQ_CLK_OCOTP_ROOT			261
+#define IMX8MQ_CLK_OCOTP_ROOT			250
=20
-#define IMX8MQ_CLK_DRAM_ALT_ROOT		262
-#define IMX8MQ_CLK_DRAM_CORE			263
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		251
+#define IMX8MQ_CLK_DRAM_CORE			252
=20
-#define IMX8MQ_CLK_MU_ROOT			264
-#define IMX8MQ_VIDEO2_PLL_OUT			265
+#define IMX8MQ_CLK_MU_ROOT			253
+#define IMX8MQ_VIDEO2_PLL_OUT			254
=20
-#define IMX8MQ_CLK_CLKO2			266
+#define IMX8MQ_CLK_CLKO2			255
=20
-#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	256
=20
-#define IMX8MQ_CLK_CLKO1			268
-#define IMX8MQ_CLK_ARM				269
+#define IMX8MQ_CLK_CLKO1			257
+#define IMX8MQ_CLK_ARM				258
=20
-#define IMX8MQ_CLK_GPIO1_ROOT			270
-#define IMX8MQ_CLK_GPIO2_ROOT			271
-#define IMX8MQ_CLK_GPIO3_ROOT			272
-#define IMX8MQ_CLK_GPIO4_ROOT			273
-#define IMX8MQ_CLK_GPIO5_ROOT			274
+#define IMX8MQ_CLK_GPIO1_ROOT			259
+#define IMX8MQ_CLK_GPIO2_ROOT			260
+#define IMX8MQ_CLK_GPIO3_ROOT			261
+#define IMX8MQ_CLK_GPIO4_ROOT			262
+#define IMX8MQ_CLK_GPIO5_ROOT			263
=20
-#define IMX8MQ_CLK_END				275
+#define IMX8MQ_CLK_END				264
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

