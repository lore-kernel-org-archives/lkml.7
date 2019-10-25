Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1D21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572033307;
	bh=od6dv325B1ScnB1Odsg9kjS4svIIXuk++HznXcA2N1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oyYgzPFT5ditSgx+M7j7gkPKbKE3Ya5hYHRr2P96kAJDVmkNFik2s7svfT3vRdQ1j
	 lve/AcKdzqhmkI2B/NqPQAyCOFQdlAbgMsRmQ/BKdfNQsCMUHL0ucdzjgV214EeegR
	 C+cndzvahKhb8OSjuBVpAq6hCr8BD0ANo2UCjVac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfJYTzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfJYTzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:55:06 -0400
Subject: Re: [git pull] drm fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572033305;
        bh=od6dv325B1ScnB1Odsg9kjS4svIIXuk++HznXcA2N1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QUP9GzHOUQS3gjvJTZlj71AVm8yTfn2YA3Zn7Pir+QxMl/nucyhGQHBgCWMevNhzG
         DkkAlamQN4Pd0FZCk+aJjIMXjh2ORlqDeKUD2zXrQqm8cXjkOLe+FJ6E6JS4hGYbew
         UJ7L9Wb+tq4FHIQQ2q305U31kQkdtjtTV3yAafH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twWc0UkE53E5JDV_SW4R-4YFxvDBD2n_Cx_vHr0vj0zqw@mail.gmail.com>
References: <CAPM=9twWc0UkE53E5JDV_SW4R-4YFxvDBD2n_Cx_vHr0vj0zqw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twWc0UkE53E5JDV_SW4R-4YFxvDBD2n_Cx_vHr0vj0zqw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-10-25
X-PR-Tracked-Commit-Id: 2a3608409f46e0bae5b6b1a77ddf4c42116698da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8caacaad78b69c4329c2ae9341ae7268ecfbf475
Message-Id: <157203330592.840.10702027105867630712.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 19:55:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 05:31:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8caacaad78b69c4329c2ae9341ae7268ecfbf475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
