Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25776C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA421852
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563394819;
	bh=BEWyci8A8tQmu/I4jxlViQ1eQapOF/flkyv7YtxqXBs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C/8xcUsQlNwK/sk4C+5OROsvcUXV7Fz8S6wN+y3uAVrWy0FJPj1+Rt6Cy9yWRT/ta
	 6lF90aKHgxFvKRghkXRiW0d7/YuLsOfxGrOnCYuJDmPoNmjZc/PR9KOkhEogdcSOEe
	 qdAGn2lyM0ah4CS3kXF9kF3wpoPkYT4CuZSvt0XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfGQUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:20:17 -0400
Subject: Re: [GIT PULL] GPIO fixes for v5.3 take one
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563394816;
        bh=BEWyci8A8tQmu/I4jxlViQ1eQapOF/flkyv7YtxqXBs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EvLMOiaVdfVEjKuBjM5Q7wFPZnRYzdj6ZwmxjoNA46O3yGHhaIp+0eux+bwL7VMYY
         TmPQJExp+6X2Vn8P/ExpAgwW0MwnypXIUNuDc23I3nCZd6yGWAwfTpHWAjvauMLhxp
         3A+bYhR/a5unzDvpeD69Yz4FHF65zaY2D38mrHOo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYOahn84UxZ_-YAQsP+4W+HQCAL7xEJieEDd53xLgaWfw@mail.gmail.com>
References: <CACRpkdYOahn84UxZ_-YAQsP+4W+HQCAL7xEJieEDd53xLgaWfw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYOahn84UxZ_-YAQsP+4W+HQCAL7xEJieEDd53xLgaWfw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.3-2
X-PR-Tracked-Commit-Id: 88785b7fa74ae2dc52f879140b976984b5374c79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3c08f939abe3a1c95338a246c550aca0989dade
Message-Id: <156339481669.4204.12301947987992186263.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 20:20:16 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 17:24:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3c08f939abe3a1c95338a246c550aca0989dade

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
