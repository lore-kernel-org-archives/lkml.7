Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2812B23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177798;
	bh=dmTypF2HAV/7TelQozG7SkGEDqB+I//ZaTegOEJndWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZWdSGXsTlHrrdb5vkgDYM129DbeMzmuSvPcDCFfqbwIFnUEHHOmN9zdzFwaZWcHW
	 WDj9N5dh7R9UzjL22GgqYaJW+r6EBv4cBXvkvV4YfwrY5fuBOsoTmrzSvB6ns2YCrT
	 2Qf3yXdPmVFoHcW7JPRmoUca3ddnDnyzhEwon2NE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3PJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbfH3PJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:27 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A662342E;
        Fri, 30 Aug 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177766;
        bh=dmTypF2HAV/7TelQozG7SkGEDqB+I//ZaTegOEJndWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHVa5H8+sTZcKJ4EUkMTFo3i6mkBzjY+vJ4/AAUuXRPCA/jo/nEbAx60BDOU96dZ9
         8sQYHI35cYjtJXeq27QY0mj1pvmTx5jJAHvkc5tD1JgZoZm/XYZ//F0g2mM5R7EspE
         FrlK0eKM0Hy7tww6zcaiTGn1rKY2hhe2ucaVzryk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/12] clk: fixed-rate: Document that accuracy isn't a rate
Date:   Fri, 30 Aug 2019 08:09:19 -0700
Message-Id: <20190830150923.259497-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel-doc talks about a rate for the accuracy. That's wrong.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b1ed4b840476..694bd3274221 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -393,7 +393,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  * @parent_name: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
- * @fixed_accuracy: non-adjustable clock rate
+ * @fixed_accuracy: non-adjustable clock accuracy
  */
 #define clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,      \
 						 flags, fixed_rate,	      \
-- 
Sent by a computer through tubes

