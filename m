Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FCC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54378216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808711;
	bh=iVvq+ayGoGDBwgPA5ekr/tK52S6iiwUrinGz7/NS0X4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=y3XI2nHwLs1gxdgUL6bbmaexoZjADfOo6gqTDjWkw9RBu8AfkGNkkp+ilCBoAJaGd
	 AR0EGmeyY6uncVp+j91IrPQwO11yF7tzPFbs8DenpaP8CmxmIHgkPYL5ts6MgXPSlO
	 +hx72B5jLMZF2fg6NDOuHIL2dLOl+my8OXcndza8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfF2LpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfF2LpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:45:07 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808707;
        bh=iVvq+ayGoGDBwgPA5ekr/tK52S6iiwUrinGz7/NS0X4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z9wrkbTAeCrLD+bfF9rxItp+4wgaWQAw2Ao7BPN9B3CfDdnFuwCcP7dNG98Iuvgjt
         +30Sp6H6i/YCJigI3QU24eOpqpt2r8kupIjMQyHk+kcrVG/wGBccbezUSus2Rm6x25
         C2azLjQgHMPq2pev120LTEII+LGrJ6kddz8/ckKs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190629085439.GA123694@gmail.com>
References: <20190629085439.GA123694@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190629085439.GA123694@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 8b12b812f5367c2469fb937da7e28dd321ad8d7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57103eb7c6cad04c0611b7a5767a381b34b8b0ab
Message-Id: <156180870696.30344.1314770153262884680.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 11:45:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 10:54:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57103eb7c6cad04c0611b7a5767a381b34b8b0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
