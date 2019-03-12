Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632F72171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552353617;
	bh=Wnk0q+CbhvWFTpRdlT0epmMGZR14yB324U8XK7qYnmA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=izwWcHwO7/2fudnWRa/RdFAeR/SORQpXssYc5kox/vkVsqsz0qbDzyyvhHyi1ykXo
	 7OTLJ041o68+R8cfEvlvH3TaKw1XCQYeDILBUBzngTtvOZXwO7N1Rb6a7MJhAU7hr0
	 zfHLcnaQsNN/mKC+qM6iMJn9W5tK5fYWIlRMWwPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfCLBUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCLBUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:20:15 -0400
Subject: Re: [GIT PULL] tracing: Updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552353615;
        bh=Wnk0q+CbhvWFTpRdlT0epmMGZR14yB324U8XK7qYnmA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fGN70Gglv+uvjrB76bxO4rr8BUqfGdcBLeBA3HNNPF7uKpAtwSdViDxHNN3R0313A
         XcjS7HQ+9mg9m/NFIfaf3CQ3funMdgoTkjsOXcTos/1IkqKDKoSrZgN8nxuUnMUCvg
         txshhJ2eHOooe+fIofyNkzgd4udAM+76Kvad8w2U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190310234019.64da3b0b@oasis.local.home>
References: <20190310234019.64da3b0b@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190310234019.64da3b0b@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.1
X-PR-Tracked-Commit-Id: 85f726a35e504418607b77c5e7da165dc1ea63ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cdfa54cd22984ae785b0d496b53405d6da9ad1d
Message-Id: <155235361504.2216.1846518876412959789.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 01:20:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 23:40:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cdfa54cd22984ae785b0d496b53405d6da9ad1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
