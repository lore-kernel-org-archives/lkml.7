Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F1720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DW2LOFla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfCEFvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:51:17 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:38923 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfCEFvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:51:15 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x255mOrU002400;
        Tue, 5 Mar 2019 14:48:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x255mOrU002400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551764906;
        bh=DlyhqYro9PRu0qrY7RWF8lCRod8hQNrPuAp+sT2sllM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DW2LOFlaDxv4HLHO4dev3+zueBOI0AgAkAWHqnfdgLujx4ciMN8idX70sVMkt5BS0
         7BMpWchM8gUCFhZEzrH0Jk8ARcHP/wt2BQRbf/NC7iPNmM62l5bF6JCdTViV0cVIvS
         Kde05GQtYFo74TFpNcp+zhV5ofeU9XMQ+/lRE60JCgL9d8i1fJH7TCKAgqKK7OR5AW
         JxHp9Np6/Kckbfs4500erUUOB8/TCGGkgICqvcKexzCxMxJDDt2GuScve0TxRbVYhA
         3aX3SKmXCfufEfgcaGtKc+qKBVLA9Qn1LqPlh1PhgxOudD28vBH6j/l0mka+dcp+9i
         b/OjsfjWTq4Pw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] objtool: move stack-validation.txt to Documentation/
Date:   Tue,  5 Mar 2019 14:48:15 +0900
Message-Id: <1551764896-8453-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the document to the standard Documentation/ directory instead of
creating the same directory structure under objtool/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 {tools/objtool/Documentation => Documentation}/stack-validation.txt | 0
 Documentation/x86/orc-unwinder.txt                                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {tools/objtool/Documentation => Documentation}/stack-validation.txt (100%)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/Documentation/stack-validation.txt
similarity index 100%
rename from tools/objtool/Documentation/stack-validation.txt
rename to Documentation/stack-validation.txt
diff --git a/Documentation/x86/orc-unwinder.txt b/Documentation/x86/orc-unwinder.txt
index cd4b29b..3aeff80 100644
--- a/Documentation/x86/orc-unwinder.txt
+++ b/Documentation/x86/orc-unwinder.txt
@@ -137,7 +137,7 @@ Unwinder implementation details
 
 Objtool generates the ORC data by integrating with the compile-time
 stack metadata validation feature, which is described in detail in
-tools/objtool/Documentation/stack-validation.txt.  After analyzing all
+Documentation/stack-validation.txt.  After analyzing all
 the code paths of a .o file, it creates an array of orc_entry structs,
 and a parallel array of instruction addresses associated with those
 structs, and writes them to the .orc_unwind and .orc_unwind_ip sections
-- 
2.7.4

