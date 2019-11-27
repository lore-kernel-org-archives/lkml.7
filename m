Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8DAC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C9F20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574828405;
	bh=JbpLvWr2zalrUMRqECJMjFamiKk0xNgWpaAcQ++LfhQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pJljxYCdVd8xEu7Xnfpzo3P1TMdM8tZL2fdwdXgONWZy/Q90uFRJ2p+vEnOrM9xCU
	 Xlwn3DmEr2owJzh8KT8mK6LrTtZDXzMuiG7s1Now1oHLvodjDFXt8gUJmeyuOqNaPm
	 Mp4s7rj9BeOfk6RltsBHK63fyuOMDfvUJcKIJtjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfK0EUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfK0EUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:20:03 -0500
Subject: Re: [GIT PULL for v5.5-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574828403;
        bh=JbpLvWr2zalrUMRqECJMjFamiKk0xNgWpaAcQ++LfhQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nscF11m3rqYIYGCnaIemLMMGZPSH1yFYsNd7Vi5TfZJa1Vgf6bpT3v4PknEOq9P8a
         tLxYjd4BfAVjbcxEd3YoYu/ITn87xCotkAixU6cC9WvU4aPmVy0P04lw9Mi/cKJ0Dr
         xo04kOuScX/ZZsCAQa64LPnvcHtjlhtzIRphu3Bk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126150635.18ef45a9@kernel.org>
References: <20191126150635.18ef45a9@kernel.org>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126150635.18ef45a9@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.5-1
X-PR-Tracked-Commit-Id: dca6b3733a4a46e63603496f544ece8ace541fde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ca40f41d795fd91811e44506bb73d0b9ca33bdd
Message-Id: <157482840295.9403.3779895007847889747.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 04:20:02 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 15:06:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ca40f41d795fd91811e44506bb73d0b9ca33bdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
