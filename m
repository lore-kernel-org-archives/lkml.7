Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0725F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553226913;
	bh=gmsBA7cKN2drfWaryqXspmb/6UN3K22vz4qSu9KoXRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Iai0j7xQARp2QOlypFAumjbC6YcEeIe7kOt1IU/bI5iwMyiH4hgwGhsQXr199dmVJ
	 gg6s3sEn1zkIAMr8XmdIYpn53qyY+nfCTRw4suw+tfW690z46CC1SVpSJ9bgZ2MLCT
	 443znwZGz8vdb//93U1NAKiTbjxIKar/zQvUVp4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCVDzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfCVDzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:55:11 -0400
Subject: Re: [git pull] drm fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553226911;
        bh=gmsBA7cKN2drfWaryqXspmb/6UN3K22vz4qSu9KoXRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SudtSubUETjo2bOG/XxMqdM2RP49irzNkpswJuAltYiClH7lviixswMwBPxlXGdZ8
         H668i64F2qmf56/yVlh1CFAa5jgc8uRmcH3qyRSW5aghe/Luw6RZ1vYUw8FqzLQx7J
         s6AVlU2eDv8rSRaPEWTRuGWPxlTBZR8eaixWHMx0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twckrmLPgfXChh6L1U-fZBr9G=s2JvXUjgorM4x4djAbA@mail.gmail.com>
References: <CAPM=9twckrmLPgfXChh6L1U-fZBr9G=s2JvXUjgorM4x4djAbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twckrmLPgfXChh6L1U-fZBr9G=s2JvXUjgorM4x4djAbA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-03-22
X-PR-Tracked-Commit-Id: 8e078788b57df678d2d469a8489748bf856d6f28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd1f297b794c77e52412dc621b5884210291eeee
Message-Id: <155322691115.29441.6228108543601363550.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 03:55:11 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 12:20:28 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd1f297b794c77e52412dc621b5884210291eeee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
