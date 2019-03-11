Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE0720883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552330823;
	bh=/VmNKUcgR00byxU/M6zoMaHpGCu/JM2qqIRWBQjp9g0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ip71IAyO4o4U+mFhKAiXEenaCovMVrhBPADa0Uk5UEObcspP7dz06NzUyehZ7azqe
	 1eUOifCMRr3/DmfJ+jMoMew2FVu88xSCDeZaehK9bihYwIN/4fGM21TK499np4riKm
	 7tgLNHlrr+pH5P/mqwNq2LdBVzA0dwFoFznv+Bis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfCKTAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbfCKTAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:00:18 -0400
Subject: Re: [git pull] Input updates for v5.1-rc0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552330818;
        bh=/VmNKUcgR00byxU/M6zoMaHpGCu/JM2qqIRWBQjp9g0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RihwdB5JBg+U4UCGai1v3WVMQos7SRXzEDUyFEiOGJYSLuBi6sYQP4tBZyOhl8xB+
         OATNsA7vLnsqUtUyE4YDMitqPxUC5Wexfj5204IHYcMCqoF0g0qxtzqN3jS6q6sYDn
         Q8zvKorhY1Ik3X9FQaP5aZhfWwaMliR/3S/X0OBE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190310023427.GA68528@dtor-ws>
References: <20190310023427.GA68528@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190310023427.GA68528@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 44fc95e218a09d7966a9d448941fdb003f6bb69f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f0237062ca70c8e34e16e518aee4b84c30d1832
Message-Id: <155233081803.15239.9340470308444935828.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 19:00:18 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Mar 2019 18:34:27 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f0237062ca70c8e34e16e518aee4b84c30d1832

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
