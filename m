Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB42C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602ED206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfDMOSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:18:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6741 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfDMOSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 10:18:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A85488149D0A797941D8;
        Sat, 13 Apr 2019 22:18:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 22:18:27 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paul@pwsan.com>, <tony@atomide.com>, <linux@armlinux.org.uk>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ARM: OMAP2+: Make some variables static
Date:   Sat, 13 Apr 2019 22:17:44 +0800
Message-ID: <20190413141744.34488-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:532:25: warning: symbol 'am33xx_gpio_hwmod_class' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:542:19: warning: symbol 'am33xx_gpio1_hwmod' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:562:19: warning: symbol 'am33xx_gpio2_hwmod' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:582:19: warning: symbol 'am33xx_gpio3_hwmod' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 4c3543b..adb6271 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -529,7 +529,7 @@ static struct omap_hwmod_class_sysconfig am33xx_gpio_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-struct omap_hwmod_class am33xx_gpio_hwmod_class = {
+static struct omap_hwmod_class am33xx_gpio_hwmod_class = {
 	.name		= "gpio",
 	.sysc		= &am33xx_gpio_sysc,
 };
@@ -539,7 +539,7 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio1_hwmod = {
+static struct omap_hwmod am33xx_gpio1_hwmod = {
 	.name		= "gpio2",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
@@ -559,7 +559,7 @@ static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio2_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio2_hwmod = {
+static struct omap_hwmod am33xx_gpio2_hwmod = {
 	.name		= "gpio3",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
@@ -579,7 +579,7 @@ static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio3_dbclk" },
 };
 
-struct omap_hwmod am33xx_gpio3_hwmod = {
+static struct omap_hwmod am33xx_gpio3_hwmod = {
 	.name		= "gpio4",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-- 
2.7.4


