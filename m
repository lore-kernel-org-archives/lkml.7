Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C40C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8D62186A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544145;
	bh=qR5JCwyplkv1yPDzgu3yOYplWe/C6DistE/iQ1nO/3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z37tz9o5aGhLp+CmMEouFWN7aE2OFaEYFjpl/ph4v70ni0gCQMpvo53phxJEbzYBN
	 oQMdCbBvePkpeQk40n6HJ467Ul1oSjWAZJoMfRmBmGCV8t5aP0kVXwS5p/Vbqx8GVB
	 kws/wpE/jodGVuH6bpq2WIkIOAkBi501hBK3uO6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFNU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfFNU27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:28:59 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535B0217F9;
        Fri, 14 Jun 2019 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544138;
        bh=qR5JCwyplkv1yPDzgu3yOYplWe/C6DistE/iQ1nO/3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG7O3sObDZuCH4TTEcXc6lyhHP0qwW7WwRnbHNWi0T/jCfXAMXF9MsSucOW5R+SkO
         4NaFmnAX74InHyC4Qky7zWfmzzN3x7Oh+8qPfTr9j03+m92OjOn8BdacLWw7unGYCA
         N8YAli58OyO1PvNPl3knQBhTMNfFPqcSZn4Oar0w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 13/59] MIPS: mark ginvt() as __always_inline
Date:   Fri, 14 Jun 2019 16:27:57 -0400
Message-Id: <20190614202843.26941-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202843.26941-1-sashal@kernel.org>
References: <20190614202843.26941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 6074c33c6b2eabc70867ef76d57ca256e9ea9da7 ]

To meet the 'i' (immediate) constraint for the asm operands,
this function must be always inlined.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/ginvt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/ginvt.h b/arch/mips/include/asm/ginvt.h
index 49c6dbe37338..6eb7c2b94dc7 100644
--- a/arch/mips/include/asm/ginvt.h
+++ b/arch/mips/include/asm/ginvt.h
@@ -19,7 +19,7 @@ _ASM_MACRO_1R1I(ginvt, rs, type,
 # define _ASM_SET_GINV
 #endif
 
-static inline void ginvt(unsigned long addr, enum ginvt_type type)
+static __always_inline void ginvt(unsigned long addr, enum ginvt_type type)
 {
 	asm volatile(
 		".set	push\n"
-- 
2.20.1

