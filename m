Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB21C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A452176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfK1Oph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:37 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mg6uW-1hsj5P2orG-00hf1o; Thu, 28 Nov 2019 15:45:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 6/7] drivers: clk: unexport clk_gpio_gate_ops field
Date:   Thu, 28 Nov 2019 15:44:49 +0100
Message-Id: <20191128144450.24094-6-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:CmTdkl0zWo2JdCF7jhXzf9pYfGYcWwsGodJaK7DNxsfTMpaKiCk
 H+9wKJwziO/9InfSE9VMfa3YrTC4jvBIzgchgZ7vMXLZXPh3NAV+JlvRX9yiQAkCdcVD7l0
 KgGiPxSF+dfXgA19RrCrLSCpQr8rjwH8CqGacEYYqWdPMSCq1Q7wt7M91VJYJFxwYj53tSD
 /UhDyT0sKl8P42ucyxY5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gCvM3hAvcMU=:eXUcK8oFZ0UkvOO8K+U0rg
 DNkuqW1ghi+X5+7MLqKUJ9ROadCFtIjnJyNeM2+5cAhDIFAux7aGChk/fi1Tb9AG8leyLtGZj
 sfeucbYKMOpGET7r7mOskE4tG/2nR7CCuTiS3rTVY6qtDyjA2OgsEU1eMXTAPFya0Mxw+2gIh
 AOl2AFerZ8E6vglq+iqqKcgKkpmkAtZUXKi+x4Z67lYiuzbfHl3VGbnWPWC3faI8X8LXRPQ0u
 PBwMWIbLWpC5wdUBPQsuB2VaDpcjPcpdR9L+QRC20EwRd0q22g1eboV9xZsQvLZmJhU8L09yt
 MBLl84C5U5KLxpSz3owMNblxl+eG2fHM/Z2MqBltcI48GlQiCDAFrpRp4SBgCv7yQo9WKf3Pk
 eUUAgm4+HK8FEXLWmr5vcS9AQWLcv7msU11zn5R1tQColoejHeCP5UgGSMVseKtpD76Qn96fx
 0HnlzZRIVBeab1iR6vOhlmcSrDZNeGDL/4++J/WAjb9HsRuHewefrU2bqNQulmCi7ebGsjp2+
 cRFn3ZF/JFK8R3JJqFfuivsgUI8IzWZKEX53crpv65GqhjKiTcNb9Dl1xF/xp+u8sQ8PglExs
 iQubTTqWc79Exu2RlMgYKy6uveazqot8pnECHB6FwW1d3mZsK9c7OXljubdt9mdogQN3Clvpf
 lstlXXq7/QpaqXUPy5yUnmuXofJyiKS8oBeI1wTR6qpxqXx3WA+HFk5K2YgSzXvKPpFDGjJbD
 9/BsVMsFo96GY0T6+P6Kx4+wXt2cbDERg9e5Jt04CvQGOcs+9A9DYRzU7gdb2zyJlWJzMz3dn
 SUwvahg6guO5sBfwU8nHz80GMrE0Je6JE8Qo1JOpluvrZ7X0rj2Hk9jTSy1/2hMR2t07jl/Tq
 rJVb69Ijc3K4rerdvJvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_gpio_gate_ops field doesn't seem to have any
users outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 005e311c1822..a7e75a038728 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -51,12 +51,11 @@ static int clk_gpio_gate_is_enabled(struct clk_hw *hw)
 	return gpiod_get_value(clk->gpiod);
 }
 
-const struct clk_ops clk_gpio_gate_ops = {
+static const struct clk_ops clk_gpio_gate_ops = {
 	.enable = clk_gpio_gate_enable,
 	.disable = clk_gpio_gate_disable,
 	.is_enabled = clk_gpio_gate_is_enabled,
 };
-EXPORT_SYMBOL_GPL(clk_gpio_gate_ops);
 
 static int clk_sleeping_gpio_gate_prepare(struct clk_hw *hw)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b00adc1909a1..59a7f273a182 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -772,8 +772,6 @@ struct clk_gpio {
 
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
-extern const struct clk_ops clk_gpio_gate_ops;
-
 struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
 		unsigned long flags);
-- 
2.11.0

