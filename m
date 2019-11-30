Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC32C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6FE20880
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155120;
	bh=FFz71X4UbEZ//3Fo1tqp8IK4e/ZBYwepw/nZk5ExDgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hk9UKGC+8NnXmF/Q3J4x6vTxI89UbZ9S4eYi02sqr0d1HD4ygL+HuHTphdjziG8Op
	 D61IxjVixnJTchTAyqLWHQnKoHXeF15xbPl/SbHoYzRxF2geQ3LDKGJxjINrCsmWqf
	 zZDqyoa49JEcTwv2dEtCA9SdLT6VRfVwYpp3B8SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfK3XFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfK3XFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:17 -0500
Subject: Re: [GIT PULL] nds32 patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155117;
        bh=FFz71X4UbEZ//3Fo1tqp8IK4e/ZBYwepw/nZk5ExDgY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zWTmBftqUTAjwMytdG56D7Vv1QOjcRTJdoai/5OmRot2SGRqKbAUK99lec/qXPOJV
         tRwPwtnftXiHAfD/2bZDpgGLr6NjQoLQROLw6f0J+EZX+V9BaiyDKtmKGIEXQ25G/R
         TCNfYIl5HU25CgubjKxsJ5O7wi89gAiUv+hfWQFE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEbi=3ccGpiujBnHb6hJhXwqR-q_XW8eW6=qgEQbQcPDffjqCA@mail.gmail.com>
References: <CAEbi=3ccGpiujBnHb6hJhXwqR-q_XW8eW6=qgEQbQcPDffjqCA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEbi=3ccGpiujBnHb6hJhXwqR-q_XW8eW6=qgEQbQcPDffjqCA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
 tags/nds32-for-linus-5.5-rc1
X-PR-Tracked-Commit-Id: a7f96fce201c4969178c8709a49e005d9792186b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2309d0768237476c3144aa296264ad9e19598461
Message-Id: <157515511734.27985.14353600559672184927.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:17 +0000
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nickhu <nickhu@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 17:25:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2309d0768237476c3144aa296264ad9e19598461

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
