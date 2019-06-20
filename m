Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20987C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90F92070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561065905;
	bh=3qNiJv1XkfvgKQu2c+bLkWSvpfxMew2fMtYIzT2Pht8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lUDBhXcfpOHpLFXqNZ3yuuBtPhOdHauIKeyjTfuL97c859nNWhaZhruA4RFYax3Jm
	 U6P6qIwJTHAbnKntAX1YQYsYgkMWvzg1ZJFdUckTLGUEsSR0CqphmP6NQx343fqVJg
	 YW7gjzR2/iy8y8wKGTt0Eo8mTv4Gf8YiidkEcJ2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFTVZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfFTVZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:25:03 -0400
Subject: Re: [GIT PULL] fuse fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561065902;
        bh=3qNiJv1XkfvgKQu2c+bLkWSvpfxMew2fMtYIzT2Pht8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XEuHamX+RNtLTRCCqC4+PKe2vGITIhAkO669U5otf5HiX22Of2di3q33qgu7c1aB4
         1yKHV+qodNXTOD3AIrL9kT5QvvcaIkFUN5fWA274ToyMUUJurZiWzn2ATRjraceqgf
         q0BsQE+ioFSxAvOdmh8a+lJa9X8RRc1Y4bzo5fwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620200737.GA10138@miu.piliscsaba.redhat.com>
References: <20190620200737.GA10138@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620200737.GA10138@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.2-rc6
X-PR-Tracked-Commit-Id: 766741fcaa1fe5da2cb1e33ae458a5630ff7f667
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b910f6a7ccab60b4d930b438a97a265bb2b33135
Message-Id: <156106590234.13749.17603790465815960149.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 21:25:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 22:07:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b910f6a7ccab60b4d930b438a97a265bb2b33135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
