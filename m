Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB64C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306F3205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562647510;
	bh=Z/DALeXxP48tPOTPRGt1LvGQJsykPrbwtQw663U8XCU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rjrYcdvqYeBlSG9EZyNraZsrgvlAmtUH4bN4S91/YT2OPB4NIPcehAYvCklpadqUo
	 R+EAzPjAT6xkSKzccFKiJxoK2fU6bglah0tAxQUz2ETeybaCtagYXfbSH4Z2uc3BAW
	 /ZiQPf/9KwoKRCRGTNtX1tRpbezJuqst0l6YIFWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGIEpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfGIEpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:45:07 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562647506;
        bh=Z/DALeXxP48tPOTPRGt1LvGQJsykPrbwtQw663U8XCU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pWxIkp4Z0kO/uy3W0l60X8KdO9B6k8PllBSnWb5tkCa91GLgtqjyYuZXBWHnMqa+d
         c+sa8xqUgYl3PlIrDUYHgObv3ZFXhf5o3ElOBazH/AFuEHluAcJHxlhW6cR60z7kk9
         LEXmARyxNeoZh13a7F2VEWm4seQjZDCU7IrVyiq4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708171005.GG657710@devbig004.ftw2.facebook.com>
References: <20190708171005.GG657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708171005.GG657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3
X-PR-Tracked-Commit-Id: 99c8b231ae6c6ca4ca2fd1c0b3701071f589661f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92c1d6522135050cb377a18cc6e30d08dfb87efb
Message-Id: <156264750642.18377.15747597949297379139.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 04:45:06 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 10:10:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92c1d6522135050cb377a18cc6e30d08dfb87efb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
