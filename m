Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4163C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41252081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012233;
	bh=33cuH2JuqVGEQ50Is5n63u9Q5nFgOTZYgWhHQ9348qM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vTelJZu294oYzVscdOsF0OOc6uaLj/Ak6EFygd4omR/Lu51sy0hM/2jbrtbGZOOd1
	 iSk5p6/uLLXs2u9yWtQmuTsfB/SnqQS1SrtseUkzniS5nOt4i7bgW/d/w5K8chMtrg
	 1O9/kYORwgI5v7JgEMHJSLdtzCm/86+PA67HJciI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCHCa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCHCaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:20 -0500
Subject: Re: [GIT PULL] x86/platform change for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012220;
        bh=33cuH2JuqVGEQ50Is5n63u9Q5nFgOTZYgWhHQ9348qM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RCU1QH7cWqK0BDIQA8oRk4bodXvXuxbjt+nyqNlRSEcOwPc6vshs3glubum7nZyRY
         Ok1/Ipwt+ck/M94xZ3NO9kShuVlBKM0NH6UPELxxw96U6n9wHh1xHIptCndBjcSQ9P
         iPCX+xgw3OcsMPL9khECqhPuKOQ2t0yPs6ntPfE4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307195444.GA99563@gmail.com>
References: <20190307195444.GA99563@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307195444.GA99563@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-for-linus
X-PR-Tracked-Commit-Id: 1c034a2fe56061af439c4e74f8f6c08e3714a730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60970c18aa95d5ce7716faa67d8ccae4f15fc12b
Message-Id: <155201222030.3231.9633308825857892366.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 20:54:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60970c18aa95d5ce7716faa67d8ccae4f15fc12b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
