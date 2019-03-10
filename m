Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F902C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A1320643
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 12:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCJMAu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 08:00:50 -0400
Received: from mail-oln040092072014.outbound.protection.outlook.com ([40.92.72.14]:40261
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfCJMAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 08:00:49 -0400
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (10.152.16.53) by AM5EUR03HT165.eop-EUR03.prod.protection.outlook.com
 (10.152.17.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.19; Sun, 10 Mar
 2019 12:00:46 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.16.58) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.19 via Frontend Transport; Sun, 10 Mar 2019 12:00:46 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::c89:4e52:34c1:7009%5]) with mapi id 15.20.1686.021; Sun, 10 Mar 2019
 12:00:46 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] clk: rockchip: fix wrong clock definitions for rk3328
Thread-Topic: [PATCH] clk: rockchip: fix wrong clock definitions for rk3328
Thread-Index: AQHU1zjkDgu15ohweESrobPfCE5TKQ==
Date:   Sun, 10 Mar 2019 12:00:45 +0000
Message-ID: <AM3PR03MB0966A06101CACDAEA4ECD72BAC4F0@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:209::30) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:6349A1023B54DF8E5D94AD8DFEF5BF47B44C59FA69D3604BE0F7C99C7C425856;UpperCasedChecksum:41456B7F609395309D238C3F3105CDB12737865004AFA9DFA69ED1BE8E5F14C0;SizeAsReceived:7715;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [9ZMzfXL3hY0Clj+BAWmE9WI8buAOl5nv]
x-microsoft-original-message-id: <20190310120022.7599-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT165;
x-ms-traffictypediagnostic: AM5EUR03HT165:
x-microsoft-antispam-message-info: w1nHXtIFIRL80zADD73qlMuTqBeSq1M3PBKTofns0+bSEzURXXJU9IXIsCrbAQ84
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7975fa91-dd33-4927-57c2-08d6a55006c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2019 12:00:46.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes definition of several clock gate and select register
that is wrong for rk3328 referring to the TRM and vendor kernel.
Also use correct number of softrst registers.

Fix clock definition for:
- clk_crypto
- aclk_h265
- pclk_h265
- aclk_h264
- hclk_h264
- aclk_axisram
- aclk_gmac
- aclk_usb3otg

Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk-rk3328.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index faa94adb2a37..5f6b6bcc2149 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -458,7 +458,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 			RK3328_CLKSEL_CON(35), 15, 1, MFLAGS, 8, 7, DFLAGS,
 			RK3328_CLKGATE_CON(2), 12, GFLAGS),
 	COMPOSITE(SCLK_CRYPTO, "clk_crypto", mux_2plls_p, 0,
-			RK3328_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 7, DFLAGS,
+			RK3328_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3328_CLKGATE_CON(2), 4, GFLAGS),
 	COMPOSITE_NOMUX(SCLK_TSADC, "clk_tsadc", "clk_24m", 0,
 			RK3328_CLKSEL_CON(22), 0, 10, DFLAGS,
@@ -550,15 +550,15 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(0, "hclk_rkvenc_niu", "hclk_rkvenc", 0,
 			RK3328_CLKGATE_CON(25), 1, GFLAGS),
 	GATE(ACLK_H265, "aclk_h265", "aclk_rkvenc", 0,
-			RK3328_CLKGATE_CON(25), 0, GFLAGS),
+			RK3328_CLKGATE_CON(25), 2, GFLAGS),
 	GATE(PCLK_H265, "pclk_h265", "hclk_rkvenc", 0,
-			RK3328_CLKGATE_CON(25), 1, GFLAGS),
+			RK3328_CLKGATE_CON(25), 3, GFLAGS),
 	GATE(ACLK_H264, "aclk_h264", "aclk_rkvenc", 0,
-			RK3328_CLKGATE_CON(25), 0, GFLAGS),
+			RK3328_CLKGATE_CON(25), 4, GFLAGS),
 	GATE(HCLK_H264, "hclk_h264", "hclk_rkvenc", 0,
-			RK3328_CLKGATE_CON(25), 1, GFLAGS),
+			RK3328_CLKGATE_CON(25), 5, GFLAGS),
 	GATE(ACLK_AXISRAM, "aclk_axisram", "aclk_rkvenc", CLK_IGNORE_UNUSED,
-			RK3328_CLKGATE_CON(25), 0, GFLAGS),
+			RK3328_CLKGATE_CON(25), 6, GFLAGS),
 
 	COMPOSITE(SCLK_VENC_CORE, "sclk_venc_core", mux_4plls_p, 0,
 			RK3328_CLKSEL_CON(51), 14, 2, MFLAGS, 8, 5, DFLAGS,
@@ -663,7 +663,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 
 	/* PD_GMAC */
 	COMPOSITE(ACLK_GMAC, "aclk_gmac", mux_2plls_hdmiphy_p, 0,
-			RK3328_CLKSEL_CON(35), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RK3328_CLKSEL_CON(25), 6, 2, MFLAGS, 0, 5, DFLAGS,
 			RK3328_CLKGATE_CON(3), 2, GFLAGS),
 	COMPOSITE_NOMUX(PCLK_GMAC, "pclk_gmac", "aclk_gmac", 0,
 			RK3328_CLKSEL_CON(25), 8, 3, DFLAGS,
@@ -733,7 +733,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 
 	/* PD_PERI */
 	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(19), 11, GFLAGS),
-	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0, RK3328_CLKGATE_CON(19), 4, GFLAGS),
+	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0, RK3328_CLKGATE_CON(19), 14, GFLAGS),
 
 	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 0, GFLAGS),
 	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 1, GFLAGS),
@@ -913,7 +913,7 @@ static void __init rk3328_clk_init(struct device_node *np)
 				     &rk3328_cpuclk_data, rk3328_cpuclk_rates,
 				     ARRAY_SIZE(rk3328_cpuclk_rates));
 
-	rockchip_register_softrst(np, 11, reg_base + RK3328_SOFTRST_CON(0),
+	rockchip_register_softrst(np, 12, reg_base + RK3328_SOFTRST_CON(0),
 				  ROCKCHIP_SOFTRST_HIWORD_MASK);
 
 	rockchip_register_restart_notifier(ctx, RK3328_GLB_SRST_FST, NULL);
-- 
2.17.1

