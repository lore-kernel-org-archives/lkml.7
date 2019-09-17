Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79996C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456BB21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568688921;
	bh=I2TEp3uUDEFy9Ptuc9rpREBbsU/5IyfC38dtjGnAXT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ipgUAjn2BvBzuit2AFR+3pIohDUllInjRkxcdGtATDlaBPEZiziou6wKMCYxALxd3
	 vYrnBqqY+jcLsDJVjuNDHVuUPgccDRr4/R6IZU2j8Vv90hmLTTxjpL/eYSshn4LURq
	 lfVZN9fROM8ENLadmgfelRa29y+W0oT8mLjmT2lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392064AbfIQCzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392043AbfIQCzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:19 -0400
Subject: Re: [GIT PULL] x86/boot change for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688918;
        bh=I2TEp3uUDEFy9Ptuc9rpREBbsU/5IyfC38dtjGnAXT0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BCR7K7/PQkTj3TfZoQTRbt892NqQbbASj46c0G9RmRU+SBMw6hhWbjsM+VVtcfld7
         PP4i58/wkjneqlXAMfNBbmswf3zdeeVOk22HUFBeTz6H6JdNgaWjfaD9SzjkkwHJWa
         CckRPWfVbO/clXxrtzvbXLAMchDl4Z8WQJbZO/wI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916123943.GA98857@gmail.com>
References: <20190916123943.GA98857@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916123943.GA98857@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: d5a1baddf1585885868cbab55989401fb97118c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49a21e52a6baeea076301fd944268fd0d1f75be1
Message-Id: <156868891871.5285.14257131346539588451.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:18 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:39:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49a21e52a6baeea076301fd944268fd0d1f75be1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
