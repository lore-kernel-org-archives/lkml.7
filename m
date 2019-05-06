Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EAAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DC420835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186058;
	bh=fMxr4XCRroVX8MNprbGIlHphkUhCBJEyGxyv0i04rh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ApL0pRD5sv9bumfMcHnelqqZiPiYieYWVZqTG46WQ8zfkmwPFyA6uDj5q5CsGu8ul
	 dUS4jX/L1tBtEuK1rjIUc+nh03VVYhdSUfN2Z2c2TVm1IoTVZQTPRY4KihAQRD7XTB
	 P6EB3RbynYSUWYyCsdCQcFrna2qwQAn/9UTC+N4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEFXkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] perf updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186007;
        bh=fMxr4XCRroVX8MNprbGIlHphkUhCBJEyGxyv0i04rh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KueRGipvu53LZ3Ih2Lz4mBTMsdchNxIuDko6Z56U0xEGzhA/OijX/8gMtRWQLT7YP
         gVQWYmzMA1vAOzD3w+Bj2lYiSjJYFqaRYPn4uc1kZ5K3bOMwZJthqjeqPsnkiPpFsj
         E+JY2euMDr+9QlRF7Xl70LUnZIe3tpgZJ9lcEKU0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506090311.GA80882@gmail.com>
References: <20190506090311.GA80882@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506090311.GA80882@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus
X-PR-Tracked-Commit-Id: d15d356887e770c5f2dcf963b52c7cb510c9e42d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90489a72fba9529c85e051067ecb41183b8e982e
Message-Id: <155718600783.9113.6377920563369095294.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:07 +0000
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

The pull request you sent on Mon, 6 May 2019 11:03:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90489a72fba9529c85e051067ecb41183b8e982e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
