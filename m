Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BCB20878
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796620;
	bh=3GUsvmtJruT9A+uYaLFJ3+RRH6vGgH8EXLMyqFaHq4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OTBNsDDn7Z32QWYe2ZQgNcxn3noDf4F6RdqCOn6ymHVHQjqJv9wHtqJSpnro70bQ+
	 wQTwsFsCZygouaJUhnpl+GfS+UXi8oQDkQIfaePkm3RKHw1yQpECcOxk6wrUF5doZO
	 6yN1DnJHWNpv9VN7n4P9fFylCNTy4eC2xweqM2No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKZTaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfKZTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:11 -0500
Subject: Re: [GIT PULL] x86/cpu changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796611;
        bh=3GUsvmtJruT9A+uYaLFJ3+RRH6vGgH8EXLMyqFaHq4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1ZPv6aBF/MQ/tU8ACpIfbpyLdUp91OZJZfgeLe9R3rSoxc+pavrXNmAfObk94qONI
         eWxkcfp8BnZUrImkzwXd8CmNuj98M3q7YOhHK+/locII3s6bXMcDHl+g6Zsjy1hiE4
         jLlBhadIYLA+77oEvYifId+eTcfjBN0/g+CwhIWs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125133826.GA88582@gmail.com>
References: <20191125133826.GA88582@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125133826.GA88582@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: db8c33f8b5bea59d00ca12dcd6b65d01b1ea98ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a25bbc2644f01a9e680af4f760b54bd4834fdfec
Message-Id: <157479661122.2359.16048585654600766047.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:38:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a25bbc2644f01a9e680af4f760b54bd4834fdfec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
