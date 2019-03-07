Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D881C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0F20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551983427;
	bh=Aif1jqknumjJDNRnywSknEvG46tVSWACebG6e9M5xqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1HnMPVmjfVlhKbXdvXPq1Xo35Bfv6bbrkVVIWKunxu9WHRzHNd5GfZz7cUglu68e1
	 t9eCrudTY1Vg/gP4aKMvgUKdzrb9RlnZnIVuZXXiVzE0JsJE0VH09e7xGJNUukCdCH
	 YKOCEdn/oZtavPnlW75G3AgBIxm6lQM+Bj7/2g8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCGSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfCGSaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:30:17 -0500
Subject: Re: [GIT PULL] cgroup changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551983416;
        bh=Aif1jqknumjJDNRnywSknEvG46tVSWACebG6e9M5xqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2XrLp3g/He/zpHLg8cpE8v5gz4NxWrkuOceuuB/T2oZunnAfd4xWQ8WP2/8M83OS6
         VmFWoIPJJUBTySBO5QnUFOTY0NavFD0uFDbGiIUqxXmfomwFp5szPaq1lIkC/e4hqd
         sdCG1RE4eOZZEl030niloduL3IkaYvdM0ssJ6UiU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306184153.GI50184@devbig004.ftw2.facebook.com>
References: <20190306184153.GI50184@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306184153.GI50184@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1
X-PR-Tracked-Commit-Id: 6a613d24effcb875271b8a1c510172e2d6eaaee8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fc1cd8399ab5541a488a7e47b2f21537dd76c2d
Message-Id: <155198341667.27511.2935577221998437239.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 18:30:16 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 10:41:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fc1cd8399ab5541a488a7e47b2f21537dd76c2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
