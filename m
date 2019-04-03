Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E27B2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554273311;
	bh=QHPQUIbu+RtFfc1nOzTb2pkMg5vG8Tv+tIMrti44gY8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lJqCitVAzai3LHtZeD0BQf+hOBQOxavBYLeegP3VWbRPHANfjHifUFC6so5KIiOaL
	 8dMshqfHr6AtkEVCIx1POnOVyvCwEmxj90IvtyMGecwH0RtYmgvaEgEhTiCXKrtfKH
	 vr5hNFXFekquFSvKIFcdi4ahKLiAE9myV/QzhUco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDCGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfDCGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:35:09 -0400
Subject: Re: [GIT PULL] pidfd fixes for v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554273309;
        bh=QHPQUIbu+RtFfc1nOzTb2pkMg5vG8Tv+tIMrti44gY8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tVxD/AIcPjV1D1aGxBSUKXI8lGKS7p/bkqCCuU0kk1Iq3uAbz9RHVsqbwcJl9cH8E
         h+89kQtoDU0v+vfYbzIED+BPja5Kn9ZHOGf0kwTmDPHihWMVNKfnZlAVva+gsJqz1R
         EvTpJ1fiYL31W5kzAAeC9bjfWbwyS6mfvoPbLtpU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190402153307.18672-1-christian@brauner.io>
References: <20190402153307.18672-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190402153307.18672-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/pidfd-fixes-v5.1-rc3
X-PR-Tracked-Commit-Id: 556a888a14afe27164191955618990fb3ccc9aad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a816fd6b49b6b0628b968faefd49a6de4ce27066
Message-Id: <155427330897.25996.16530440556024658663.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Apr 2019 06:35:08 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Christian Brauner <christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  2 Apr 2019 17:33:07 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-fixes-v5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a816fd6b49b6b0628b968faefd49a6de4ce27066

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
