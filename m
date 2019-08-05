Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FEAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4CD20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565031618;
	bh=wpUOLqaS16oABeMn/4FQyGK2+p3IV+uJrL/F9YARAzU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AJ/RQwvee/xf2noNDB4us++DumUFnClFggpnHEoyigIi2Fccmgf16uDGUt3AQQkvx
	 hXjfrnWecW8RYi7tfrzHTvo71FLIZ6sMLrcgSZbF2UKpafufqMc/N8i7pi2nyiUvJJ
	 lX8sJlFd6fRBYboPv71bIGcqxuS8bAheW+6lG+Fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfHETAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbfHETAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:00:14 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565031613;
        bh=wpUOLqaS16oABeMn/4FQyGK2+p3IV+uJrL/F9YARAzU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YpjBCjoO/IpaLi+nIyD56NXx4uOTBvfs+4/q+WdCHpeJKBgNPFLWGFG63jWjO2SCF
         yVnbUY/bYhO7hxje2Q7IKFrGOjpN/e3KRXpKH0NqZYrX/Fn6dIGg0BRgIsZZMado0C
         mwxNbrv8og47Muwbg++41r1XpbVOodfBsU99Qfyk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <288074f1-9d9c-0795-9ec9-e0d78a5715a4@linuxfoundation.org>
References: <288074f1-9d9c-0795-9ec9-e0d78a5715a4@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <288074f1-9d9c-0795-9ec9-e0d78a5715a4@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.3-rc4
X-PR-Tracked-Commit-Id: fbb01c52471c8fb4ec2422c0ab26c134bd90bbff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e9671cea72e0652a8a0d03b7c96a8a798470c43
Message-Id: <156503161320.31890.6531089298812473644.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Aug 2019 19:00:13 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com, Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 09:56:41 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e9671cea72e0652a8a0d03b7c96a8a798470c43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
