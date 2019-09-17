Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10727C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A0B21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763628;
	bh=hFYP8EJtwe16c36k4u99PYlRVzD6x74QSGwfs+1Ll/k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n/AsOAX8vh8sxYz+6gjFmevW4+i+yL/ANzT8TqRqGXT3TL1WnT1yLaqhHV64zgATU
	 TjxF3hV6RF1pAlfe8dTuJRtWOJYJLRW8a/Fw127Q0JsI5DNE0CQlhvtBpVwCh3B41w
	 6CGklx65QEDN/TkarRppJtBpzYJ1nN0TZxhp443s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfIQXk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfIQXkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:20 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763620;
        bh=hFYP8EJtwe16c36k4u99PYlRVzD6x74QSGwfs+1Ll/k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P7A6hV5iVakTVoixHqpwwiKWGaPdiJ42FsLsT2DEigj307LSi6d7vM41pVu07RTQN
         RvCjRQZX/3kHzI1hI2aYMKIidW0bZWEDbblySXs3z9LhrH1F6Wmz4YGeimngZpu5St
         H3UGdmPg6KFjnr9IOQRrwOOG3lf2g7JzBBNBCpMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916152947.GE3084169@devbig004.ftw2.facebook.com>
References: <20190916152947.GE3084169@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916152947.GE3084169@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4
X-PR-Tracked-Commit-Id: 653a23ca7e1e1ae907654e91d028bc6dfc7fce0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ee8d6c592dc7fb240574b84e9f9a7f9db4d4b42
Message-Id: <156876362013.26432.7518495199009027982.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:20 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 08:29:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ee8d6c592dc7fb240574b84e9f9a7f9db4d4b42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
