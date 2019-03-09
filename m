Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A634C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD60C206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161354;
	bh=REwdyhStsnhb7Dk+2RAqtGWCHwNCHNoV+OluRsx0j5Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yzdODip4iMg4B1TvbZKF3sC8wHNAKxHminUOc42H6IjUcRRyR+lguYcXjqZqd1MmN
	 Ko+XL/ZHqI7chKnanSaWzO+S/gnsMQxhiXQ2uwG2NQMGfG7XyYBmJpeQiwNu0vNw89
	 hoqnLD+4Xhf8VIqOUi13B2XmTSTl5WB30PRIzDrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfCITzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfCITzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:16 -0500
Subject: Re: [GIT PULL] gcc-plugin updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161316;
        bh=REwdyhStsnhb7Dk+2RAqtGWCHwNCHNoV+OluRsx0j5Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JKnC1olF+oEaMdA8/cz5dUywjm6ttIOy/qJBPpNM+zaocL2Kuoj7vmZBPMi+K+w2K
         qMMMKzEZKmCgn1W/dqqkTJlmCQchYL9ONVfta7YuZ2Tuv++jvWi0fW1agJrx16zWK4
         5VdwFYdkUDBlv5y7yOSQb7A4QmnSSP/3rINdQB2c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304174802.GA6629@beast>
References: <20190304174802.GA6629@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304174802.GA6629@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.1-rc1
X-PR-Tracked-Commit-Id: 50ceaa95ea09703722b30b4afa617c972071cd7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bb995405fe52dd893db57456556e8dc4fce35a7
Message-Id: <155216131608.23333.5184982489538207913.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:16 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 09:48:02 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bb995405fe52dd893db57456556e8dc4fce35a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
