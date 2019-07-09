Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C35DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210B32171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636731;
	bh=7tW/56vK2HnBZ2fRRwoeT/LcWNkPpKqZ4aElIKB2Nb0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eEUUcEEXA0gGt4vUBM/j9kWw9N//gd4EKNgkuWYMyBpH1v6c0XRqp/ECMRqv66u3q
	 FEoBUc5eb7nuqGNFG0NLUXcktlk8UxQ4axaj0x6ZssYi+CpN/OyozyT/a/26katZvi
	 0MPLs8I7XyKkZGnb1Zy0rUXVHWyEaZJCx5VCPEZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfGIBpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfGIBpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:11 -0400
Subject: Re: [GIT PULL] x86/paravirt changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636710;
        bh=7tW/56vK2HnBZ2fRRwoeT/LcWNkPpKqZ4aElIKB2Nb0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=llkN4LjJlKtlf3tZPH1b+EiTiMvesyu4cpgO0thZCI/8ALZZeKvXsderBndD3cKI0
         6x20GMLxX6dRW8lXce8QU5r/Z2egcsiUTSRrjQ5WOvKdwkwHS4YE13wQYN2mp4AMSy
         wHU7CKp7f/cFShsh/DGlTony/AO+9xl/AB0OL3cI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708161448.GA115581@gmail.com>
References: <20190708161448.GA115581@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708161448.GA115581@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-paravirt-for-linus
X-PR-Tracked-Commit-Id: 46938cc8ab91354e6d751dc0790ddb4244b6703a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da1770238597a4619b7845583881543ca81270cd
Message-Id: <156263671080.17382.3438209356020685832.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:10 +0000
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

The pull request you sent on Mon, 8 Jul 2019 18:14:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da1770238597a4619b7845583881543ca81270cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
