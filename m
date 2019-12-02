Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F81C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67CD218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575261618;
	bh=0fmDIcr0IVxLtzteFvstOwhXwd+L714woQtmppR53JM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fMtMZyGU6vdNPtu83BHlHpeKVL2G6XwWTfLanhoP6fne4CPKi+Jn6pRrWtyHYIhZd
	 +j+fcV1l8eOmNcEJZ2nynGv7SHLqJODuebCz8gQ9/AAuprqoALraQVtOe1TJ4i4hz4
	 Aplad+BctZi5oefoE6GCySsq4spEl+8BbZoblorI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfLBEkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 23:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfLBEkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:40:16 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575261615;
        bh=0fmDIcr0IVxLtzteFvstOwhXwd+L714woQtmppR53JM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dE4TjxWMm0u4O80osIjiB7zprZr9vHX/DIOo0vOhgOAjSGqfMstgAUmpDBOcPg9pb
         d+RBntzgP1U6eVIfGY1ffsDCGsKbPWNkDvTDkDM6BPZlTU3kjHnK/o0tgFgWPYFF1v
         q8KcHYKXsvBvG8ybQ/yavaKtq+7tC8nrk764gg8s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201221522.GA7267@gmail.com>
References: <20191201221522.GA7267@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201221522.GA7267@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: e680a41fcaf07ccac8817c589fc4824988b48eac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7fcf31f7036895ca8fc3a30eefffab0e82f75f6
Message-Id: <157526161541.3812.9567285687423815792.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 04:40:15 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 23:15:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7fcf31f7036895ca8fc3a30eefffab0e82f75f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
