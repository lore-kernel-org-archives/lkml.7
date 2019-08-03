Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA88C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859D02087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564854312;
	bh=TSln650bzcYkiEDOaL2OkTJxbFUiba8WgboEBSnDfuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fFiUWV3KPeMGTT0pi8TgOr2RpqAZQSALyW3SqsY0pLaHtD6FU68Q5vQcjYJ4OYoZU
	 ZoIaOaCEqSYshDQhAnQzbGdeCe4ukzV/eKdB7YMYri0EznmCsOqir1Ct/LlF7c81b7
	 QWpX54cNDPSalcril4gkv6JqAoYSuINhK6z1gj14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfHCRpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 13:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbfHCRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:45:10 -0400
Subject: Re: [PULL] drm-fixes for -rc3, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564854310;
        bh=TSln650bzcYkiEDOaL2OkTJxbFUiba8WgboEBSnDfuc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VVa6YbtM8BccBMQq/SkhkaGq9V1hnWF9jetDOPgmyP2aaUIUJIH2t3cMSvCmzmyjJ
         0bS2lmHsB3b8PJZHMcWlrksofFaTEBqHJVmKdZlqJ8X4YNLE9tspVUNjhuMfEVBpPt
         UOemlxqzgf+4r9aG2rlAx6RHu1d9WGRkwmq0e9ks=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802190552.GA12933@phenom.ffwll.local>
References: <20190802190552.GA12933@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802190552.GA12933@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-08-02-1
X-PR-Tracked-Commit-Id: 9c8c9c7cdb4c8fb48a2bc70f41a07920f761d2cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e31225f99e077d0b8c7f8577aab39e766e2477b
Message-Id: <156485431027.24028.1979613810090047552.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 17:45:10 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 21:05:52 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-02-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e31225f99e077d0b8c7f8577aab39e766e2477b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
