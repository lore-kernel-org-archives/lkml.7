Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBBEC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DE9207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560189316;
	bh=OWssMXpsFhMyz691rvcXUXDxMCp/WxKrEI3OYjON14g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bAuARnNPeUocQo97vrJwOpLS5V/73tY0lsLLQH1yDg21nkZC2v2n0AuONinqOsvZe
	 9XpjAjdQi8GxITYy8d+iDqaONJBTMlRYga/v+2r5YuTEHpl+/pWAdDNYbVEcLG1t96
	 ePZ8Xa14cJmpCdjiVyklRRtQFKNRq6x5iyhn8O9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfFJRzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388565AbfFJRzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:55:12 -0400
Subject: Re: [GIT PULL] regulator fix for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560189312;
        bh=OWssMXpsFhMyz691rvcXUXDxMCp/WxKrEI3OYjON14g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0r9zKDUn131PJECDqbSFB5G58k5HLQhIfVoaidotw1dH+62dCKHQmgXMhK4KceA+1
         YGAQ+l2jzo8tEOL5U+H4omprHM9N+HRn93MgTDJF+L9wkkryWObmImkwON1s30vTeu
         B8JC+fuK9u767ifdf6R/BgrKym4R1dJ2Bg4CGOXQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190610142942.GC5316@sirena.org.uk>
References: <20190610142942.GC5316@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190610142942.GC5316@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.2-rc4
X-PR-Tracked-Commit-Id: 7d293f56456120efa97c4e18250d86d2a05ad0bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e3b6b8ecc53ffec9472ce5468307061072a5ded
Message-Id: <156018931225.9867.6184908411440165901.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jun 2019 17:55:12 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jun 2019 15:29:42 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e3b6b8ecc53ffec9472ce5468307061072a5ded

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
