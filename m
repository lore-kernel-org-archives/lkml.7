Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682AB2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552497032;
	bh=agxqL9yukEQxHjmkls4aS1fmBiElTBUyjSN+GZey+mQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HJ7neDKeJ+dJUtPY7X71vkPZ/4IB1brcnXXtnMVuQY9d2c3iZHBqUFVqAEHHJ9yv1
	 0dWR6Q6vOYbd+2t4XwQ1ds2jMuzXRktYcy7K/FVgaz7co2JPtAds0g8Zx8rcedfXAb
	 Ot5REmlTubGRyQeXddyPXY2/GhC8PFl3E1Ld55Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfCMRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfCMRKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:10:17 -0400
Subject: Re: [GIT PULL] Kconfig updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552497017;
        bh=agxqL9yukEQxHjmkls4aS1fmBiElTBUyjSN+GZey+mQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kckalO8fymqv9uJoFmt8fat6NqmmvLviEU9sh+1NsxdcI6M8Y5iskZNUw5LcE7yki
         NqjqUZsRscDFuV+CB+yUk93CmDTFgB4PRJyFlD9kIDlyjlSk1HIlhMETjpEj3m6ISn
         uDfq4eenBXgAuOHJ69zzfbdbJz6LaLnF6MUZKK2w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASa-XsGj9ESee+RF4SMQxpxD49oKz9C86etYQV2gQPxDQ@mail.gmail.com>
References: <CAK7LNASa-XsGj9ESee+RF4SMQxpxD49oKz9C86etYQV2gQPxDQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASa-XsGj9ESee+RF4SMQxpxD49oKz9C86etYQV2gQPxDQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kconfig-v5.1
X-PR-Tracked-Commit-Id: 8741908b3e29d35a33eeab6de60175958db8e54b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
Message-Id: <155249701696.28396.14196911305158619040.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Mar 2019 17:10:16 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 13 Mar 2019 01:39:04 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kconfig-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
