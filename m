Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E518C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5394E215F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575252326;
	bh=S3nsDK+XoBp8V37TfojULY4swJVNWxdLgLpquTmVuZs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z0v2FK0R9iA7xF2TUPByzcfxUEY7h4xUrasNhgSfGjsHHBXRWCVcwHtbNo34dYy39
	 QOuK2Edx2yEeWwn5YVXVOaI7vC62pT4/f3IaoTzKArVuweVR4e9P1mnReHbZLIchb/
	 EWQINsbQ3Meu+L6yNBv1rpzqnylgnIZ//3lDto0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfLBCFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfLBCFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:05:22 -0500
Subject: Re: [GIT PULL] GPIO changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575252321;
        bh=S3nsDK+XoBp8V37TfojULY4swJVNWxdLgLpquTmVuZs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L73JmBo6VxUcLiiqHewa8QFFJjzdsNRg6hhV06lVeeN6izlVzSTm4CPXCMsyiMamb
         azAupBlEgXx8w/sK1pCjbHVoiNb9Uxx1On++ehr5M9R7zpQ7j3C82U7cA69LQtUT9I
         yuAlhlm0n7zmnCEGnCso8saaWQqCD1TEIIO8ybDc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbJxcfj6pK=1qjXxffFn0RUH9VD0HRFXX0RoZJDi=hfRw@mail.gmail.com>
References: <CACRpkdbJxcfj6pK=1qjXxffFn0RUH9VD0HRFXX0RoZJDi=hfRw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbJxcfj6pK=1qjXxffFn0RUH9VD0HRFXX0RoZJDi=hfRw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.5-1
X-PR-Tracked-Commit-Id: 41c4616bb81ff9b2efd981453f2c5d8f57d0c0b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99a0d9f5e87352c4bd8d01bc9b39f7091c12e4d4
Message-Id: <157525232155.26823.1061266652938925665.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:05:21 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 14:59:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99a0d9f5e87352c4bd8d01bc9b39f7091c12e4d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
