Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28062217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554779722;
	bh=Qv0HYtx/qG9AtzVi8qxXzJb63FbUj1JU3qIM2V6ohz8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UdKEGH/hfUO/saIDhb46KUz2avxNTjgJG0IfxdCHSdA1rP9ZgAlkyCS7Gdr046ITt
	 AbJvUNsyuDqWZTnC1hgn5CP572Sf3IzmYYRroxYcmrBXngCODy/1Wg2udC+IEw9tI/
	 qJqjsYyGKLr3h1jWLefpZl6FlWzFGgkAl9esYwe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDIDPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfDIDPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:15:07 -0400
Subject: Re: [PULL 0/4] xtensa fixes for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554779707;
        bh=Qv0HYtx/qG9AtzVi8qxXzJb63FbUj1JU3qIM2V6ohz8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YOH/dBouVaMZwVetymC/+nmFVq41bDkP3Ty2dVzWAeiHTS9coCONpzbIQztzNa62S
         /6KY439dbNOk4eGMXb0tOteHpA42YgcyWjtgsZGy3on/q4bHtfuaCbu081Xuh/yDIM
         moIPgJrtqpNoOgxqB3O0ghuU+77kAc40bl++gusA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190408180146.20202-1-jcmvbkbc@gmail.com>
References: <20190408180146.20202-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190408180146.20202-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190408
X-PR-Tracked-Commit-Id: ecae26fae15abb7d433557afbd15467ce1c444f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10d433979f2eb78fa6ef042bf0d7e1c1f3199d4c
Message-Id: <155477970729.3610.14345566594054241971.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Apr 2019 03:15:07 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Apr 2019 11:01:46 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190408

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10d433979f2eb78fa6ef042bf0d7e1c1f3199d4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
