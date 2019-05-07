Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12827C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E692054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249610;
	bh=t9O2eKSF+zDivq1waaSuJAKn2KvU3HkDABeNSg8XkJk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b/wPCTFZiydhJmgEDEx0mNpZA/Jklbwa9B5Edcd3nAGY1eVjo/MAixZJGDasXLziC
	 oJ84/oq8sIVKLtWaHCav3a1p9eBkXdDggOSUfQIxjlDmzPP+myc4FTUhVQ3cVQ+vED
	 4Oh/ChotBITJ7Jw2lbMG00498nUaXEhVxZM6BRrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfEGRUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfEGRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:08 -0400
Subject: Re: [GIT PULL] livepatching for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249607;
        bh=t9O2eKSF+zDivq1waaSuJAKn2KvU3HkDABeNSg8XkJk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a0eEB/H8jCyUqfxQKWGbvDScpD4de46m5hTN7c6u26RQ+ZJ6VHTirMWyS4qR0PZzc
         uim1j48DUNvZCxF+iFIzHNCPxY0NMFGWwQQ/T6CJhFCbwj9+DUb2iQHqZKmmWeoGwC
         +VnJP28Pqbrv50NLhtY34RSOgnDK8XvPx9TyzlQA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1905061556400.17054@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905061556400.17054@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1905061556400.17054@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git
 for-linus
X-PR-Tracked-Commit-Id: 1efbd99ed41db9ddc3ae7e189934c62e9dbe55c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 573de2a6e844cb230c4483833f29b8344a6a17cc
Message-Id: <155724960792.23705.9549107939395279414.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 16:04:19 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/573de2a6e844cb230c4483833f29b8344a6a17cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
