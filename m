Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E243C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ECC206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557199513;
	bh=uM3lfyPLmhjp5BcCgs2DlhZ9Zy4Arr+2APa1wnqxNsk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k+cVUjgVLfUNvsp6sBBecL6f1dC57mI0taVVkgUobFZAZxLXMwxvgLGi5YT7NrTEA
	 SWIkFm+rpFIlM24SecmfYqNgEAbdWo7heTHZiOBVJ8kG3JQqJTYznxQ1uEfvKfdRNS
	 kTytk0mrxQ+MDXZECA/7J1RvbytVtj1CBOPeafbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfEGDZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfEGDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:25:05 -0400
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557199504;
        bh=uM3lfyPLmhjp5BcCgs2DlhZ9Zy4Arr+2APa1wnqxNsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JOlWx/76OhvBtLeHXZyn/rJW0ICGXPBrWULh7KFzoViK6qhcwOLK0/qwwgG+DzdKo
         dYFd16qOW/IzHmWp/3W0UgiKFQK/cTRssZ1egFBP6mt70aws7UtEmj01EXTnSBbbdE
         bp0CdjFKM0v+7/50SRTD3QofJuSPiINd9F06UNqI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
References: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1557148847-18835-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.2
X-PR-Tracked-Commit-Id: 39abe9d88b30a51029b0b29a708a4f4459034565
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7aefd944f038c7469571adb37769cb6f3924ecfa
Message-Id: <155719950467.20841.12333253076877928869.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 03:25:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 May 2019 06:20:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7aefd944f038c7469571adb37769cb6f3924ecfa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
