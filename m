Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CEC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4342171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682040;
	bh=ycwSglDklcn9FNIrHXjjngLLtXhr8rzpm0qxrEbsCYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qDheGpKdYZ3Iho+9uEo70V0u7+wIoMMWn/dg83FmNn3I2cZ8eMd9x+qxMDCqdGHTJ
	 pA4UoODnbrdHm7+/p8fixSzfIGGPco0tIHvURNSlL1/sZwa7GJ2ZKb8pwm4y+2l8SD
	 iMAdS8Qjpnec+O5N83xaDwVeKVrChu6YTcKqyWc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbfIQBAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388560AbfIQBAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:24 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682024;
        bh=ycwSglDklcn9FNIrHXjjngLLtXhr8rzpm0qxrEbsCYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JnTiYydnCRgreUbint9qt3h/MEAd+qeNagwEmShX/QeBWiEadaKVz2fGB5b33p/LU
         PCY4MtgYkhp3uyNjJ+el3Gk3jRqNfXLfqb19uv6kSPkvpzGk8yGmp2q6NqSNIefNEN
         C+YG0I9NJq9hv4b0hrWx21/aD6DaY65DboYVyNxI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916123047.GA102572@gmail.com>
References: <20190916123047.GA102572@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916123047.GA102572@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: 563c4f85f9f0d63b712081d5b4522152cdcb8b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e67a859997aad47727aff9c5a32e160da079ce3
Message-Id: <156868202447.3683.8954778587037251570.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:30:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e67a859997aad47727aff9c5a32e160da079ce3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
