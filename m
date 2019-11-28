Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D93C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C12176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK1Opl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:56595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9M5y-1hmeFt0k56-015HVe; Thu, 28 Nov 2019 15:45:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 4/7] drivers: clk: unexport clk_register_gpio_mux()
Date:   Thu, 28 Nov 2019 15:44:47 +0100
Message-Id: <20191128144450.24094-4-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:hHvSw8d/VyEy/u6+267uFzxMMjnSMVFEKwM3RedogZNn6LYM2zv
 5AXb3SajQD6o//CzBQrXnVn+hVAr1O8B3UUnigOm2YuaXGX5IQuGhMFI5E238dArEC4eM4O
 kKXxVtoTkcUzXJzh81POj7wKqk5XQpFHLBqVpeyf6Gw3FjolrH+UPRXGgYao8cVX211Z9o8
 k+t74PmKf0qLqb7JhlntQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o+jPHS3VcWc=:VuKuDoKdWvGn1hPz088tZl
 fjzL7Ge1zD62EzlXE6sOAXXQCaOfN+xbBPBUwr58xOwW+CFm3zU2Hfv47zbXeHWDvaHL+6m+A
 zjGIsvxk9cxQuDskSsLvhbsoaLgGop5+uCujG048NIZfGoOqiaOCtGtOZ3nzWlChVlJNeQkHc
 uVEAR0tUtFM/LtYgtM4twsvWfqc66jz+t9xBcc5OpQYLgsKKxGCWqEiIeb4O2tjtkwXU0dWKj
 LIqxMlvUyLLQrgJhFm/5z5+x+6P780tkLeNIG04PU6UHwXcPRzQnBWt30/H8Ac4+lWD0Az97x
 fyXgEYciI6/Z0okpaYP0989SJnnJ/HMhm92jJMfu1rfC5NPZCHOMibMnO5LjNmERZhXTCIDnw
 V/5FgKxKCcdeaSL0zZSVCqK5OtWPCnmGmPVVi7d58L1+vGA74MMa411Nzb4RcJ42A5fcOffM1
 6pjTW7cXyzk22S9Segc379WW0eerHanQVRh0fT7Qb66AwX0nHyWpntQr7fVRopS8E72rQgtpU
 eQnHLa8rGu0+aNn2TXSwbkWCVRVK0QxxU1n+XAoqL4BkCS/Qarmm2FoxrPnVB9d2dXPKWQKtM
 iD/O7KOXguIMpQdIYPvVdvozbxZr3d87oILLE6zjrVgQKYLASqv07O6AV7AdcWm+ASmy32VrR
 68uE6+umsih0Sqvx2TymJVftTaScJ5XrmrZiu2a+LMgzct8WtPNdEEFQFOBanF8Nuj9PO2RPU
 JVlQe8YCQz5iDvga7Fx0lrlkgBB9aCc8dxJB9RzFWxiEghKtvwb9tzOUgFEWoTlDOcV8wdXHn
 PijPJr5YkLqcrzOCdqbUcImSBVwYfps3v25nkpud6AHKYUFXQPtOBmvjegXH6hyQCSXy6Hx8b
 r2XEKiSdJBZlyT2BVRKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_register_gpio_mux() doesn't seem to have any
users outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index f457b30e4900..5aa9ffe394ef 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -220,7 +220,7 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_gpio_mux);
 
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
+static struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
 		unsigned long flags)
 {
@@ -232,7 +232,6 @@ struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
 		return ERR_CAST(hw);
 	return hw->clk;
 }
-EXPORT_SYMBOL_GPL(clk_register_gpio_mux);
 
 static int gpio_clk_driver_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4ac2ee6655f9..054e3c128ac5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -775,9 +775,6 @@ struct clk_gpio {
 extern const struct clk_ops clk_gpio_gate_ops;
 
 extern const struct clk_ops clk_gpio_mux_ops;
-struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags);
 struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
 		unsigned long flags);
-- 
2.11.0

