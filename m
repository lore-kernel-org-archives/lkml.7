Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123A0217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557440118;
	bh=qgyq7+yLpLnKg1MIv7N9dI3jFfUpFYJPDgorlRE2EYs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=08KM5HiNCc6T6hWMMQRK8P4noB2BZHSyJ2zLNIuCEKKAAPek7PjRBI9C0wz5cbV2t
	 9tmtZWXmx0f8aeuK/vCln0Ujp13ep4YJ72+zp3SrND2svZ82lQDIMcONTzYglMZNUX
	 qmEEg98+DrbCFAmBke2IGNHQkbxaiuW4YN16mRBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEIWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfEIWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:15 -0400
Subject: Re: [PULL REQUEST] i2c for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440115;
        bh=qgyq7+yLpLnKg1MIv7N9dI3jFfUpFYJPDgorlRE2EYs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RokjB1+Ntin/7xx2vnGBtx6GTUFwN91fbDGbAlOVgMsZhejdZjFy0smhOuKZQ6So4
         7fxAO+bI/hS0mp9GkCNZ6rJg0JPiRH5YZutsMzvqNQxnYYct/Fk2Q+1+VoNzLW7jEW
         1LJLO/UxhjRRy5l8Z/pE/9DSRnEjY3xVMMQ0Of30=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509191132.GA9306@kunai>
References: <20190509191132.GA9306@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509191132.GA9306@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.2
X-PR-Tracked-Commit-Id: e6ae3ca27477226eae77cc00d5fad89d7ce64aea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45182e4e1f8ac04708ca7508c51d9103f07d81ab
Message-Id: <155744011521.23477.7035277562607237397.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:15 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 21:11:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45182e4e1f8ac04708ca7508c51d9103f07d81ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
