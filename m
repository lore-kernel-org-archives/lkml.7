Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1D5C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7299F2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561065913;
	bh=QXyLgU2l9S2/CeiNwVEEoz2OHGwgWwOKtzfYCEpd3dA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DUORah/cqjnbjGxYe3bJ0qMWb+huh7jTF72Qzwe/XkxF5JG4ZGoNJYkpycVKif5Ye
	 QXZBn0h/Wv44/lfn8skzKnwj2AFD2Vc20XtjC5uc0sTQMOmibasUL2EsSoZpxzoLm3
	 WQB5jByVdugVdFPyk8OJfL5ZE6lSK1gpT0kZ8r2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFTVZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfFTVZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:25:03 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561065902;
        bh=QXyLgU2l9S2/CeiNwVEEoz2OHGwgWwOKtzfYCEpd3dA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mttEXmuHOTEP/T544VDJRl5g+lzmUKP74NDgEEjvAg+IU0DrM7uhSCcowsnw//BsW
         6j51LbWOt2HNP32iUrSph1SmhNYu64uTwDCZXWCPjxcMmaYLyUAQJ3OsLbXKCzWe7c
         k27agkLdBveSPeeSmJhZRcN2OVZ8P5ZtWrwLEagw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190620201218.GB10138@miu.piliscsaba.redhat.com>
References: <20190620201218.GB10138@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190620201218.GB10138@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.2-rc6
X-PR-Tracked-Commit-Id: 6dde1e42f497b2d4e22466f23019016775607947
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ae004a9bca8bef118c2b4e76ee31c7df4514f18
Message-Id: <156106590277.13749.11184384328640933661.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 21:25:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 22:12:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ae004a9bca8bef118c2b4e76ee31c7df4514f18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
