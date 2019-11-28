Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC3AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6C215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574906119;
	bh=aN+5GD8NV3gzGWfIassSEs4O7JWq4NVzLu9mz2yHntI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WEXa2MJdF2k1XlE3z8qu3JWjtIaVS69x2DcKE4V2Ofums/kvvda5JdgcXxd8lm8as
	 b7FJJCnt2ze8JakUJci8Z2tdDytm9nk+zHPAR3JiKaPkVw8OpwRg2yR/fg5ZNrCzig
	 tDMhFHoTIRYXsY/Td4+iNnDrMojtWfNHUGwaK1aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfK1BzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbfK1BzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:55:15 -0500
Subject: Re: [git pull] drm for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574906115;
        bh=aN+5GD8NV3gzGWfIassSEs4O7JWq4NVzLu9mz2yHntI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UpzgWwb75SXaQNY3GRcrST+XYgYVMmknJ110ckmf8/GsSa7X6opQx8JYrsLFyGhyg
         VA0Tjh+/Uzfjo0aXNUYzi0+DedlAjyWuwV4nVHIiaSVGCj4ORGkatthqJjjdZags9M
         VpIahxYZ45P1vWbVOxXse1Xk+tQQ82sPSBbiQO98=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
References: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-11-27
X-PR-Tracked-Commit-Id: acc61b8929365e63a3e8c8c8913177795aa45594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6ed68d6468bd5a3da78a103344ded1435fed57a
Message-Id: <157490611542.9858.2117180943496194509.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 01:55:15 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 10:59:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-11-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6ed68d6468bd5a3da78a103344ded1435fed57a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
