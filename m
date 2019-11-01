Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6659CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B942221855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572635406;
	bh=RJbohpJEzp+L7EHHPyLk+IDDnXvbzFaRGkP4Mmou/E8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1BcwdLL2NuaDGGdk63KjEXkujtqotxgZB+LtShvyjp/ZG5vFIUofe+XZZx4y7FdhE
	 gtjUOyBo2ecQ+aAbK2OMveYLTHH7VUUurnGb1AJwwxIntRZf6oE/64TZTe8wEJh4IA
	 eUuLuloxA+B+LuyYF9RV3W60qJncpNlkkX6Xo5qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKATKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKATKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:10:05 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572635404;
        bh=RJbohpJEzp+L7EHHPyLk+IDDnXvbzFaRGkP4Mmou/E8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bIJCwj37Y2xfBjoFuy7Cf0ddAwoT8LycDsbbQkMRxcTXVbFVnyHQEAcWT7L8KNiKl
         XcHSerOTCcpLol/tTxfZ1Xs8s8Ghbb8HXmw5FLuQ6HVXAp6p77/yJUG0VGDxcDEh5n
         n51n2de0W3R4mpC+ly3Kx6DMmoJsZID17mdifeFU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191101174840.GA81963@gmail.com>
References: <20191101174840.GA81963@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191101174840.GA81963@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 652521d460cbfa24ef27717b4b28acfac4281be6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 355f83c1d098c27b3d912c7a397c13be17de6476
Message-Id: <157263540492.17460.17604355824531178449.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 19:10:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 18:48:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/355f83c1d098c27b3d912c7a397c13be17de6476

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
