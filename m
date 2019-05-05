Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD1C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE22087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557094211;
	bh=GEBxK6d0Rf7PG3hosLW6Ck42hTStCtxq4/pO3VuEug4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2evhfjEAKskNW9RTftrGDo2MiUIkOr0oA8/xnvrzQuo2vl/3QkGbCoPk/tCsHw39z
	 2cuVtd3kWBAhsoytW2I6WEAwiujHWNPmkkZq3pAVHY28x7PC3YfquMiVs73+tRVxxy
	 7jR60wfPOTmaNUEUICw/Cor+DYJHrPj8MmwCuzZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEEWKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfEEWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:10:05 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557094204;
        bh=GEBxK6d0Rf7PG3hosLW6Ck42hTStCtxq4/pO3VuEug4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yjToiXUjjIg9XCdwwvND1Ovzef0GXfvL9qrT7ko9ZZXbnZXPuGlhfXcCL9pjhSew/
         d/GUKrD2NNX3sOKAV+3Nz+3LVIljBJ1x+MO7VUCJ0ZHrDMQ4OwGkJsdOshaUuK4Mpk
         6dCdjxrEpkU4cK0j+8zsq4d3FBf0xrq0dE3pNCqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190505124746.GA57834@gmail.com>
References: <20190505124746.GA57834@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190505124746.GA57834@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 6f55967ad9d9752813e36de6d5fdbd19741adfc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7178fb0b239d1c037876301c116fc9a6c1bd2ac0
Message-Id: <155709420446.22198.873615575517516243.pr-tracker-bot@kernel.org>
Date:   Sun, 05 May 2019 22:10:04 +0000
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

The pull request you sent on Sun, 5 May 2019 14:47:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7178fb0b239d1c037876301c116fc9a6c1bd2ac0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
