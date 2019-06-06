Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00FCC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637021019
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559850303;
	bh=y/QfMedO5+Vt8cfQg7aN+0lUwbKtcAGIkrNDqQFxD9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dMuOKIU028tswRcXyTTsu8HG/CWWpE/XYPUTitnoGj3evIEAxQFOyodmG8ZdBjVcb
	 NuWz4/wxLPjUitbE/JFTpa1rd6r+VAqAOcvmN1NxYGZyy/WGGDknPGy/DT8gz1BFXS
	 AeYxWA2oViFrEnnfiZZqJFTcTmlypOSn3gbG5Pvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFFTpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfFFTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:02 -0400
Subject: Re: [GIT PULL] fuse fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559850301;
        bh=y/QfMedO5+Vt8cfQg7aN+0lUwbKtcAGIkrNDqQFxD9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bfwX2/kiURDe2rWoEmzHqPpoZKmDQswNoA5WgZKrkX9kQHcUd92r1Pkyv44FYOwy9
         jXQWxsk4TvS0UCg5V4hLTjPsCi7aL9CS25qqeJQqnsqiPq79vgLCcF8e9XnKvhhUos
         5rDSmd9QzA8Z4lZ9DmAxsESpoQHJnTjgS8yh1l2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606133650.GA26408@miu.piliscsaba.redhat.com>
References: <20190606133650.GA26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606133650.GA26408@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.2-rc4
X-PR-Tracked-Commit-Id: 26eb3bae5003585806124c880bba5bef82c80a23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 211758573b01f4cd27308464573d112ef85e0e1a
Message-Id: <155985030173.29170.3848019054505183741.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 19:45:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 15:36:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/211758573b01f4cd27308464573d112ef85e0e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
