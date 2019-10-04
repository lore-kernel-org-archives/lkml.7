Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83050C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD8215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570221615;
	bh=KzerK/f3QXvAsnl4IaRxU3mdhQB2zwWapZZSem9lYVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rhpSj4uYxVmyltEoVOa2eMIOQQ45OAnb63PuEY2QzVv5PsELxSQpoMXikFKGyqxdd
	 FkgG+2dJNnhyxNHhtukw0bNdWXAWh0Srp1y3z6hGzkgzUftCSzwdRCxvNiWmpxExvr
	 e+UnotStCu+OS6WogcWqH3SA0WmAA7gzD1rhf4hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbfJDUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbfJDUkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:40:13 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570221613;
        bh=KzerK/f3QXvAsnl4IaRxU3mdhQB2zwWapZZSem9lYVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vSIq9J8Oe6MBe9NJwAGB7ivXE/KmAnJxT0tq6XETHd2kg1HlsZireCeo7Sa+2zmer
         kvMgNLkcQJCccdBslcfGpxZpe/q/HpdgzdXcAV3GR9P3LPGz6KEMQJrQ5ak7WZ2DoS
         mmP0MwA0hS1+jrLJ4qYBEK8MFSWwSwlhvEJ2BwU4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1910041036010.15827@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc2
X-PR-Tracked-Commit-Id: 922b0375fc93fb1a20c5617e37c389c26bbccb70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 812ad49d88b51fab551acb3c2d9c7d054bc69423
Message-Id: <157022161327.19958.10759204343706672644.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 20:40:13 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Oct 2019 10:36:54 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/812ad49d88b51fab551acb3c2d9c7d054bc69423

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
