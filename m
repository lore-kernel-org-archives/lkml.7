Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A803C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D732082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H048f8WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfFTMnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:43:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P6wLfL4v65TmS7pOg/8udBIAPlJHmV+Icj7XRJLu7O0=; b=H048f8WAqnd230Llx6ZkUnsMR
        p+t7HnmbbkRapjtnpgMB/4eWZiPI0PEfOlluzuXPh7Beq8cMe0abciJxzS//7pSah9LK/U/93Gl4V
        Ldws44ODFTiefI9iP42XRYuKUUA57XpH78r8Beeu1827cLchjrDzGYbAC1K5Bdy5mzuKVW6lZ8tcu
        /17T2ArTrKhBaGA1u3ESw+4bsiEYUJlFw8YzaD9mdpMzlV9USajaJ+dP7iDpqgEJUNW4oZFXqoIxE
        f/PBiMXJ5qH1FOg5dWW90Gvszuylm9EE2qkgb3AOcBqYZuVwm1YxO43o9Q0Sj9BlKpQ4ZRsw95XH7
        xW5o1C2Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdwP8-00062B-9N; Thu, 20 Jun 2019 12:43:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFDAE20316587; Thu, 20 Jun 2019 14:43:00 +0200 (CEST)
Date:   Thu, 20 Jun 2019 14:43:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:perf/core 23/33] arch/x86/events/intel/rapl.c:781:23:
 error: 'INTEL_FAM6_ICELAKE_DESKTOP' undeclared here (not in a function); did
 you mean 'INTEL_FAM6_SKYLAKE_DESKTOP'?
Message-ID: <20190620124300.GY3436@hirez.programming.kicks-ass.net>
References: <201906200702.n7RdDWBw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906200702.n7RdDWBw%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 07:38:07AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> head:   3ce5aceb5dee298b082adfa2baa0df5a447c1b0b
> commit: 2a538fda82824a7722e296be656bb5d11d91a9cb [23/33] perf/x86/intel: Add Icelake desktop CPUID
> config: x86_64-rhel-7.6 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 2a538fda82824a7722e296be656bb5d11d91a9cb
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86/events/intel/rapl.c:781:23: error: 'INTEL_FAM6_ICELAKE_DESKTOP' undeclared here (not in a function); did you mean 'INTEL_FAM6_SKYLAKE_DESKTOP'?
>      X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_DESKTOP, skl_rapl_init),
>                           ^

Ingo, I know you're busy, but I think this is a merge fail, these
defines are in tip/x86/cpu and/or tip/x86/urgent.
