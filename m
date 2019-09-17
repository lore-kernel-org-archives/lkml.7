Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F397CC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94ED2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682022;
	bh=j62/CfMqyqeZqNW/JYVDT5rYGaHqp/6knWDp8kuQWaU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hk8gjDf7CNzO/AnRuiTVEGwZ6j27objd07QiTRS4L+5b/e+VBwOPoV5VgSvn+DD1h
	 BAko0iU3JziWziaGZYRFP5wyONOwqpnX7TxcLNdXO15EYui7IHQ24NAa2P0COptnDP
	 4BYM3oSxaW1MTu2iBIuHToDwHeMyWNdGsv1dl15Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfIQBAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfIQBAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:20 -0400
Subject: Re: [GIT PULL] core/stacktrace change for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682020;
        bh=j62/CfMqyqeZqNW/JYVDT5rYGaHqp/6knWDp8kuQWaU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x2viFstwxhijlVV0WH4ZKcjYHI3ch1OuaiNVSfg888vdpYCtOTYwSVpFPSKQ81U8Q
         8wxG9GxEMRIxVvLpVeUF2Tp3CypNEhQ8p64oe5eZC9btZqT6JTCTugmmQzWWEEAXtL
         jgdGWqEvjNTJdHK4Ztsc36ziY5ASzOIcacVFzIEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916112806.GA40858@gmail.com>
References: <20190916112806.GA40858@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916112806.GA40858@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-stacktrace-for-linus
X-PR-Tracked-Commit-Id: ee050dc83bc326ad5ef8ee93bca344819371e7a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98c82b4b8be60b05bc96aa4ab664ca0b0e39001f
Message-Id: <156868202037.3683.9114755219417351448.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:28:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98c82b4b8be60b05bc96aa4ab664ca0b0e39001f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
