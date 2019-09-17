Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A86C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F6220650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568688957;
	bh=MNZvKrOP1b4c8tmraGFfiW3PWkZOnungJgqVe4dqV1w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QyVdq5EDa+1a2JPPehfgpx98YIf6oJSqxAfxmlcSWbCEQlGOSvWT3OLqwttp7nIur
	 rQYfyy7n3uk1gUSe3KpDZFDw4r8Ruk2KQZzHwbWYaV+m2m7ePGm6wKczY2bihtMKt7
	 E1dGWZRdBAF4yLHR/kQh4ohzpJYcGGUpqO9yyb1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392079AbfIQCzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392061AbfIQCzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:20 -0400
Subject: Re: [GIT PULL] x86/build change for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688919;
        bh=MNZvKrOP1b4c8tmraGFfiW3PWkZOnungJgqVe4dqV1w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UA9Xn2HuTDrPZ4vDWaHHCnVag0yJzkQpVQgRJCkE7njjoBfl0fgdDSlG2+gEipGY8
         L6BPJtpsvyq6Gky6ZEhq8Ddh+N5/ffJy1hs6bBK8Xzf5hh2oDku1JWsObh/hu0MEHS
         Ri+a2NNKZ7/ckDjCfU9CY9KOGK5lgohvZk0p+owQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916124256.GA9811@gmail.com>
References: <20190916124256.GA9811@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916124256.GA9811@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: 701010532164eaacd415ec5683717da03f4b822d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc6fd1392a8f3d5f3d722ad9c92314477c1a2a35
Message-Id: <156868891994.5285.918269710682268621.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:19 +0000
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

The pull request you sent on Mon, 16 Sep 2019 14:42:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc6fd1392a8f3d5f3d722ad9c92314477c1a2a35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
