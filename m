Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F01C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615BB2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570919719;
	bh=JITtSxP/HxZrZ61I5BLCsBW89FTmfjLXREWHkpwpUN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bM4WHqdlvHVOnbOQ4EQbAs108KVaAOL7Efy1kk3SYJewVn8F7zMmXxVJFW8pSwAj9
	 +TqHXKRPPC0ryRZXnVD5e59jQxRbTSGZJcp0nE1fc276wK+PUawTF5/voozbXU6+lE
	 AywHFCNxBXbY1GtQsFKwnI/ccBe1dyDFt7NJBVhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfJLWfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfJLWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:05 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919705;
        bh=JITtSxP/HxZrZ61I5BLCsBW89FTmfjLXREWHkpwpUN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t8fX/DIYv6kkQdNiJ5elkyP6YUMQ3LHCjMCzLvIQ8Bv3xcEvuXgTv5iWaX5QKQeKJ
         N4x8dLRp4cRr9C3RAMSbSAXCEfaEuqSmZvSqN+rLnEnJheoB6SjQszsVSGx0xgOndl
         Y8fXi7gAdXGe5Dji9JWQPhA3AiBRpTMlwnbMKT/A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012131916.GA26964@gmail.com>
References: <20191012131916.GA26964@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012131916.GA26964@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 8d7c6ac3b2371eb1cbc9925a88f4d10efff374de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a275fd7b9519b5cc63270a8964055aadb04de26
Message-Id: <157091970545.17047.897131269847053808.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:05 +0000
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

The pull request you sent on Sat, 12 Oct 2019 15:19:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a275fd7b9519b5cc63270a8964055aadb04de26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
