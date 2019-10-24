Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5520684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571912715;
	bh=ygOQ9d56Wrm7cYmz/kj9MjuyXTAPUIdCFYUkH6tgr0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mNjGRNSvVru+MdeeiKHangTnN3X0uRiBPsWhuMZb8J2nL4RS7xwdSSVpDOzS594ts
	 BGKF9L8P3W6qyF8iZN9P3+++KX9lHUuErz5pgip2f0BWkDtgaapM3Czch/7Rh+jtEh
	 +ud7sXv/Vt5h+3uXJGrzk7ToILjyxtCzaBl6ltg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438746AbfJXKZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438720AbfJXKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:08 -0400
Subject: Re: [GIT PULL v3] tracing: A couple of minor fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912707;
        bh=ygOQ9d56Wrm7cYmz/kj9MjuyXTAPUIdCFYUkH6tgr0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jIw+Q8ZpLisx+tmQZinNFZanbmL/buAYo9FAi5rAMMEIM/kxvx41fefxG/1ORLIID
         bUw9W+n73OyjCnC2qLSDW3LmSkUWUCIEAEYre6Zkv74iuaEj+ZStdeqH6puv7Y8swS
         pAwQkFBfq2IYbOIeAkGT2jWEpELf0+hE02FJbuKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191023140317.0597c2f5@gandalf.local.home>
References: <20191023140317.0597c2f5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191023140317.0597c2f5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.4-rc3-3
X-PR-Tracked-Commit-Id: 6b1340cc00edeadd52ebd8a45171f38c8de2a387
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa8a74de0622e97c7d0c9dff8bf6718548bd6e45
Message-Id: <157191270770.16083.4634269635839407618.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Prateek Sood <prsood@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Oct 2019 14:03:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.4-rc3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa8a74de0622e97c7d0c9dff8bf6718548bd6e45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
