Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB00C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6605D20673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562120551;
	bh=c17pRlxwwPrNoXYc9Mh5aPONf3pswB3AD9mAnAJ8Vi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRInWT2SFCAlBgwqe491z8x8FYEh0mx2ABk5HxnJriDPBs8c2QrejswHjo/8Qjs6R
	 1ZmOotOqW0Ghe7G9QcbejR0FKQe7+sWAT7QZ2i+hx/vgDjfeEy6Aai6Q2xO0TOd+mC
	 8lEkJVJp7pvdGvLFk54evuU0ttsR/IuZfHnJYdBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGCCPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfGCCPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:15:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125B7218A3;
        Wed,  3 Jul 2019 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562120133;
        bh=c17pRlxwwPrNoXYc9Mh5aPONf3pswB3AD9mAnAJ8Vi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RK3MR5Rc3WTTyPdrc4ttwsdBm80YnA8enqP86nb93XWdOiBXdsSxn/kFn9pJybHQa
         HfOcWd7mk8J7GVAGRg/fM692urag0nrvX1/Qs9/lCknbcN/Vskga2NAl9c9tRPHMjK
         DQ8EhWE43VO2ILQTxX/mH+m+1uf2G6cMYJFpX2/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 11/39] ARM: dts: gemini Fix up DNS-313 compatible string
Date:   Tue,  2 Jul 2019 22:14:46 -0400
Message-Id: <20190703021514.17727-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 36558020128b1a48b7bddd5792ee70e3f64b04b0 ]

It's a simple typo in the DNS file, which was pretty serious.
No scripts were working properly. Fix it up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index b12504e10f0b..360642a02a48 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "D-Link DNS-313 1-Bay Network Storage Enclosure";
-	compatible = "dlink,dir-313", "cortina,gemini";
+	compatible = "dlink,dns-313", "cortina,gemini";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-- 
2.20.1

