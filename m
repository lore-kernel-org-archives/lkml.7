Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC9C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196420659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571003407;
	bh=ToE1DorUZudj4mlr1MAqQhh2vDBJFdV6NGG4/OdiB1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YUtSnMmkjsOTHDh7mxbk3lYRaNkZ33v/RhhN87aWQvGrhsaWzjzfsE5wgRf/wrV9U
	 rKT+xxae7alnhTZlsoFQ2KLLMO3kJBYS4U1lckIRq8zogVz+k96nGIx4bW9/pHDslw
	 QBUImnAKaS0lMAkTM8q9UA0X54bNaRVp5GKVKvGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfJMVuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbfJMVuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:50:06 -0400
Subject: Re: [GIT PULL] tracing: Fixes for v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571003405;
        bh=ToE1DorUZudj4mlr1MAqQhh2vDBJFdV6NGG4/OdiB1o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=skXcaO9Jfr4VTjmVOAo2CTDPQkPTSDSIzMaLMA9RJvMmLw5JERdjGtgcAEaH7+Zy6
         YLElS2g35jGGcB2AI/X3k+EWYe81cpOOmGZ3Bi/4A0m4chCr/OuTNC0Rkv+QMVk1qT
         pCEwGKqvpUVJYxHWJrDQF6JMqHKGZsxX+t/iloNc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191013150702.183320d9@gandalf.local.home>
References: <20191013150702.183320d9@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191013150702.183320d9@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.4-rc2
X-PR-Tracked-Commit-Id: d303de1fcf344ff7c15ed64c3f48a991c9958775
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4615e5a46800d2193bf8ae98cb470206f5f635b
Message-Id: <157100340551.26744.12622905342925812343.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 21:50:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Oct 2019 15:07:02 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4615e5a46800d2193bf8ae98cb470206f5f635b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
