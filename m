Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9647EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EF02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfFQLMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:12:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfFQLML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:12:11 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N32y5-1idHyv43rh-013RP4; Mon, 17 Jun 2019 13:12:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx6q: fix section mismatch warning
Date:   Mon, 17 Jun 2019 13:11:35 +0200
Message-Id: <20190617111159.2124152-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:luZvn4Kw4EBR3RZaXipNa456cw8n9WOMC2IEWpCkVsAMKIG9gyf
 Th7DcL93IXtSxW5GN6oGVvRO4qNociCYcoTyC6k9h91t+wCGdSDVEnnK99TtMYieeczzjce
 TtDhTLgMfYl53zOD+f9PVhF6IwrEPIgWIxTCcOP4Zf5dIvjTSMHxmkpBZda2gbOuYSf2paE
 RKvO5Om4GSzeijIMxk+HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3B5Knar0Ik=:A+6jFaGJ6IonTlxDIyFvi7
 gEa4cgrbowRmLVoa0iMQU1P1GYnSiU2VRShQMF1ULKS4MZtmzGY7IBMo1dJd9Y1M8qxsaYjrQ
 wVyx/F2362nHnaj3rKglLoq+Prt92d5dd/D4Nqur0Sz1+s/gVrRN8hz0jYOxGOKWhMkmC9jNv
 ZZ9lS7KTgc8/wdABoPeaTI+7eVeA2+VvqJJQsrTZOMm2cDhB7BgvwItmUsAAZy6jWI/XHFaZE
 VJ7FABvEEU9hwK9AKqUOGA0QpSjJ1WlF53J+7B3x1u2ZoNdsbwqouAAQJqljGIiuTIVlvBipk
 ZNir5dVDGvprYRQVzLlyinh78mFDamwd4fOnyKniEmhKAjfonrt/6RQFPXF6oaHOMsp0DMlv1
 21z12ITap2G/izeQTekeLukhqf64x4w65h0jz8Ry3Cc0SceHMDOO9TYgtH39WqroVrY/3eo0p
 3xHZ7CGdjNtqoPS0WK/ibk13QYv6iKX/cK7Hx/ywGB2OoUHDC9ivgXAxf8WI7dGwpEfhaccgO
 i91HiWGI9UQvTD5MFAt1nNt/VBSsgc1j0zW6E2wVRXup1iLl8hbUpzu+s4/+4I+e5GacGAOI7
 R8W+FofVhOq/qOAuX1BfoSGgytorucDElYDjEZQOyQB2y832ZANXRJNiuIqCzktWVv8Udzk3v
 CkREuhO7uCqcdV8yXdfkI5yYj1iBg+qu4Dc1mGc6aW+vBD/eM/CEwATLznPECjp3Gy83CPe4p
 qQnrLatlgY5nAhzrlKagqWXzTjU/xlpv4pbriw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6q_obtain_fixed_clk_hw lacks an __init marker, which
leads to this otherwise harmless warning:

WARNING: vmlinux.o(.text+0x495358): Section mismatch in reference from the function imx6q_obtain_fixed_clk_hw() to the function .init.text:imx_obtain_fixed_clock_hw()
The function imx6q_obtain_fixed_clk_hw() references
the function __init imx_obtain_fixed_clock_hw().
This is often because imx6q_obtain_fixed_clk_hw lacks a __init
annotation or the annotation of imx_obtain_fixed_clock_hw is wrong.

Fixes: 992b703b5b38 ("clk: imx6q: Switch to clk_hw based API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/imx/clk-imx6q.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 2caa71e91119..a875d0bc12ee 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -418,8 +418,9 @@ static void disable_anatop_clocks(void __iomem *anatop_base)
 	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
 }
 
-static struct clk_hw *imx6q_obtain_fixed_clk_hw(struct device_node *np,
-						const char *name, unsigned long rate)
+static struct clk_hw * __init imx6q_obtain_fixed_clk_hw(struct device_node *np,
+							const char *name,
+							unsigned long rate)
 {
 	struct clk *clk = of_clk_get_by_name(np, name);
 	struct clk_hw *hw;
-- 
2.20.0

