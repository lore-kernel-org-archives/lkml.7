Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9220684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070194;
	bh=57X9sSdgw7XookuTLhc5s+gOiRQjJkmTyzR0B/bWaIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2jOs9s0N2o5YCfHyu3aZjvqkq/yKNONoAODnVfjXIpHp0qdo9wGF8xKImgo27DT8/
	 AF3eUXN+S3RLz/wh3cXSqGLS7Nlp83KayHAWoIVgdEOvoCm7sOrUp233Beypgx7kxe
	 JnX22GBzKu0akrHaf2jxpFPwbc26MF4znh+sgUtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCHSfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfCHSfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:21 -0500
Subject: Re: [GIT PULL] livepatching for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070120;
        bh=57X9sSdgw7XookuTLhc5s+gOiRQjJkmTyzR0B/bWaIY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bbFIngRlC2YMdn7wpUSuh5tewREs9ePD0tKeE15e+LS/RT6pq1Zx54RrFIVw0G2I6
         A2RyYoJgngwmdNUD2BpxO6dVmlvkWotN+QKnGJLcW/l2942OV5x6zOySnJhpmTVy91
         9h9PsjhFVcRn4Bmf2vwN6CQOS1Ht2D2MZNBFrfHs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1903051601280.19912@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
 for-linus
X-PR-Tracked-Commit-Id: f9d138145686b52b48ccb36557d6842076e2b9dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7af27bf9471f5d54d71dc2e4228d6bc065bdb57
Message-Id: <155207012092.7904.6409355567353825029.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:20 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 16:08:11 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7af27bf9471f5d54d71dc2e4228d6bc065bdb57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
