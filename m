Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D29820835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796655;
	bh=IcOBj61tKOJpLlLWOYGGnyA8plh4ZB47rGQeXlPeB6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qXC+dMlAe7kJMU2WLH9xeUNxHVH4VPRkxWG2d3d0FkJn6dD73/Kl2/QfODYGsRFQY
	 7E8Goz8a3CkQM1Q3T2ROOeFmtYrRtrQ1uwwPitB00AuEH0rxW0/29yEPcuXwGhPJGT
	 LoLxNwrA6N6PCIguTV30mea2mxZmySJgC5+XNOlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKZTaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:14 -0500
Subject: Re: [GIT PULL] x86/fpu changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796613;
        bh=IcOBj61tKOJpLlLWOYGGnyA8plh4ZB47rGQeXlPeB6U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n6/eopX9xD8AQ3hZ5KgkljgsIKMIaC05xkGnOpgSE0Z97AOdTqd43RHFJGNtbTLVg
         wcgBz4LRY9qCFkPJwXMfxzaOAxeGuLvqF9F5jmJrt02w4X3PBZE2fW9uVX9FIM1bC4
         msH8v5iAPlnvkMeRt3n5RILJdR12cNnVGmOftxsw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125135421.GA11526@gmail.com>
References: <20191125135421.GA11526@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125135421.GA11526@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: 446e693ca30b7c7c2aaeaf09e90ec224c7538fec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a25bbc2644f01a9e680af4f760b54bd4834fdfec
Message-Id: <157479661382.2359.7811025901131884890.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:54:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a25bbc2644f01a9e680af4f760b54bd4834fdfec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
