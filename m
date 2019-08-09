Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5655C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48420C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368536;
	bh=wQZwrZib4V5IoBim3lmKFxlSHDEW90c/a7uHLnGBg9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jiYAgE38xt0sObrY8ra9gjKTw1j+BETbR5enzZY9HiL95gJWN+5lICu3QH/MVGqbv
	 xQkoV5ZxSndtxeCQrzzJ/ikGrDHOx/KkbvS9w+c4nsJ0jICd648+C14SYrQsr/7DCO
	 b+U/mDYTSdR2tStlGCymR87x60NFUg6YCUNaqqyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437428AbfHIQff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437341AbfHIQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:11 -0400
Subject: Re: [GIT PULL] fbdev fix for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368511;
        bh=wQZwrZib4V5IoBim3lmKFxlSHDEW90c/a7uHLnGBg9g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OTB1Z74vJ0brP0BiQyF7xSH4p/nImnf8musGCZVgzpAyn9PCCWrXmugxjAxYIDY/5
         6NASRz7Pd3rbisEHLD8pzEG+t8gQIBlrygduIwnITrYLe1MIhp/PQKOexz/NCqC4H0
         vkTLOdyZhA3X5ELD5twK8/c+If6qhHpBfdnXUUzU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <22bfe177-272e-afe8-31d1-75bc0cf852c7@samsung.com>
References: <CGME20190809140736eucas1p2b14d3205aa7268cd1a6bba15ebd81066@eucas1p2.samsung.com>
 <22bfe177-272e-afe8-31d1-75bc0cf852c7@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <22bfe177-272e-afe8-31d1-75bc0cf852c7@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v5.3-rc4
X-PR-Tracked-Commit-Id: 6a7553e8d84d5322d883cb83bb9888c49a0f04e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec4c99ad7bd23dd39ffb1381136cefa4bb632e31
Message-Id: <156536851114.6429.5323105238493947059.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:11 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 16:07:35 +0200:

> https://github.com/bzolnier/linux.git tags/fbdev-v5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec4c99ad7bd23dd39ffb1381136cefa4bb632e31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
