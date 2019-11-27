Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18BD20869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880317;
	bh=y4tS9BY1pWrsWMwUVOTVFb1Seyjzd72/T1MBqn94aAY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wtBIq3qI8GZyqiypifRAH3LPbL5v8LvIqFrnA+4MXCB/kV6fAWgAmSVkyAsFh1eWy
	 VXFjZ0kz7wi/h/cc6LaKbSyPF7IDiXXm5mixJvC8XBJBzIJ78PC3GEdTFU2uzrkdoA
	 1yVpdOl+C3GGfFQuq9N9hNtThZAQ1+hciYNIHi4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfK0SpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfK0SpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:14 -0500
Subject: Re: [GIT PULL] Bulk pin control changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880314;
        bh=y4tS9BY1pWrsWMwUVOTVFb1Seyjzd72/T1MBqn94aAY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ylt+Gb8g67WZc13F3kfNscr/UzlkWBjLs/yQWOgiI5OjCYlJSVNwBFtnPHcc5vF7D
         azDiIbFtQIeq5xjEd0TjQAtuA4oFOQW6PCFncWpVCAGxSAyZFfMz4vR5tmfiaBrnZl
         x+LBs1CGS6YIqKj3gVUp2nfBsYURCU2Z5diwsAYc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZYR=5-vf29vYN-gZWRNta3axWNxMTve+hoK_ugkUhcnA@mail.gmail.com>
References: <CACRpkdZYR=5-vf29vYN-gZWRNta3axWNxMTve+hoK_ugkUhcnA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZYR=5-vf29vYN-gZWRNta3axWNxMTve+hoK_ugkUhcnA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.5-1
X-PR-Tracked-Commit-Id: ae75b53e08b95cd189879b00f6a47cbdaab1f0eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc5fa4656864d3391cdf13512ffa0733ef72fcdc
Message-Id: <157488031404.21185.17168526599505028774.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:14 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:00:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc5fa4656864d3391cdf13512ffa0733ef72fcdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
