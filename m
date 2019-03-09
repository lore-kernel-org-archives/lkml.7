Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8554FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B362081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161328;
	bh=qsKThs9gwXU+bMDT4ge+8/ai+COZ926DTE4Sjf7yDrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PZ4wjs+FKLPx54fs9e3SkTLhR2oXdoetVTeahSEBjoXP/YW9+meo0FmRd4smEb9BO
	 fcxsWxrmlgopDZmAhe4QwL3QMIxGPeYBunzNKqwQJFDjXxxy4wtCXgPrQmVlKHM52/
	 JhzZ1hJ1Iyhj9Tf0Km8j8Ny8Q+fo+iWUN2mbd43U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfCITzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfCITzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:18 -0500
Subject: Re: [GIT PULL] printk for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161317;
        bh=qsKThs9gwXU+bMDT4ge+8/ai+COZ926DTE4Sjf7yDrY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sLGmO/IwT5t7EJ/a7NmowYrWOWsW5d7U4/KQruNZBxk+sez8zfsGYZVL8TJK/3fY+
         2b9WUcyIZ3cgk7+s4DNmW3uNCwgGUHrJ1BDdA7WfzvX281OBKDz4/G5luyQfUYVv6z
         97xtREKUTULbCZ2Acy2WlrXinsMuwlqj9ovV4zW4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306144444.r4rdkgubipvsoezs@pathway.suse.cz>
References: <20190306144444.r4rdkgubipvsoezs@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306144444.r4rdkgubipvsoezs@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.1
X-PR-Tracked-Commit-Id: 943ca6ad81e5b37bd5d22cbab5ad06dc97fc001c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4703acd6d4a58dc4b31ad2a8f8b14becb898d25
Message-Id: <155216131763.23333.11197163593609256474.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:17 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 15:44:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4703acd6d4a58dc4b31ad2a8f8b14becb898d25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
