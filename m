Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EDC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE4B2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK1OpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:23 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnqfc-1i2fEk3nKs-00pOFk; Thu, 28 Nov 2019 15:45:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 3/7] include: linux: clk-provider: remove obsolete clk_hw_unregister_gpio_gate()
Date:   Thu, 28 Nov 2019 15:44:46 +0100
Message-Id: <20191128144450.24094-3-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:GussK9F5dQLol8bTP8/xS6e6na3F+GGkXPnZapqTRn0wb2TKPMI
 SJmZIxS4zDn0G9BC4Yy8/XCIgNkEHWca45AkANgEBv19XZi/lv4An9nPVfU3WpqgfbsBQEK
 sDAlYd64aiFIXu4onPkxnPcDQW70tu3h9uDu6NpxbnBmsvEzzZOPTFDb+8aJrtRQJaFjgfa
 z9N88szeQaprdO1n4PibQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rEOy6BxQiI=:4vrnXaauPWDjlUXtHYDNwg
 0dtcDiHjSM6atVrI+/bt/fveoc8QJTpTTG/OKuvcXusEqRBHy4mnGiMEu0U+czHHMqoHqyby9
 P/TPCSZ0INL0XiJ1OdPHsMIu+6Osjz6r2DXsQXYtzWt86THn9HEgfiVgMXMlgRBASHT2Jc80t
 JDii4y9/a8QSBn05pb8LFQhuAJljmCFY11rbVqFl9JZ8sz2QoKZlpoi6KhVvjvNOO89LWN2L4
 dChyiqpUosIjgPvFSSAtSfhYTI7CnRF3JkZeUoXX6kWxe1LOdbCJPZl82SbUm7ix8Z5AglsFT
 ZYnfZynsY8xTT5Jdeu/RSWQAHFn5V3rJ4Z6bT3s3psLumOmrjd3QR7/NKziQ6Wqc12yl6nc57
 Dzti8xggaQZG2Cybw1qLsVpTswY85RHis6qm1MQclFND+LaklozeP6ER/+daEKulmbj8A9hl6
 v+WSrbcbGG3ykr7iZqdPatqXokYRTO/wGRKuaui/OqKldxCPQbvw7UZOqblo07pL0xIlDpA5C
 jJfv6hcuIaiBP0SlhAeRXDiZwiztormsgOiU3/qtmXRw2A2PNFU1KzbQ1aKWUuMPLKvLoREhU
 zXDV2aPOGPHWMECcP22WJdLxxNvZ81piuGERQ6gV734SKNu1tVqEHqRCUXRnLoyf+2BYoseNn
 HsNtyn30EJP8y9q7hfMSfBJHrzQn1XfNawJCwlqjPxlHUZkbrmE0Y3VMSABCeV7k85Zt4A8y5
 +iULKFrIDWF5KcBCMktPr7VwFtY2CW6c7qo7DzwV7bwaYOhZZbbJloTj6Ahn57hxhBAlnhmTf
 UeoVC4xQWtmO6E7xJDGOJx/0IQMKBJZmv7pVBw4K5hu4pLXP0sDzYFKN9OkfmFvMTby/WucOC
 OrLd21WcpPXZwbKGpu0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a prototype for clk_hw_unregister_gpio_gate(), but no actual
implementation. Seems to be an old leftover, thus remove it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/clk-provider.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b4338b26aed7..4ac2ee6655f9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -773,7 +773,6 @@ struct clk_gpio {
 #define to_clk_gpio(_hw) container_of(_hw, struct clk_gpio, hw)
 
 extern const struct clk_ops clk_gpio_gate_ops;
-void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
 
 extern const struct clk_ops clk_gpio_mux_ops;
 struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
-- 
2.11.0

