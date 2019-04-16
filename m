Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896DFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADC720857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfDPHEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:04:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDPHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:04:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G74BlA3322917
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 00:04:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G749NN3322913;
        Tue, 16 Apr 2019 00:04:09 -0700
Date:   Tue, 16 Apr 2019 00:04:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephen Kitt <tipbot@zytor.com>
Message-ID: <tip-89502a01979033a1c0c0c4d6d9aef07e59021005@git.kernel.org>
Cc:     brgerst@gmail.com, bp@alien8.de, riel@surriel.com,
        mingo@kernel.org, steve@sk2.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, peterz@infradead.org
Reply-To: mingo@kernel.org, steve@sk2.org, torvalds@linux-foundation.org,
          riel@surriel.com, hpa@zytor.com, bp@alien8.de, brgerst@gmail.com,
          peterz@infradead.org, luto@kernel.org,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190415150853.10354-1-steve@sk2.org>
References: <20190415150853.10354-1-steve@sk2.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Fix the 56-bit addresses memory map in
 Documentation/x86/x86_64/mm.txt
Git-Commit-ID: 89502a01979033a1c0c0c4d6d9aef07e59021005
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

Commit-ID:  89502a01979033a1c0c0c4d6d9aef07e59021005
Gitweb:     https://git.kernel.org/tip/89502a01979033a1c0c0c4d6d9aef07e59021005
Author:     Stephen Kitt <steve@sk2.org>
AuthorDate: Mon, 15 Apr 2019 17:08:53 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 09:00:34 +0200

x86/mm: Fix the 56-bit addresses memory map in Documentation/x86/x86_64/mm.txt

This fixes a PT typo, and the following 56-bit address-space
addresses:

  * the hole extends from 0100000000000000 to feffffffffffffff
  * the KASAN shadow memory area stops at fffffbffffffffff (see kasan.h)

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: alex.popov@linux.com
Cc: bhe@redhat.com
Cc: corbet@lwn.net
Cc: kirill.shutemov@linux.intel.com
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20190415150853.10354-1-steve@sk2.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/x86_64/mm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 804f9426ed17..6cbe652d7a49 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -72,7 +72,7 @@ Complete virtual memory map with 5-level page tables
 Notes:
 
  - With 56-bit addresses, user-space memory gets expanded by a factor of 512x,
-   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT starting
+   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PB starting
    offset and many of the regions expand to support the much larger physical
    memory supported.
 
@@ -83,7 +83,7 @@ Notes:
  0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
 __________________|____________|__________________|_________|___________________________________________________________
                   |            |                  |         |
- 0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
+ 0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
                   |            |                  |         |     virtual memory addresses up to the -64 PB
                   |            |                  |         |     starting offset of kernel mappings.
 __________________|____________|__________________|_________|___________________________________________________________
@@ -99,7 +99,7 @@ ____________________________________________________________|___________________
  ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
  ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
  ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
- ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
+ ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory
 __________________|____________|__________________|_________|____________________________________________________________
                                                             |
                                                             | Identical layout to the 47-bit one from here on:
