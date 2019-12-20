Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2221FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6A121655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865726;
	bh=tA5CZVASqIaskzAkusfsQ6gfEx9UR6qJBzv7fx06Q2c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aPxt8JaLYzjbhJnaluiYKjDyZTb0cues175wUVBxNZrOiAMyIG6Zh162tquFTTQpI
	 RZRUnqG+a9buarQs5hNCa1d73/1yMMhkvNdHkKThXFev0ajKhzajR9ohh2i+Afq60l
	 jkQwBLd0n/5zOxx+p6uDwfDRHYXFFXoNwWs+L3J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfLTSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbfLTSPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:11 -0500
Subject: Re: [GIT PULL] pin control fixes for the v5.5 series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576865711;
        bh=tA5CZVASqIaskzAkusfsQ6gfEx9UR6qJBzv7fx06Q2c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uS+RgCjJoW2l3IEjinVnGYY+J/NRGQApvIk7lD869cxoBwAjX5FvkLeIQnB1IoK0K
         pVgLq+02u/6efos0ZUQ+8qkZohoo96+EfM1jTZcV3sO/Ai13dc6a69o5ZhKJAXGyVx
         7yy0gBUaC9gomWd2Ky6aXuKnrglQAL3VFOi5WEKk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbY1XBspR0rrXVvCW2LwnRfA_DnA0YzwFy-dHCVhQSr0A@mail.gmail.com>
References: <CACRpkdbY1XBspR0rrXVvCW2LwnRfA_DnA0YzwFy-dHCVhQSr0A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbY1XBspR0rrXVvCW2LwnRfA_DnA0YzwFy-dHCVhQSr0A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.5-3
X-PR-Tracked-Commit-Id: 9e65527ac3bab5480529d1ad07d4d228cc0295cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7190a23a58b7587eadbe53aaffca280882838f35
Message-Id: <157686571095.29164.13062266512729283298.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:15:10 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Dec 2019 22:33:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7190a23a58b7587eadbe53aaffca280882838f35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
