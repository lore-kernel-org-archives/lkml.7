Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E08C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4EF2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LK7quXHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbfDQOHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:07:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbfDQOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:07:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE6god3933288
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:06:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE6god3933288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510003;
        bh=ec/yi9+sP0b+Lnu0fP3mUrEnbE30mPzg+JReSb6IhIo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LK7quXHvOn3Bu8B62jQleUiodh0cBNBET4oWei0QYz+UJ0Cigh8CFyD+c8Tuql3dV
         XW5UqkQEN7oky7i1ttKuHoBXqc+jfvuoMxqN1NPr/8Uep9ZzRIRUmYzPChWJ1JwhJc
         rrGMGrRUTCEFMkRLKu/48/2mSUunt9aUmfsdmxrTDnmqJ5sYnAGjzW3JY/0sZiBl23
         FJ4GI9adTWWfs0W5cVe7FmOTtcrMhb7jKZ3PKi0R47Iyv53UdLq92buCIE+MD1H6M+
         gJc/kOxdCue7ZeFUlnaeQ0kMJnzmj9hXgjRk3GK+aUbi6vmOKy/KG99I83URLfbrpz
         JLgfOmUAgfczw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE6dBY3933285;
        Wed, 17 Apr 2019 07:06:39 -0700
Date:   Wed, 17 Apr 2019 07:06:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-30842211506e376b76394a9cb4e6d0c9d258b8d4@git.kernel.org>
Cc:     jpoimboe@redhat.com, mhocko@suse.com, bp@suse.de,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        mingo@redhat.com, x86@kernel.org, tglx@linutronix.de,
        luto@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: bp@suse.de, dave.hansen@intel.com,
          sean.j.christopherson@intel.com, mingo@redhat.com,
          jpoimboe@redhat.com, mhocko@suse.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
          luto@kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190414160144.227822695@linutronix.de>
References: <20190414160144.227822695@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/exceptions: Remove unused stack defines on 32bit
Git-Commit-ID: 30842211506e376b76394a9cb4e6d0c9d258b8d4
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

Commit-ID:  30842211506e376b76394a9cb4e6d0c9d258b8d4
Gitweb:     https://git.kernel.org/tip/30842211506e376b76394a9cb4e6d0c9d258b8d4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:44 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:45:29 +0200

x86/exceptions: Remove unused stack defines on 32bit

Nothing requires those for 32bit builds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.227822695@linutronix.de
---
 arch/x86/include/asm/page_32_types.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 0d5c739eebd7..57b5dc15ca7e 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -22,11 +22,7 @@
 #define THREAD_SIZE_ORDER	1
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
-#define DOUBLEFAULT_STACK 1
-#define NMI_STACK 0
-#define DEBUG_STACK 0
-#define MCE_STACK 0
-#define N_EXCEPTION_STACKS 1
+#define N_EXCEPTION_STACKS	1
 
 #ifdef CONFIG_X86_PAE
 /*
