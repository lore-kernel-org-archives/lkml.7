Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB3B2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971818;
	bh=iB9UQfQVkqkl1gjbMB0KXya2AzrT/Grwr26CuT24vak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sMXnYiecz2sflK06DelVPcBLCcHGu7iVPx7InpOkz0Dj7rH750sNsdK7Xfum3drxq
	 erSMw9Xc/fTuFun1KGp4XPC0d9W0oDwcYqz+2oDzHwki/yE6gYZgyRs3LIHAtfTMNl
	 6cGwY19lN+9YOoJV275UeUWHB4KVzXhmUDsmafwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfC3SuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbfC3SuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:50:12 -0400
Subject: Re: [GIT PULL] GPIO fixes for the v5.1 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971811;
        bh=iB9UQfQVkqkl1gjbMB0KXya2AzrT/Grwr26CuT24vak=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vSRExNMh4/vQ7ieFxVz9iYaX1Le1+7O3EWeQ9tXpYDwTbMLTg+mEc11tdZ/WhTyfk
         1/SbZivTcdZ7D4P1QOkQsYQ1WPVXrrLc7qQbcrP3mXHVaswAC4dmcfkckL0C7Hd7NL
         E+7YFGdZBHK+FwKWPFCfLwQPPW/lLzSo80TOrchs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY2yafXiqn8TDjTNQKUQn=d3xE5y9zUHuXp1ve25C0wcw@mail.gmail.com>
References: <CACRpkdY2yafXiqn8TDjTNQKUQn=d3xE5y9zUHuXp1ve25C0wcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY2yafXiqn8TDjTNQKUQn=d3xE5y9zUHuXp1ve25C0wcw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.1-2
X-PR-Tracked-Commit-Id: 86d0756558b701b2c5502d90f705c2936008922d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3af9a5256f448e3d0405f7905c430ef2f9f32b9c
Message-Id: <155397181167.25047.10845966095171350835.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 18:50:11 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 16:04:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3af9a5256f448e3d0405f7905c430ef2f9f32b9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
