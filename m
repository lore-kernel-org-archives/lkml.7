Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC764C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929262133F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897016;
	bh=zjKY4h7d095kd8+JaVFyJDBNGnDwNyS4/T1Vp1hZAQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r2eXsnGh72cGqS2zfLZwmsCv8ES1rpXfWyMbYC4mkNOyc8wsXlJVsorUUd/pyXb/K
	 HjggHDJDABpz0KtyCLP/wIzIFGVxRBTXrk4iR13XTBnJT/qOrMLh6Tkleac3VCcUgT
	 9+2qgf/95Xfe+9HTDJEuW2yYU3b2baKsjAHqWiuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCFSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCFSaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:13 -0500
Subject: Re: [GIT PULL] perf changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897013;
        bh=zjKY4h7d095kd8+JaVFyJDBNGnDwNyS4/T1Vp1hZAQg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SM4pI9EWiQa07Sx1dRI+PMGh1bVeYiAcP5SdS8IufsK8nHUuf2kBw6Y9jBl9GEOvS
         4031j8NljDxISxWX78gIrnSk2QvsxphwJCgDwgWet21VxLtNDb+/m93rs7uVRpmmGE
         Bfsk0HE/y4mzjRyYkEvVP42JUvlafaD4cKOZNmLk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306072814.GB111385@gmail.com>
References: <20190306072814.GB111385@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306072814.GB111385@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: c978b9460fe1d4a1e1effa0abd6bd69b18a098a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 203b6609e0ede49eb0b97008b1150c69e9d2ffd3
Message-Id: <155189701310.14612.574209658541296268.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 08:28:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/203b6609e0ede49eb0b97008b1150c69e9d2ffd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
