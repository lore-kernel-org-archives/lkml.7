Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F43C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF80218D4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452817;
	bh=qYsO6AvvPNK++3GSUOcK1rlDbF13Zqj8OAN8N3x0smg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0G7q8zl3p9c/IMQNMwtrKSqUE4kUI5kP5XkUOrWp1cyKUkbYRMKfhvNe5eqwLMwjw
	 bJo7o4lxV0wW9Pa7hxrjLZLihZF0VzlGVTUchdkPT1ak2266NFLeu6HIY+rTi/PmTk
	 zxSftHJCj3SVKsuTpbdcllxnJnhAPSZtGHJYiT8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfCXSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:13 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452812;
        bh=qYsO6AvvPNK++3GSUOcK1rlDbF13Zqj8OAN8N3x0smg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kiCO+VM7LFTTRSijE+pTr5Z8rLaAvX0+9O8MqhIg7E7sn9HWrRCv2NqImsdliheIZ
         9DYI/VtmyJVY8pCyKkrdKG5hQHgnnb6KrTZaGQhne9LGkyEnSpRe7a63WX1YZWxv8V
         nAfXKQ2tbnlAIoR/i52np27PUT/W1/Ib+G2JebMg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190323171343.GA19483@gmail.com>
References: <20190323171343.GA19483@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190323171343.GA19483@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.1-rc2
X-PR-Tracked-Commit-Id: cc5d04d840d62d7c75e268c51da7cd0be2ee03c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0046bb302dad1c3e766eb7c171930d01f9439fa
Message-Id: <155345281259.5356.8835307025539648979.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:12 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Mar 2019 18:13:43 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0046bb302dad1c3e766eb7c171930d01f9439fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
