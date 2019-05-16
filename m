Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52904C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17320848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558030823;
	bh=IPUS+eyddhYoad8A7/YFy1sJjhEx+5nPkU4WTrDZxrU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bC3fg8YgCy8aWO7DOulQ31cnBTQeu7q4FCYGJ6Ek/TOnl+qD4jS+KuWip66hS+omU
	 bXltEYF3WT30KnmlYxIVADaK5Cf0cFduGyiNAwEV64ig1CcboduPkP26wBWqZ7996B
	 v1NTVNS542YP+N30s/O0LajurztWIPxNnKsBDVvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfEPSUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfEPSUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:20:21 -0400
Subject: Re: [GIT PULL] core kernel fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558030821;
        bh=IPUS+eyddhYoad8A7/YFy1sJjhEx+5nPkU4WTrDZxrU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ck2Z0sJSerDwgwUX3nkL6lOetCdpnxYZ0dg5ARTvlSd7WX24DDL64DbaVKksorRwZ
         ZO+FG6xOyHytwH16o/TV1sLK1UcYZgV1hJB+ljeM1Iu6kvnSIahbxVhQq/n8i9nBAT
         7rt3Zj6XThYDQR044nfzHjqrEe3nturYOA7rstok=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516155146.GA48500@gmail.com>
References: <20190516155146.GA48500@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516155146.GA48500@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 2decec48b0fd28ffdbf4cc684bd04e735f0839dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2ca74d32bba153a1507e6b7e36d3ec8a89311a1
Message-Id: <155803082137.23531.2891613963173309469.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:20:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 17:51:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2ca74d32bba153a1507e6b7e36d3ec8a89311a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
