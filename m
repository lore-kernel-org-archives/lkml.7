Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A27C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE1A20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567718113;
	bh=5oGx64RvRrnGNF98LS1c2cmerq04k4GpPAkCe1e5zs4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RcyXMD0uow0oTitd1swgzbRtNhVpoAgEfUJ1XuStzE4voJxwbPZNyDsK/mvp4+fZD
	 dZa4b7/OadsjNuBraHnjG1oSBeVRwa7P4yhmdMPtfiewC6EI9KCWM+VHyu8F2hMDXt
	 dCPd3GFcKsK3O1hUv5eKr9fG14v2fNcl3kGbdiGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391807AbfIEVPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391786AbfIEVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:09 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567718108;
        bh=5oGx64RvRrnGNF98LS1c2cmerq04k4GpPAkCe1e5zs4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HCxqNgMUSwn+NWzPoxDpHB4rSvVerXMhyrdnFtlT6BNijV+NDMRHsataByHAjYU24
         10Mf0/cOI5foLTc7bGDMaSQ8War0EFV7DdYpSArOKrNHKc3kmZ8wrsVFt1FmlgLQQA
         x39Pb+C37I/s5zLiKGJ+Gvlt8fmwnJmxv8oAoJqQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzhjiq292.wl-tiwai@suse.de>
References: <s5hzhjiq292.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzhjiq292.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc8
X-PR-Tracked-Commit-Id: 2a36c16efab254dd6017efeb35ad88ecc96f2328
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3f5e1f5783974813b5d43beb38c4eeaa67afbef
Message-Id: <156771810839.8025.1622707613161712838.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Sep 2019 21:15:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 05 Sep 2019 15:52:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3f5e1f5783974813b5d43beb38c4eeaa67afbef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
