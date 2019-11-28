Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F23C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2462021775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK1Opb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:31 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfK1OpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:22 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXHBo-1iJE7H3s34-00Ygma; Thu, 28 Nov 2019 15:45:18 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 7/7] drivers: clk: unexport clk_hw_register_gpio_mux()
Date:   Thu, 28 Nov 2019 15:44:50 +0100
Message-Id: <20191128144450.24094-7-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:GpHErHNI82WASHVkE8THZ9nr+ptmFzHW5fL+3h+SQyUE0+IsZt7
 f77t2/XVg0JKnfGAaz3mqg7B6Tc5QfbM78Xjnau34BTdHgKZKOTuvWUYkpIuE+GZMwjoXBk
 oNJ781QC/qVpcuSqkoxMsITGkiAcfCJk9mU2y5RB0IJAL9AOjjiS6y6wS1d+FN4Iu8yHcCI
 LcPtyB8vP+sSdlLIT49RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xdy895FX+Oo=:nCp7NpLYbFJBJsIZ+rXIpJ
 EdEFHNvkXKmUqBnd97WH6j685quUAkfkC6Kso8Y4wzZ7pPEb9IDtP+5U9fMagi5lS34qxenOQ
 VwlmvSUhyBooyu2YO7ApP6/aosmmZ1LEgNGOmjbARAHIkNsjMrDOvafmAuCu1YYwxHdVqd8xY
 O+jLhFhxLjAqi65KutMRTrBqvG+qmo/Qz9GWKPJOl5v1f5mZVyngs6LkLJt2GPqZs4znjZH93
 09Gjm7KjJoS3F8Xu+1kItZe9Ua9Tsagb4KxYrBOYIhSTXrJifYo+RqqYTsZ+cFDPSg5OpKAlW
 vRiZWt4zTinmoYBHS/wbfW/mEBKap3F1VtlApPFX4FZSs3ehWUw6tZxqODcfg2Q4QItmF37kN
 P13On90zxcpSg39oCafEiiNIVDwi/H5PtTY3kCi/yZTVvehjHrmE0dfpldnBEE/GSVjCEXI/z
 S8QXpKI+1VMBe+8zvXdPKiyO5lpDkObmg8KE2Wdntb/zj29ErfKpoEtHvuhvDU/yiX4EFQK7y
 4m7IGsIIEhVRf7w6/QcqAaM6YnxhSQoHTT/zBqmm+nXG1OeYrXKO8xiTInuL9VE4G35zCx5sX
 QlZqOkev8/C2mb4eHwTrJHUzUdzvaL45Nvb5xlIIaHTso9MnjKnizP5S3C4plP3jdEjSdrRIL
 4ST3PM0HCPPR9OhAv+cnR6dh5A7/52BFq890qjWjQXNWoNzKqTOgiPgE4CX9L807cEOWxXNPv
 H5hrmLhbc+2diTXsr1/6x3UyHDLKKir/Uc5w8lK/WzQIVjt3qGCIjcAzYBBqU2u+kh9UW2SqH
 5dNIraNoiLFqQ1aMv0023CfgjS1wqqMrtKYYOz4uNDPmgRtBif8XsK8guv1V891qeBFehc7os
 dYZstFxgOIxskzQqY3zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_hw_register_gpio_mux() doesn't seem to have any
users outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index a7e75a038728..70381bf75d02 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -204,7 +204,7 @@ static struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
  * @gpiod: gpio descriptor to gate this clock
  * @flags: clock flags
  */
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
+static struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
 		unsigned long flags)
 {
@@ -216,7 +216,6 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 	return clk_register_gpio(dev, name, parent_names, num_parents,
 			gpiod, flags, &clk_gpio_mux_ops);
 }
-EXPORT_SYMBOL_GPL(clk_hw_register_gpio_mux);
 
 static struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59a7f273a182..961c1048a9ca 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -772,9 +772,6 @@ struct clk_gpio {
 
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
-struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
-		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-		unsigned long flags);
 void clk_hw_unregister_gpio_mux(struct clk_hw *hw);
 
 struct clk *clk_register(struct device *dev, struct clk_hw *hw);
-- 
2.11.0

