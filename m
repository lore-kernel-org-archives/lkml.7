Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE66E21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TyECf4Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfDXQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:00:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfDXQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vDosMQ6WzgaDno1e3FufuKzFK1jLQo5uCacix+sV/FY=; b=TyECf4Cj2SpPLpMvpKFtoYgpl
        yXqkke7+aYYIp/cyxGibob31mrquMWRNBxeota7icLVs4Otl6qDkC5xDPk2k6e+x3ELyg6Q6llqIN
        w/Ybqq9XM4nR/BSJsOoZ3eu9UZM3U67aJGZugZLZGYET+SXmXMKJvrbLLCF0bBEqphkTb7+k5gJl4
        v8e3rRCWz9e7K8/qzXgw1JU/Ik8jbjzPyzlB++zKEJMmItc8sCGX7utyXrh3PPEHj5MK3BDVCiQL1
        0R6MFI2DedIgga8iI3ltYcgqmArP5h1wMqXnHiGDFwd2J/TZRx2W5o6TpRfPd1pbstWUe8qZ+bSBB
        sgu07y31g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKKG-0005HD-Uy; Wed, 24 Apr 2019 16:00:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B8BD29BD48BE; Wed, 24 Apr 2019 18:00:46 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:00:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:core/objtool 26/27] arch/x86/kernel/signal.c:357:16:
 sparse: got unsigned long long [usertype] *__pu_ptr
Message-ID: <20190424160046.GQ12232@hirez.programming.kicks-ass.net>
References: <201904242047.cHccU4xI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904242047.cHccU4xI%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 08:38:53PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/objtool
> head:   29da93fea3ea39ab9b12270cc6be1b70ef201c9e
> commit: 6ae865615fc43d014da2fd1f1bba7e81ee622d1b [26/27] x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation
> reproduce:
>         # apt-get install sparse
>         git checkout 6ae865615fc43d014da2fd1f1bba7e81ee622d1b
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:357:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1> * @@    got st volatile [noderef] <asn:1> * @@
>    arch/x86/kernel/signal.c:357:16: sparse:    expected void const volatile [noderef] <asn:1> *
> >> arch/x86/kernel/signal.c:357:16: sparse:    got unsigned long long [usertype] *__pu_ptr
>    arch/x86/kernel/signal.c:417:17: sparse: sparse: cast removes address space '<asn:1>' of expression
>    arch/x86/kernel/signal.c:417:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1> * @@    got st volatile [noderef] <asn:1> * @@
>    arch/x86/kernel/signal.c:417:17: sparse:    expected void const volatile [noderef] <asn:1> *
>    arch/x86/kernel/signal.c:417:17: sparse:    got unsigned long long [usertype] *

I'm not getting that; I have sparse version: 0.6.0 (Debian: 0.6.0-3)

But I suspect something like the below ought to cure that. But this is
not new from this patch, it's just that the sparse output changed
because some variable changed name.

---
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 364813cea647..1fd714b42a79 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -352,7 +352,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	 * reasons and because gdb uses it as a signature to notice
 	 * signal handler stack frames.
 	 */
-	err |= __put_user(*((u64 *)&retcode), (u64 *)frame->retcode);
+	err |= __put_user(*((u64 __user *)&retcode), (u64 __user *)frame->retcode);
 
 	if (err)
 		return -EFAULT;
