Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3ADC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA4A21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566578708;
	bh=I2V+EjWpqRre5Ds4FbG7nrkWjfPQMxu19zfRJ/N0Amg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eCZwN7mrB/p9WBj2J8CA5x4kZOEF9lIa6PpzAEMUk1d4wpnU95eQwvg/x108+B2mB
	 iFXWwjR5Mj38lG9poDDNa+tBRNBTb6KW8yDv92JVNL1rTpJSFYK3rA393uly28EVlT
	 1Ch73K/ifl5NC99b2eXEdUx74GfaC5yk4cR4HW4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405979AbfHWQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732572AbfHWQpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:45:07 -0400
Subject: Re: [git pull] drm fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566578706;
        bh=I2V+EjWpqRre5Ds4FbG7nrkWjfPQMxu19zfRJ/N0Amg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z/eo8Shfww+AyIIKb1yGpOfR0fbgVn4DfGOyVBBOypir0u9R0difMbn3GgKxVnWgD
         kn4LtC/f7au4o/4elcAmJ7QU9r21WnIi3mDE6qi6QrurAN5PVs4y7RbA7ZytJ52g3l
         a+p01bow0a7eQJflml1XcSDWTf4U9w1r9yHk02+8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw7pU3_Y=2b0G1u12cn6ZRAB4ypabJz=HopbQ-JLP2zwA@mail.gmail.com>
References: <CAPM=9tw7pU3_Y=2b0G1u12cn6ZRAB4ypabJz=HopbQ-JLP2zwA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw7pU3_Y=2b0G1u12cn6ZRAB4ypabJz=HopbQ-JLP2zwA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-08-23
X-PR-Tracked-Commit-Id: 75710f08ea7e41b2f7010da3f6deab061f7a853b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1374a22e0641783a5fa25a18f23d9d7a91c38add
Message-Id: <156657870662.6801.1534341682613399532.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Aug 2019 16:45:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Aug 2019 12:07:12 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1374a22e0641783a5fa25a18f23d9d7a91c38add

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
