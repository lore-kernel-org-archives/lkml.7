Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CAC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D0C205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557094215;
	bh=981ibyeTtQeTQ63KOzAJiZfwHUe9rhMEo4a7rGZIysU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lo8DCMcPJiSKnRbUfSJZbQbow/Rs5muw9/gtIVOHa3wohjNY0MqLpuWLw0GJVihrN
	 dnHi+ndLIjeUg3RrKHFA/uH5OqNwlJLsErLM4Lv0yNaO0VFyrs8W4wkDDqr5KO8osZ
	 NRA1F9uIEluUJTcx1N+icLO8GfisA9lnvYAWrfQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfEEWKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:10:05 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557094203;
        bh=981ibyeTtQeTQ63KOzAJiZfwHUe9rhMEo4a7rGZIysU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s9GV0G1WsuQo6nYlB7pq+v6vU4Y55WgzZuJZ1TNrk/g3LVqRuU8oZqcnu5ahWJZM9
         5gz8DHF9e77PztpPTJMpAcA5YhPEYc1hjI+JCFAhzW+7Kl08FARFz7DI8k4TS1RaW2
         6/ll+1u3Y2fJX/0EK3n3YI1qHdIH+jjuckOPCAnw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190505110029.GA87041@gmail.com>
References: <20190505110029.GA87041@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190505110029.GA87041@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: b51ce3744f115850166f3d6c292b9c8cb849ad4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13369e831173251e2bc3bc2a78f67c387e8d9609
Message-Id: <155709420390.22198.3904678296790495445.pr-tracker-bot@kernel.org>
Date:   Sun, 05 May 2019 22:10:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 May 2019 13:00:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13369e831173251e2bc3bc2a78f67c387e8d9609

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
