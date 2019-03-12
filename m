Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE478C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74D9213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552429218;
	bh=f+MqLhBnq+peUP6TdnZk6RT9LLVyTAAOnLm/SlE/LTk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SQ6hJKahpTed3MFIYUE0jm4ZGGwX9/keQlF5DpH4hSZcRUdcTYb7fyIGvJQAvaasB
	 NN01U58x8xf2VAWTVsONNxYBysy14dUgA0Bj5W8LwR8Bsp5IPnvhCConFxh//Lc/lJ
	 qohxlMtquCiPZFfOTD2TwixdLcMhB+bIgZM2V35E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCLWUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfCLWUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:20:08 -0400
Subject: Re: [GIT PULL] overlayfs update for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552429208;
        bh=f+MqLhBnq+peUP6TdnZk6RT9LLVyTAAOnLm/SlE/LTk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kvnytNpvyGeUPgfoGEE5/MY57S8R03hiPjWsI/ZcM+iu7o3t9hSBLGXcOIbGKNijN
         siKH+unUolC0H+8BtlhyD9SY+jzqWMMXtJHZmNHXX91oc5Hx7R0yh5wAz1Lw8DyJO2
         05EA/slXe/7lZ4kvct/rY0z6mYFwd2qPPg4tg5qw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190312090309.GB30899@veci.piliscsaba.redhat.com>
References: <20190312090309.GB30899@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190312090309.GB30899@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-update-5.1
X-PR-Tracked-Commit-Id: 993a0b2aec52754f0897b1dab4c453be8217cae5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f88c5942cfaf7d55e46d395136cccaca65b2e3bf
Message-Id: <155242920826.11942.1937243367649606944.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 22:20:08 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 10:03:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f88c5942cfaf7d55e46d395136cccaca65b2e3bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
