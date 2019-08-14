Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E553C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6402420665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742245;
	bh=b9sTOzVRZO2UFsFBvHh59r6YtcTgFSYnb0uAfs4xYSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oVK9gRxMrynFZa9Wl83BDVmxDhuoGZ75TzS1kMywJDT4Kh+mPjvf7y//zEv0Pejmo
	 0Kxu1O4Nact8KUXOwffs3h5MthRzca/LRexymKh7iQEHDpgXLxhNrVTbANamsCqCM+
	 8B8eVaIb4HQN35d7vogFXwoZK3tHs7r8xlRAbpuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHNAYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHNAYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:24:03 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF3120665;
        Wed, 14 Aug 2019 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742243;
        bh=b9sTOzVRZO2UFsFBvHh59r6YtcTgFSYnb0uAfs4xYSg=;
        h=From:To:Cc:Subject:Date:From;
        b=awRYqL6qd97cGg07d9AY7B2KkWjvnuH1hQxRbS6/Xq4lPQJs7/jYcbqB7X9gAUhe1
         0NP51JH8xA3Ul9lYhipBS1mxELGiBOEtBVJZ/3pOMUwrynyHCFfRkkQdYbzQT3YHj8
         c6ymwmg2ctGskEOehlubifwIEAYler+U9+rJEGL0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH] clk: socfpga: deindent code to proper indentation
Date:   Tue, 13 Aug 2019 17:24:02 -0700
Message-Id: <20190814002402.18154-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is indented oddly, causing checkpatch to complain. Indent it
properly.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/socfpga/clk-gate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 2a5876dfa0cf..43ecd507bf83 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -45,8 +45,8 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 	if (streq(name, SOCFPGA_MMC_CLK))
 		return perpll_src &= 0x3;
 	if (streq(name, SOCFPGA_NAND_CLK) ||
-			streq(name, SOCFPGA_NAND_X_CLK))
-			return (perpll_src >> 2) & 3;
+	    streq(name, SOCFPGA_NAND_X_CLK))
+		return (perpll_src >> 2) & 3;
 
 	/* QSPI clock */
 	return (perpll_src >> 4) & 3;

base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
prerequisite-patch-id: aeb7774ad0e487e9156f9065b4ba813eb74fb9b0
prerequisite-patch-id: 71bf5a81905764a6f5639fd13eae3ce644baed20
prerequisite-patch-id: 75904dba6c6767f4d9bcfa1f32002d2992e647b7
prerequisite-patch-id: 478335b7427317b0e86f3b5433ffcec7f7c3b83e
prerequisite-patch-id: c532536a7433c0041f7ad1c7ee0b08a8d4c99a9d
prerequisite-patch-id: 7d179ce42cc421f3d110bade4783780955f8df42
prerequisite-patch-id: 390fa8a15fccc52e454e27552cdb835cb0e35b7f
prerequisite-patch-id: c9092a57b488d94d1ba249ef726c29fafb5abcbb
prerequisite-patch-id: d39cde5e03e04c09a66bffb3851a23dc5e5128d6
-- 
Sent by a computer through tubes

