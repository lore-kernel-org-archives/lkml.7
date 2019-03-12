Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2052173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552429212;
	bh=v+PH7Fb1+xvSSScCZ3zc743/pUygXIbxZqDkGWzmtlw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jGPA0hhSQYq27xp/lRldEKTdrwglqhjpfNeJkdT08w4uttIgqUfIIynIoqYpwfpEz
	 KDJ+tq255L0xvH4ZnL1hjc+HZs+cuyjYV5wzezckRBHt0KducF7WjXOy4dWXLLxEck
	 KEA0mfWzoV+Rz8MCsUOGid7U34F2O0oD6iVnjk2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfCLWUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfCLWUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:20:07 -0400
Subject: Re: [GIT PULL] fuse update for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552429207;
        bh=v+PH7Fb1+xvSSScCZ3zc743/pUygXIbxZqDkGWzmtlw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z/v9ku+BcdheC4Chk01NdIhBOl6Yg0ZQ2LpOe+9gV9+oMrH0MkiKVrDycFwyN1GAr
         h8Oa4U+Yot8G4D5WbsdxAAPj03IRRvV1wyNgJUKn2x1q7HNA9sXGgtKJfvs74ZAeYD
         yFIo/r4U76IYFVv689a7TJ9n162Y7eiYGAih1ER4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190312084449.GA30899@veci.piliscsaba.redhat.com>
References: <20190312084449.GA30899@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190312084449.GA30899@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.1
X-PR-Tracked-Commit-Id: fabf7e0262d0bd57739d29aeac94c44b0542ff1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfee9c257b102d7c0407629eef2ed32e152de0d2
Message-Id: <155242920733.11942.12040530002004403570.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 22:20:07 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Mar 2019 09:44:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfee9c257b102d7c0407629eef2ed32e152de0d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
