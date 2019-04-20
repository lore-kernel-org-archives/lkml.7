Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC85C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0A2147C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788310;
	bh=k1bRNe+xfOa1WkNBBmLzwr+5VudkbcEM+Q9gZVVdW5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XwrjbGKhHPc6JURv8c1XMtsdL570Ox9FUi8TjW3zZpn35vfHP2bNrMOsFW1d9BDhf
	 TBwW+4A/Z21UYfwapTRxM5ASaIVAkJjdyAiHj9RdBH3iaTHQ2pB6+1IGkZjrMWkoEt
	 zUNcpYp1jA1PLh4YZdk3jkuSCfGZ7N9RIneX8jP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfDTTZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDTTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:06 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788305;
        bh=k1bRNe+xfOa1WkNBBmLzwr+5VudkbcEM+Q9gZVVdW5s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G1LsZYixG+qimlo5//N27lVV957x/Vq0ncDl1PuS6XnXdbOzjZ2brZJFdNEqyDpUB
         xuLKv23N/yDtLTRoy35HLhr91L4dHmeWCtQvjqN5OBx+vEJJdd/rhj1x3eBKt1ZO+b
         eDC0KkwmBPbCpXv34iKi/bb8pqgiHrDx7fsVDhwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420073809.GA74261@gmail.com>
References: <20190420073809.GA74261@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420073809.GA74261@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 2ee27796f298b710992a677a7e4d35c8c588b17e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fd91d719eb1ae83ef500eb4148d11db9db39a41
Message-Id: <155578830578.28386.13640173677676856513.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:05 +0000
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

The pull request you sent on Sat, 20 Apr 2019 09:38:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fd91d719eb1ae83ef500eb4148d11db9db39a41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
