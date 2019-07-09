Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10665C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1582173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636713;
	bh=AM9Oijc1kuJg1h1fP89xJz5cxOUQX2xrE9jndlRD8pI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s25dCYIcw1EOBqdVJq9O2fsosRBvcUWAQuv5EzpC7QluYz8slQMYtmdK78v2+CAjp
	 UrdALiEXPwA9woOvAajEVI1/qNwmvH3aMW1IUk0Y0KUdSC+1WoqwwC+iTFYZeRXkk/
	 2xkA2YUvdonR0pdhnHOVCmqtncUYJ//qr8gCqKbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfGIBpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfGIBpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:09 -0400
Subject: Re: [GIT PULL] x86/cache changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636708;
        bh=AM9Oijc1kuJg1h1fP89xJz5cxOUQX2xrE9jndlRD8pI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u4PYy30IgUF6m089JLUFUeGsIfpS3eghnU6Ykf964e3E3EtYr6QCcNcD7yV4yERid
         28UzfM+Ze1dEnJJ2fY3gAmdn8zxhZ5241vcZdxEMb6Emc8Yvl81PC9SzdDwCUadGjf
         rCt0irAjiNQdZ21za71iY4/RzHi2sM+hX4oAxloc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708160048.GA33834@gmail.com>
References: <20190708160048.GA33834@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708160048.GA33834@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus
X-PR-Tracked-Commit-Id: 2ef085bd110c5723ca08a522608ac3468dc304bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cfcdad7630de2b2eb09740bdc6ee921de8c785e
Message-Id: <156263670819.17382.2937360480718874014.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:08 +0000
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

The pull request you sent on Mon, 8 Jul 2019 18:00:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cfcdad7630de2b2eb09740bdc6ee921de8c785e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
