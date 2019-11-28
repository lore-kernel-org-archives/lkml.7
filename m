Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E09C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0195B21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK1OpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:24 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44231 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1iVe4j2fth-004kdf; Thu, 28 Nov 2019 15:45:16 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/7] drivers: clk: unexport clk_hw_register_gpio_gate()
Date:   Thu, 28 Nov 2019 15:44:45 +0100
Message-Id: <20191128144450.24094-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:8wHv1XyPtuQ9Q/kuYc5WWANDyR0hnbQtR5xxLnnqLlMBW6quR/l
 1v7oFYqQ+nJD8UuuQ3BByXwAsc32F3jI5usdJube6EKMoTCg+1sXb8z9wr7zIM1jRkWXvdy
 TyYqlWf0yspPrVN1jROPQMHkQQlotGb4amuojentvSE91DL+YVkalDYi4WUFL2QcHsD4lIi
 WqEY5cUYrTgXuwpYLj8KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3G94kiDwzmg=:71tEPawSbu9uEFtB7W8ez1
 YrTb6RhPSwpE6N+SbPJwj1vl4ahFzTbR6DGLjDVc6DJiB+SgLqSMOpLz2ANeUxeDxRW96dAS+
 RJDhameSgqZh7aTDOfyxFKmOeCNwt8dTU8Z4/kX/cdql6kKE0C6Y54V5p7g9/tj6SfWsCt+Wv
 eXaPsTUEoSySNHdTybJRIYDnE6/S267lHWo8bk5XdsAMB35khWbwLzl6NPdUpW/k+xLKLYbE6
 idq1hEFJnK9Sf5CPEghtj1TtfeO5EZafCeoUUqNztshFhGXhL6rGQdYBa5cmSjWIWG8uVor+m
 jiK2Cwg4EgO4meeIcB4wKG9gr1xLwRlhuqCV2LeXIFSrH7wc3B/LRq0NSD/ca3uF4YFk1H1W8
 flVUbqXxbEmkXQlIeVGD3SyDsHrGRiE3XT1/W3zvhhfR9JiijfdwXeBibTLdyxxhzK6tkmLcp
 H4dcqDZ5R6S2a1vO4o1iLmnI98R3FWYSh/03vX3TQ9VtTphR5ocxg+/6TV0UY27FHm+JSR6nM
 YOQo7UF5BCBGxBiIijTX/2NnxmFgZk2EU/+CyN81EX9VcRQ0/NMyUOFTPskwvMm0w7Pzc5e2z
 8WvOksNTBGfvykui7If8/WeHO346ooDYYPOLlMnDyC91hUHw+2QAM7clwUZvB4SM70xvf6BrV
 DNdkJfD0LE9TXRZSEOfQtxN9BVprmY0DGHsMNeB3jPuGJqKK1z+fsmICjN5slDP1kjvwMFTRx
 gqdXH8Vcna7CN4HKnmnZCfrQLUrQ+s9krmIQl949rFBTnq4jfPLKEZ5U5Hqo+nwUWb6b34uwI
 6/Dkfp7Ht2Tm5IRbTEbEcv5Zoih1wl8QA9HUNj4a4smFD4Ew+a51mA7hoX6fzvqAJzVWDjSVJ
 IbOhTfMqqS0pwZrhAOCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_hw_register_gpio_gate() doesn't seem to have any
users outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index f9f81a31984a..f457b30e4900 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -169,7 +169,7 @@ static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
  * @gpiod: gpio descriptor to gate this clock
  * @flags: clock flags
  */
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
+static struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 		const char *parent_name, struct gpio_desc *gpiod,
 		unsigned long flags)
 {
@@ -184,7 +184,6 @@ struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 			(parent_name ? &parent_name : NULL),
 			(parent_name ? 1 : 0), gpiod, flags, ops);
 }
-EXPORT_SYMBOL_GPL(clk_hw_register_gpio_gate);
 
 static struct clk *clk_register_gpio_gate(struct device *dev, const char *name,
 		const char *parent_name, struct gpio_desc *gpiod,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d283f9896e86..b4338b26aed7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -773,9 +773,6 @@ struct clk_gpio {
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
 extern const struct clk_ops clk_gpio_gate_ops;
-struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
-		const char *parent_name, struct gpio_desc *gpiod,
-		unsigned long flags);
 void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
 
 extern const struct clk_ops clk_gpio_mux_ops;
-- 
2.11.0

