Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F48C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E84A20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564667117;
	bh=zXf0IQ6jTAs0NgXbmvvcUnFGibfFGxX4Rqlt4aUNwWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kj7OsKzOUSzdC7AM99c9rCfTakjhHrNYPm1fp+1Vt+ncluusbph7BJGq6XfsA0T61
	 yxpeDWL08iY44ULhn5UbTzjYpFOQ57uGFhhHNv5r7d+q18HMRQL0uv+IMkhOrbhEqp
	 VoFmfIF+HVdgNQVxSb8aHeJ2Z6TR81+WlMhJt290=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfHANpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfHANpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:45:15 -0400
Subject: Re: [GIT PULL] GPIO fixes for the v5.3 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564667114;
        bh=zXf0IQ6jTAs0NgXbmvvcUnFGibfFGxX4Rqlt4aUNwWk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JfGuux3FWxlxnVYeHdLosQghP+UQ4NP0Ll7Sjw+EX29iz2b9DOwSON6Qq+O6EiFbD
         G5bjqlQjiDLJ2YKlPxckq9TUG+qq9/jFHFIZ5iNFT/MayYpJ4/MnFeg7tLrH8ZzXsA
         CoGD3t66Qi/NEgWeVYUuyiJqtW2P8/19JHK09vhE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYN=GzAa6E+krY3+kMq2NgM=U26FQe1SJzGbbsnOO6V9g@mail.gmail.com>
References: <CACRpkdYN=GzAa6E+krY3+kMq2NgM=U26FQe1SJzGbbsnOO6V9g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYN=GzAa6E+krY3+kMq2NgM=U26FQe1SJzGbbsnOO6V9g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.3-3
X-PR-Tracked-Commit-Id: d95da993383c78f7efd25957ba3af23af4b1c613
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28f5ab1e12ba702389c41bc95d02733673020d85
Message-Id: <156466711445.11650.12401800713923742253.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Aug 2019 13:45:14 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 1 Aug 2019 10:53:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28f5ab1e12ba702389c41bc95d02733673020d85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
