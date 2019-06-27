Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530EC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A253E21897
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561610718;
	bh=K5SUY54SELZy1+lViKPOPr+FMJUSCP3gUFGFg03T6N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKH2Durv/Qqafb7gHakgke37cPMSHrmlQkPc+iQcKAtvw61fwLI9vA8Nu6sI37SHQ
	 dnpOGDmAR9icv7qcZWADHZHnj8ZhzCroKXfG9SHd6kw4Fjd35XHI8b41uyxxyAVnN6
	 d8qziT9dTAbwZ+9cVfgNBGfDbh1XhiPzy0Jg7v6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfF0EpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfF0EpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:45:13 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC1021855;
        Thu, 27 Jun 2019 04:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610712;
        bh=K5SUY54SELZy1+lViKPOPr+FMJUSCP3gUFGFg03T6N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcAQbH78K3Q74ErLQKjNUikUSjDpjyRSUPz1TDnnl5xy5zK1TDA53Pageqwq/mjf2
         kxa3bPlibB3B5DpHEs3RDfxs+aBW8hjS7XigMTp4u7tA70CpVo7JlDBKFKkF+k83Qa
         9bORDvXcvy5/k/6Bba+OFLfWx5/CVLA2NCDIX2W0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/8] x86/vsyscall: Remove the vsyscall=native documentation
Date:   Wed, 26 Jun 2019 21:45:02 -0700
Message-Id: <d77c7105eb4c57c1a95a95b6a5b8ba194a18e764.1561610354.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561610354.git.luto@kernel.org>
References: <cover.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsyscall=native feature is gone -- remove the docs.

Fixes: 076ca272a14c ("x86/vsyscall/64: Drop "native" vsyscalls")
Cc: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..0082d1e56999 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5102,12 +5102,6 @@
 			emulate     [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.
 
-			native      Vsyscalls are native syscall instructions.
-			            This is a little bit faster than trapping
-			            and makes a few dynamic recompilers work
-			            better than they would in emulation mode.
-			            It also makes exploits much easier to write.
-
 			none        Vsyscalls don't work at all.  This makes
 			            them quite hard to use for exploits but
 			            might break your system.
-- 
2.21.0

