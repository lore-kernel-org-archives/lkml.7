Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBA2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012235;
	bh=aY1C1tnozcBpJZWYlnN5rNJWHnPhCQKB2g81ZAF8o0U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jzZZhXWoM15fmk1ByytAr1p6juVKUqRgI92Cv5c92Fm1POTm058r9oIVWy96N0y3/
	 wm0W2w68VW+jVbO0mVN+v7en+7kjtmyfVf34aBctRIvvr1N4mDcVAcAVDacIFYufKK
	 Omz2t4/GAsoJRfe0kt89ldSkKHphwr136KfPGMck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCHCaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfCHCaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:20 -0500
Subject: Re: [GIT PULL] x86/mm change for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012219;
        bh=aY1C1tnozcBpJZWYlnN5rNJWHnPhCQKB2g81ZAF8o0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gXFEZDpjW+1sFEE50bR286OagNqYwHJnzHpQL5Hvl964X34iaL1SbBZNEBIhV1tp3
         zyc+Z1n/6bR8eV2LgLgVF2683qI9NHCsTjjznbxK9uHuewWFwBOW63KOW1gnZBH+4I
         UnbvjynioHCmNJY7a3zCKrPzAr6RdNSkTaD90mTM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307195400.GA72443@gmail.com>
References: <20190307195400.GA72443@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307195400.GA72443@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus
X-PR-Tracked-Commit-Id: ad8cfb9c42ef83ecf4079bc7d77e6557648e952b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f86727f8bd650b6b79bbbb7b0b57b3a43522a28e
Message-Id: <155201221947.3231.4684404118209259713.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 20:54:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f86727f8bd650b6b79bbbb7b0b57b3a43522a28e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
