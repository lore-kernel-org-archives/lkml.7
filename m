Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7283FC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708621835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575759329;
	bh=6bf2vTuczZfI0NcDWQQmnkLeGscMFLhylFHjX1D4aSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RwCkCjAgKgvex42aXa0G9kWbbnVimfjw+wmqdh8OLx5p1oRlyeJy2PHSVGN0CadHJ
	 05U2pjQdr62iyPzoOiBMqhKNqvjIz+JnD/7Aq4msBbqE0oC31yIQebU/Wz2WzHbRGi
	 J0ftpKIUMx4HY65BoMCklkw76nZWS0i9z9autfUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLGWz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfLGWzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:55:25 -0500
Subject: Re: [GIT PULL] VFIO updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575759325;
        bh=6bf2vTuczZfI0NcDWQQmnkLeGscMFLhylFHjX1D4aSM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L0WZEWgxYQvbMQZlVN/YSz1Cbc2WuDot4YNSafiU8tJByGj96XupOIf6KpCATVO2y
         sCCu9zKsA7nbo8I/Xh8BlNvOEVDRp3IPTTcm755KuKkdH8IcgwPFnx/w2is1rsa3fD
         qaNcp05BQQOvTJy+GmogzmA7tNu8vJ8mXutmr2xY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206112227.53e15607@x1.home>
References: <20191206112227.53e15607@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206112227.53e15607@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.5-rc1
X-PR-Tracked-Commit-Id: 9917b54aded12dff9beb9e709981617b788e44b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94e89b40235476a83a53a47b9ffb0cb91a4c335e
Message-Id: <157575932528.19906.8235171981287173268.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Dec 2019 22:55:25 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 11:22:27 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94e89b40235476a83a53a47b9ffb0cb91a4c335e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
