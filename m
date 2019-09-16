Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A1C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CC7206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669738;
	bh=FFz31tN2l8fuIWdXRwkSrzrtg+JQ3Z0matItIKoizGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=R0Ezz2fjjZcXpDXKaH3d2zNk8nMEgHTkEqTYX52fCJk4G0g2gLbIvEBNSKUFNnJxQ
	 CyVheBYoIbsP8Wl+O3EJ0VyzjEnNd68uUDJFBSVxu+vNPWD9MV7rDfQOFkjgWHoK5w
	 UMl+XM4tNX0boCuj5QMFGdKcNurxJ+93BrbgAstI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfIPVfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389301AbfIPVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:12 -0400
Subject: Re: [GIT PULL] GPIO bulk changes for the v5.4 kernel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669712;
        bh=FFz31tN2l8fuIWdXRwkSrzrtg+JQ3Z0matItIKoizGc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BtrjfbAuwsfmx5u971u5jEJ/BeemQs69kdzwIebRKFwiGg9n9Qus3eg06NDmHpZiD
         EzRRc1tNl5JNlEAJ0LGIJM1BV9PQzIVCzFXaLJa6NE4cCwI0YtD6ZmKWgPWDlCdhPh
         Lwst5Xk00dhXCmZQI6fBOCDYgczOvphVUeOULJYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZX_uUGaHD9+abAG1w-OVyp0ihvEosjvcBe8gbvf4FCcw@mail.gmail.com>
References: <CACRpkdZX_uUGaHD9+abAG1w-OVyp0ihvEosjvcBe8gbvf4FCcw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZX_uUGaHD9+abAG1w-OVyp0ihvEosjvcBe8gbvf4FCcw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.4-1
X-PR-Tracked-Commit-Id: 11c43bb022b373d2fdb84950ebf1911362f3f010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbfe0d6b8b730af4954a0e0e741217eb3e1c58bc
Message-Id: <156866971219.13102.6417571350429369522.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:12 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 05:58:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbfe0d6b8b730af4954a0e0e741217eb3e1c58bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
