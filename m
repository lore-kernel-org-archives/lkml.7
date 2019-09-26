Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBDC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E15F2245B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569528631;
	bh=GxuslHfvxFdjhz2cTHYqO4CeA7yLXhFcFIpmQfPxwsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m61kMRpF9Q3mirV+3w5x8KPuZq7ZubFn/+SMoT5Kb6TEJb0Scwa0ByKZSHhobRHkG
	 zOZRuUY1dVaeASlqD7vfFDgnRQnJqKFgANMjj+yE1MOkih1WuXnb0lt1NW3la9yxAr
	 51YAJaqXGz7hJ5lazkCFUwd8JBu8xjc8aoheLPtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfIZUKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbfIZUK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:29 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.4 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528628;
        bh=GxuslHfvxFdjhz2cTHYqO4CeA7yLXhFcFIpmQfPxwsc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oLhRGp5FWMQO75JWJ9I8wCPd6NRaRsygJnwdsIkiSmJX8THz7CHd3vnxYPouE7E7A
         qIJEoFmEEoXiONo7+rds0Ka+ucfD8y6hN+ZX4kvgLHgTPHOouIWvSWubG/00B9R4MS
         gB1rmVTWdkZ4NU+6r8iIVBdSZ+txVjaiQYZ8F2CI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01569509914-ext-6285@work.hours>
References: <your-ad-here.call-01569509914-ext-6285@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01569509914-ext-6285@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-2
X-PR-Tracked-Commit-Id: ab5758848039de9a4b249d46e4ab591197eebaf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16cdf08467848dc53acd2175d563b30a3cd486aa
Message-Id: <156952862882.24871.1722490874248388394.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:28 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 16:58:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16cdf08467848dc53acd2175d563b30a3cd486aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
