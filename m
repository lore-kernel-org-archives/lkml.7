Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2267AC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB71C214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561800622;
	bh=W3KLJ7WI0SIswj+3tMpOF9FFvFWt7HRPZjQT+a2v2Qk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GzHQmaRPlEIc+nE1Oy0rAuCkeB0D5dpxynmx8Uu632wTEWbs6CH3xb0g49cWQxjyL
	 YjF3BGU0i5vvCkJzbUsp0beCOisZV7mDeH0nsiSX2upkA4AogyhXx/m6BH1LVTVrP1
	 geez78X9hO1SzgZA+xMS7bD1AAgdOBVm+idOvtNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfF2JaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 05:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfF2JaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 05:30:06 -0400
Subject: Re: [GIT PULL] RISC-V patches for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561800604;
        bh=W3KLJ7WI0SIswj+3tMpOF9FFvFWt7HRPZjQT+a2v2Qk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0HdqAKkktDH103Es/5uvSbDb2rOUamgSCWK7Vd8JQ/pQG10NjMNBjLOWVtufAZAx1
         NYClhHUafz7EnLSeW+yGY1+GXfYRo5zXNpGdf2IeNtQoZY/4WfHEMuBZ06eQo6/tCh
         1kbN0PrcmrJmShqNbIrAY7avLQb1iFoWbKWs4Vvk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1906281541520.3867@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906281541520.3867@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1906281541520.3867@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-v5.2/fixes-rc7
X-PR-Tracked-Commit-Id: 0db7f5cd4aeba4cc63d0068598b3350eba8bb4cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c57582adfda3e7026796fbde81e951ea72edbb66
Message-Id: <156180060441.8003.464914196516513928.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 09:30:04 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jun 2019 15:43:09 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-v5.2/fixes-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c57582adfda3e7026796fbde81e951ea72edbb66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
