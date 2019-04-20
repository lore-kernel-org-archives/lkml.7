Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23821872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788306;
	bh=fXb67RQb5kOUTr5H2pAt8Mwnuse1sLcfuOrFlaNekgo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=REt4qyRp/JVn20uEBJ5US3XLqhYKRia9LOOevOgxQZF2014FcbLlP0wBpHVC56Q+6
	 JPTx5ImCsB2wh4lmDPgQ//TtUuFVgaJ2nSD3pflH/6kpGOm8wlXqsJSqWGgD0rXZ0t
	 SgZH6V5AQeujBHNbEP8p3l9sjVX2D7dTax2OxanA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfDTTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDTTZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:05 -0400
Subject: Re: [GIT PULL] locking fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788304;
        bh=fXb67RQb5kOUTr5H2pAt8Mwnuse1sLcfuOrFlaNekgo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SD6SPl13ekAhG1eWp5MAYEPAupo83t5tOp1FoBgYqFP4YigyhEFLZutYMAtfPt6e0
         oVp4dZWDbKvorJZ3nPEGz1QQwPpRbHdf4K+ZQrwykOLqZnCkPXA0UzZNMj/SrNlp68
         hiGSKHq7FOomDzlzJWn4H9v46NdJT4T5IjHXr19c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420073018.GA127076@gmail.com>
References: <20190420073018.GA127076@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420073018.GA127076@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: b50776ae011cfd26df3cc2b4af8b2dc3b683e553
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de3af9a99013fdb0358bb990e9bed0172c65bba9
Message-Id: <155578830439.28386.4857758828840959254.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 09:30:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de3af9a99013fdb0358bb990e9bed0172c65bba9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
