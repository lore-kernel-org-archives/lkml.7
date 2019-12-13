Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC14C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919FD2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278623;
	bh=tLCLckygGkEJaSdG6BnREjScWOLvqw9T3znz+YP5cJU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bJE8ONjsebQtZkIridGegOwzwYDGbvz7V2Rp079eMnRZCoODbH07FUaTttRpCJdxU
	 cPCi21maavoM0Tff/82gpf+27lnQt3JFqnG0TCfdZOKX4bwPqObshwQP/YaNIR/hVP
	 dOvOWAkOz/7szHeQB7AHwZ6KQnqxAENHMjq/YRJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLMXKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfLMXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:14 -0500
Subject: Re: [PULL REQUEST] i2c for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278614;
        bh=tLCLckygGkEJaSdG6BnREjScWOLvqw9T3znz+YP5cJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sqv/m2OOY+6yMduW/87DXOC7am0IzC3MBdwzQAkpQx+TC8X1XiMpEVThXdKThp1hT
         ArDtfty/5WGEXOhESQiQOxvRD7peQosYvvk/p8vlIeIlYPCXCbJ/ydMfAtsZHvYkWA
         0LsM2VPu2iGE9BHucANWVlTfUKsYW10daIQIewIk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191213153136.GA3396@kunai>
References: <20191213153136.GA3396@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191213153136.GA3396@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
X-PR-Tracked-Commit-Id: 8c9312a925ad859daefd0f443ef3b6dc7157d881
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b2ee614cb4accb75080f00586bd762b0eab219c
Message-Id: <157627861440.1837.5378976398857101367.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:14 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 16:31:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b2ee614cb4accb75080f00586bd762b0eab219c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
