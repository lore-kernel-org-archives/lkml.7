Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C58C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A692175B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636707;
	bh=9dnZe8B6ETsByMn8FwMwKQLPb8ixnu6zmvgbX3adLpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0kuI+58sYEtN1hF2424sh/wYDq+TWcXnNAvdnBS3jw3XxPQ6kkCs9hHOW1Cs+WZy2
	 PrtCSpGLS24CfHNoMk5lXo79BIDJZdBeDaR6VqUvv11tJGulEUdYXUvpFA+a9jfrX0
	 9sJJRvkiMdAbBbme4gsq5MFEMAgPczDR0Kqg+t90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGIBpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfGIBpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:06 -0400
Subject: Re: [GIT PULL] RCU changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636705;
        bh=9dnZe8B6ETsByMn8FwMwKQLPb8ixnu6zmvgbX3adLpo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HOdCrsRIabmMHVLr4vjf7ZVPm03RJ+q5P7VgtBQR+WAo/YlWQdn+mnfvqAoEysgQO
         0NEsevxV1e/qIwW/2iy1TLgXQCdNR8oanXM+mRIR0heYwKtpIahNzYIhY1IqiO3L/z
         DH38QIyYsWoUtDpNJJE17wRA72IPxLeMtQurwTEE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708090920.GA16500@gmail.com>
References: <20190708090920.GA16500@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708090920.GA16500@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: 83086d654dd08c0f57381522e6819f421677706e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f1ec23a46940846f86a91c46f7119d8a8b5de1
Message-Id: <156263670533.17382.16954149676496564516.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 11:09:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f1ec23a46940846f86a91c46f7119d8a8b5de1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
