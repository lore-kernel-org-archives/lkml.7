Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7229DC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510B02073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278626;
	bh=WiZ3jJAfgiP9/4/Xz2sPhyKv9s293vyVEorQexoUaq8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ErZXGV+5Jwc5jwUpJUv80gs6DF7Wd8ltNP4h7a8tZmwmEvvaQqouikoh9GS0etxeh
	 i2XPBiYeYU0Yyy1N2ipKldCSfoApeuoW8Aq66iHIkqdqlvhgKx/7qPp3p+BNZ8lJkM
	 YX3r9+sz+AWDXs3a30tpUPXTpMxh2nTrvXzXTJdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfLMXKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLMXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:14 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278613;
        bh=WiZ3jJAfgiP9/4/Xz2sPhyKv9s293vyVEorQexoUaq8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NsmklCENb9GPHohlNQh2wI6TYGhDSI1fnygXAUwGI4tcpVOPWjg9aMHbonCRMLuvf
         PW4/ePQvtGxSAXexEVeECW7Mec5qD0uWguDC4hryegqvc0pTPdCHHG2piElzI5ty+h
         RcUBHbXl+aXwgIVIC3TzX35o9yhiaRxLwxK4jFHk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblscfpad.wl-tiwai@suse.de>
References: <s5hblscfpad.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblscfpad.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc2
X-PR-Tracked-Commit-Id: 5815bdfd7f54739be9abed1301d55f5e74d7ad1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b61c56227bf5a2ca5e146cebcdf50b2e15e4c973
Message-Id: <157627861355.1837.7004463837593543477.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 12:17:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b61c56227bf5a2ca5e146cebcdf50b2e15e4c973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
