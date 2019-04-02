Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AEF2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246103;
	bh=FI6J8+tdBZyUTPiLwuqOYFPSkuwFYL9r3/sySYSKvjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCuoFtuedLCRhoJgJ5R2MuklhKAguE7MRxEDff/lNkl305GMXzo/sbicbET68T2al
	 UfSkmVhvR2mm5mq8BLtxasAmaYZN3mB7dg7D0adrlu10Nt7xwDjD5jGV9gZDfeKj3n
	 uhH5c3yQin47A5VAcwwRliduSeiB0kHos2LNYRU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDBXBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDBXBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:06 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A3F20856;
        Tue,  2 Apr 2019 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246066;
        bh=FI6J8+tdBZyUTPiLwuqOYFPSkuwFYL9r3/sySYSKvjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgII9M9DeZ668CSAHnIAv+SyFo0Bu2LUVTlP/1f1kb145J14RuORzUYzQZx4OVyww
         MjInEg/VnivF8cI5ns+uDYjCw1xmhNUE1yM9v+QbGq1Idga1WVMfkfZ3jqeBB+wsac
         NPymgWKSCK4mG2cKz83EjAnsi68VRRsOJh2t7088=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 3/8] clk: Document CLK_MUX_READ_ONLY mux flag
Date:   Tue,  2 Apr 2019 16:00:59 -0700
Message-Id: <20190402230104.105845-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag isn't documented. Document it.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index adb8a58e213c..edff3c5883bc 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -499,6 +499,8 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  *	register, and mask of mux bits are in higher 16-bit of this register.
  *	While setting the mux bits, higher 16-bit should also be updated to
  *	indicate changing mux bits.
+ * CLK_MUX_READ_ONLY - The mux registers can't be written, only read in the
+ * 	.get_parent clk_op.
  * CLK_MUX_ROUND_CLOSEST - Use the parent rate that is closest to the desired
  *	frequency.
  */
-- 
Sent by a computer through tubes

