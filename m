Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B387AC742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910882089C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563129939;
	bh=cdoxroows08VQXmRVkk4af7RvDiwg8wZ3xlfaKMvLLM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lHlvr2vSdmQ8Hh5pdhEQ97dzgxyFozpz30uQXDOpy6lOGVO9qWpamVTx5GIpk62Tw
	 0zt0ZArvRVxIg0Hlh+35iaXCxkmW0raoJXxXIOndTH0NqQqymJETF5M0FWMOPwd43r
	 FiZdgOXNw+OuVyyQCRPAc79glU3LyDaMqCMMtmxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfGNSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 14:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfGNSpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:45:16 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563129916;
        bh=cdoxroows08VQXmRVkk4af7RvDiwg8wZ3xlfaKMvLLM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wDr1d4IIvxJpWJb4kozIarjLyouJ4fzWhQ1DsSe5UXIAkcP7tTDwFUvKXQ7jd/AS9
         KTtCHo/BnONEL5VExTUIG2w4jGWQbhjmwOChJPEUKDs63eWvP8mM6FZN7egn+Vd5AD
         YpqGjlQlRv2LyRF1+riPgxKVbFq12Ykk1vLPgSb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714120102.GA86321@gmail.com>
References: <20190714120102.GA86321@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714120102.GA86321@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: e4557c1a46b0d32746bd309e1941914b5a6912b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d039859330b874d48080885eb31f4f129c246f1
Message-Id: <156312991608.23515.18364933446057172159.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jul 2019 18:45:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 14:01:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d039859330b874d48080885eb31f4f129c246f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
