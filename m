Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A40920838
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577475915;
	bh=6MmZxWVukgo7MwepA6+knamZU47yNkG6FY80v5p8oDU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GkBuapXJ/wHeBdFof63ssK6cSPvLmej1GCu5hDOX6gPkTt7E9oDjiYgIyBxvLxYzU
	 c+Pqi5R5EFt1nZs+Xea19UQpd7UmH45nClV04mFL2MafpjS1+tyRDkFNP1uw/s8cgg
	 mzaN4JHwJ9zxEyb/ZKmEfYczVyGH6cAXVZzSe7oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfL0TpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 14:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfL0TpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:08 -0500
Subject: Re: [GIT PULL] gpio fixes for the v5.5 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475908;
        bh=6MmZxWVukgo7MwepA6+knamZU47yNkG6FY80v5p8oDU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kEINk1T9afrOHs+mXfcRyvdZfl9k6SFW+uu2nORuBpcUyFJh21W+8r3KN/n9Gfo4p
         syMhKpu6o1/yBn0/I0x1hfrRpjsAujCbfcVYmIWFlbZ79X79xtfqFr2NebIrT3kH6D
         oeRz/z2RJoFjXSqWYjvM9Ho1ydoAZIMW60k5Be+I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZucwZNrUo3=WPM-utorFaqOn4AyhxMnX4xM_wvhP8SXg@mail.gmail.com>
References: <CACRpkdZucwZNrUo3=WPM-utorFaqOn4AyhxMnX4xM_wvhP8SXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZucwZNrUo3=WPM-utorFaqOn4AyhxMnX4xM_wvhP8SXg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.5-2
X-PR-Tracked-Commit-Id: 286e7beaa4cc7734894ee214569de4669ed9891e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a305bd7c9c22e2f127b0674104acfa8133e3cd26
Message-Id: <157747590806.1730.12327621591699474735.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:08 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Dec 2019 00:07:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a305bd7c9c22e2f127b0674104acfa8133e3cd26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
