Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65448CA9EC8
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3445E21D80
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571355907;
	bh=DsIeZVKxk6uBBwAlO9Bg1hDtoXfMM4WPeWWBIZ2WdnA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BO6n6qKsseE9VX08mVhdOaYxOmdCCERxIO7/1ISvx7a+1RsSv7asv8JB1FfeBa2nn
	 4krEzcTXwEuAtiyB45qfrf7NSqcvjQ6by/NvQ0zbg/fNzFtxK2ov/o1GoP9iQXVrWT
	 JXtFGIN8PmJB3D4+3g1HChnrV9tr6tA1YIZL8DI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441810AbfJQXpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732678AbfJQXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:45:05 -0400
Subject: Re: [PULL 0/6] xtensa fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571355905;
        bh=DsIeZVKxk6uBBwAlO9Bg1hDtoXfMM4WPeWWBIZ2WdnA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ECDaNZn1QEfEW+8LyLo0ypZg8m0+ilGbGxwki1ShkGVGfS3YIFiVVFOxkFKdzr+3D
         r+q1NifzOPc6iQNwA1mQA4hutuHtw0uv6hKI67X0Vg2Xo7Ww8VMj5ODhoeGFb5PctR
         GrZ6pMz1fgA0aHJDk75IiyB1C8dAFc993y9adLts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017224910.18457-1-jcmvbkbc@gmail.com>
References: <20191017224910.18457-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017224910.18457-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20191017
X-PR-Tracked-Commit-Id: 775fd6bfefc66a8c33e91dd9687ed530643b954d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad32fd7426e192cdf5368eda23a6482ff83c2022
Message-Id: <157135590509.25652.1426724248164384090.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 23:45:05 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Oct 2019 15:49:10 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20191017

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad32fd7426e192cdf5368eda23a6482ff83c2022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
