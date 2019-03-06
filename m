Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F30C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402662087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897031;
	bh=7ZcCZ+ukcZhcerI+UQVA8swhe1GznJp+I3IOlcO7pGI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xvcHw6dQXNjZu8qQOu7IUipBUZXnygzqrjJ6bXV4EEEDOKm4D8X1KFEv75FfwmKYW
	 v1yWxR0S659NlzQ9hqgCA4CN94nMCHgh6vYhxQpeJuN/fCBP8QzUOG9jXT+bibNRKK
	 96jTOoWqktHXarPWuktA6x7b4Mhoxr+GV0WNmsMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCFSa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfCFSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:20 -0500
Subject: Re: [GIT PULL 5/6] ARM: New SoC family support for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897020;
        bh=7ZcCZ+ukcZhcerI+UQVA8swhe1GznJp+I3IOlcO7pGI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qH/jB7ZwA+3rBjKfp55CaNyKqMLuejWBhaOCuG6cIQ7TH1fq4UQJGJY/jnSvVe5Rp
         iYRuQOEPXla2DHuM9Rb2LEkw+I7phLQVx4a/nIl3UZhZZihWXzj+Wc+ulSzAKWRvqB
         SdLTBJaJsuPBbxGQ1w+CdnYCIHt+kKQV3ZfWEvBY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2+OspNio3=mLoYPjOg_rbYeomYa8TrRaLwU=ZF1ec20w@mail.gmail.com>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a2+OspNio3=mLoYPjOg_rbYeomYa8TrRaLwU=ZF1ec20w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2+OspNio3=mLoYPjOg_rbYeomYa8TrRaLwU=ZF1ec20w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-newsoc
X-PR-Tracked-Commit-Id: c889e2a0b053703be7e7591c9a574975440e5502
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b1b217f1a20f15dbedf47e49a25a0b5ee3d53b
Message-Id: <155189702006.14612.15319418180913168804.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:20 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:36:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-newsoc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b1b217f1a20f15dbedf47e49a25a0b5ee3d53b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
