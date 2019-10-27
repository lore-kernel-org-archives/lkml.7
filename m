Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1367CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F804222BE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572175807;
	bh=C7auwD1WXWbMnFdBuCDr/ykryLHxN64hBFI3GfcQY7E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q72hKc3tjFQFdOP5RohVdTipM8Xtsi8BZ1cTGOtzD1QVSbaz2kc1qeCzbbQky+ouL
	 EP6YFDyf9tsggp/sHDR55EuE0zXDzRIxSs98nlgMQmH1Ay/2C6ekEulu8qjhkXlwAV
	 wdOEFN4GwffrFBpO9igU1zyIIN+62itCifM9dOvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfJ0LaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 07:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfJ0LaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:30:05 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572175804;
        bh=C7auwD1WXWbMnFdBuCDr/ykryLHxN64hBFI3GfcQY7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E9rIU8KwjAmwtRcMrwUc9kHyeOyKFUwkAoctz8MOAdDkw2EAYlRc5vkH1LXlzyq4a
         2fcr0n1r9ueu9RJcxDVKujrVgJOc5uYTaHWpjWbLXkCFiUXgqW9Yj4ZwACwwobr7vh
         vCfodc7/t3c5rO6OWqy4p8dUcvwQg27wBxwRDCC0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1910261701250.12828@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1910261701250.12828@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1910261701250.12828@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.4-rc5-b
X-PR-Tracked-Commit-Id: e8f44c50dfe75315d1ff6efc837d62cbe7368c9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6995a6a5a538dae047ff16ec267394e5258e84b7
Message-Id: <157217580489.15608.4260623730121864685.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Oct 2019 11:30:04 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 17:02:43 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc5-b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6995a6a5a538dae047ff16ec267394e5258e84b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
