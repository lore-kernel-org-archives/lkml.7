Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FEC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CA9206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559850313;
	bh=MGVN98ES0XDXA/KBEwERZEzrN8168ByWPidENysnfnI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0QKheckEGu83tAHp8WttDFgZxOo4w+8wJIXWJ3VAckpMNHqJk3jFRuiLCE2CPbRDA
	 LLhi7z0FcZRHy1v7e64rRsPPs2nBKEf/m6TyfbQHh4Pav/xj+ewlxNDi4eBNuja/T7
	 Uwo8vOc2B9GryzC3D8p6UqWisDpuRQgV/O58zq0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfFFTpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfFFTpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:12 -0400
Subject: Re: [GIT PULL] xfs: fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850311;
        bh=MGVN98ES0XDXA/KBEwERZEzrN8168ByWPidENysnfnI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PD6LEGKZejjpwn4ghSKjDoGxmmh+pzsuXmsHkWL4ocVBISJ8J7gov9X638rsm4OF9
         PTy8+WAXz07I8R+iVM+fxP0dLx1peeFzo8pJepZAb++kPQ0uyiqSsbhpoMt5bGW6oJ
         atA385mDY1aRX0efBdnWAGkMNDd1AD5GyA6CMjYg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606151727.GH1200785@magnolia>
References: <20190606151727.GH1200785@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606151727.GH1200785@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.2-fixes-2
X-PR-Tracked-Commit-Id: 025197ebb08a77eea702011c479ece1229a9525b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01047631df813f6247185547c3778c80af088a20
Message-Id: <155985031169.29170.10646509990041822216.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 19:45:11 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     torvalds@linux-foundation.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 08:17:27 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.2-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01047631df813f6247185547c3778c80af088a20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
