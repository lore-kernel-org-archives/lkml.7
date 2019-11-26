Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CE2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E1820835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796639;
	bh=kElraH+CQak6Qr3LG/IT8ScDMktnuYWLyMB4zFgTBwU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dLoeMDT7HBVz6OzhjcfznEilNaH5QmxmFENBzQ+GZd97SpOXSBxWMuSqMO8o8lFIb
	 xwveQABjn9r3/YmdABVT6p5xrCGJOK4poOX1UUgwjFdv3Y/mljBUQgvbJdX+hZPb6z
	 SHW8UxBXpvXabfxI0hl+sa15hpfWGALVOdoF30uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfKZTai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfKZTaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:22 -0500
Subject: Re: [GIT PULL] x86 fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796621;
        bh=kElraH+CQak6Qr3LG/IT8ScDMktnuYWLyMB4zFgTBwU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gnK+me6P0Tn/hPHbLj4DCfJ1PS/9ft4n36jUJzAA9RmWVh+rg0NuJpfLHnmkc2qBj
         esQiE+sXvgBV0ebQUdoP4LCaQI7z5MvGeYyvTX0KkCKtdmxANhrGj5+/hEg26Ksx2/
         uaf5UcHsl+6+xjvMSX+gwECyVTx0sKcb0Y0Oh91Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125155346.GA129303@gmail.com>
References: <20191125155346.GA129303@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125155346.GA129303@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 4a13b0e3e10996b9aa0b45a764ecfe49f6fcd360
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c4a1c090d8676d8b84e2ac40671602be44afdfc
Message-Id: <157479662154.2359.11115454383319464080.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 16:53:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c4a1c090d8676d8b84e2ac40671602be44afdfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
