Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F95C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28F520836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161320;
	bh=MfEypB1MZtfVd5k1jlB55FSOi4Cb2dVfiQ1Egi98lpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qcTyWxTzGZf5N6sY/x/cijRBWG84dcjpm+uFINvbQ65MTtBEtpHmZ0db1/xhwuQUE
	 NYswafm9i0mMLaWku/NVITEly+1WRjXKQJl9aBNHpDWznKZGwIup5DR8HKTyEt5btv
	 6A1VqJ7sXpJHuTUZi9irSvEGdW8lioCGipsd1vFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCITzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfCITzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:15 -0500
Subject: Re: [GIT PULL] pstore updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161315;
        bh=MfEypB1MZtfVd5k1jlB55FSOi4Cb2dVfiQ1Egi98lpg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=au2IWxylGe08hKbP5czgjG1VOsruXFVGsvhubbkwG9QI5n40T33wknOQzlHckWCGD
         4vl0ioQ0Bs1a+h9XDOb53IP0dC3YADMAXv0SpwiTYwFfRXZHPaI0+IWVJdMQW3c38v
         VrmwPkzGYL0kHeQ3tkymXm1yzT4LKPrUkjq6ojEc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304172751.GA5887@beast>
References: <20190304172751.GA5887@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304172751.GA5887@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.1-rc1
X-PR-Tracked-Commit-Id: 93ee4b7d9f0632690713aee604c49e298e634094
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a39f009acefd85d3e36bcae828a4e67c9dce9684
Message-Id: <155216131522.23333.9863884705942999619.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:15 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@yulong.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 09:27:51 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a39f009acefd85d3e36bcae828a4e67c9dce9684

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
