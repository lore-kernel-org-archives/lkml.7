Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C54C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51620665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wVPVsAAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfFYHzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:55:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFYHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:55:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P7tj1O3518498
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 00:55:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P7tj1O3518498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561449345;
        bh=4aoA9rOUg9GtgHHm8lMCJzjCAAaYoSMArmKxlNeWaTs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wVPVsAAEXhwS4myxRhxLwSOCs8mW2zYWMGSmZQpFNSVqv3/ly9/gDrapGIznLmdp0
         GfeG9HbwFGzwe26ANVd/YfbrPoUd9YYS5bhitTm4tihDGS1CRr2royu3QiSeYxiTpm
         IqVbHK2YVB7TEZ5szXNZ+XCsg/svr0L38Zyq39VgDtFzboaFCogbozZYBImaN0JjdO
         hSueNE70UgG2CPbx+2N5u+KArRs0s6jUOvalUeNj3mkEiXHwougop7B4l4TwWaPr5a
         pmIWv+PrwB8NvqqTKyJV4bKM4po4yR7agEgXHNV8A9DYO+R0t5Ob3FwEsG1pnaEvZo
         VIcwEeGl8B/IQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P7tiWU3518495;
        Tue, 25 Jun 2019 00:55:44 -0700
Date:   Tue, 25 Jun 2019 00:55:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-87b61864d7ab2aec5c212ff18950d4972f0dfb4e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, yamada.masahiro@socionext.com
Reply-To: mingo@kernel.org, yamada.masahiro@socionext.com,
          tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190625073311.18303-1-yamada.masahiro@socionext.com>
References: <20190625073311.18303-1-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Remove redundant 'clean-files +=
 capflags.c'
Git-Commit-ID: 87b61864d7ab2aec5c212ff18950d4972f0dfb4e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  87b61864d7ab2aec5c212ff18950d4972f0dfb4e
Gitweb:     https://git.kernel.org/tip/87b61864d7ab2aec5c212ff18950d4972f0dfb4e
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 25 Jun 2019 16:33:11 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 09:52:06 +0200

x86/build: Remove redundant 'clean-files += capflags.c'

All the files added to 'targets' are cleaned. Adding the same file to both
'targets' and 'clean-files' is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20190625073311.18303-1-yamada.masahiro@socionext.com

---
 arch/x86/kernel/cpu/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5102bf7c8192..50abae9a72e5 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,8 +54,7 @@ quiet_cmd_mkcapflags = MKCAP   $@
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
 
-targets += capflags.c
 $(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
-clean-files += capflags.c
+targets += capflags.c
