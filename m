Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E64FC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D462184D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682021;
	bh=9iF8QMqM2c5PZf09px3BUdcdL4pR2fcoBUj30hZWwX4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r40o61K/laTJFJLArACEdZbimPXLUOFctDRvEKJJuCgqM157FI2NJfy5+pYGWRHTQ
	 N4SJV/6hgIbKjry7N5jjk2kzK3UB7Hiq92g7mSsx47BkjiarU4Pz0rOP3/pYAINBV1
	 Ga66xZQG9+KRmuyPPdkPqwUKNNl97XWbPSQw42JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfIQBAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387422AbfIQBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:19 -0400
Subject: Re: [GIT PULL] objtool change for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682018;
        bh=9iF8QMqM2c5PZf09px3BUdcdL4pR2fcoBUj30hZWwX4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kPj6ze9zbc6jKG8ixzk1hjQ+BuWPAM1uh3sFV6s0ME0IwJs1LAUpaoS9rLLkILJXZ
         m8Ekkl+cKVSj5CQmOn1T/nUQ2ppTVHvzquM9YqHHHrHpwexQLO/cbvgQCy3wfqhJjk
         Ds2h+OMkS9TF+TaEmTlGCc0aQkte5HjA+tFDBR88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916111530.GA86274@gmail.com>
References: <20190916111530.GA86274@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916111530.GA86274@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: f73b3cc39c84220e6dccd463b5c8279b03514646
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d75a43c645c26ab58118bd35405666a12971350d
Message-Id: <156868201850.3683.3248744985007492897.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:15:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d75a43c645c26ab58118bd35405666a12971350d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
