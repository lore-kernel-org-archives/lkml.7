Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D557EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16BA206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429323;
	bh=7RK7k6zFwe59aDB+ZRyHm3AIeEx5K1b8F35cTQk2CQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q7cmIOnK+8dUPa5phuQLdsUaeE0xRehRJ5bJfxLymIAUk6uRiRL51ZdTLiAzcNd7Q
	 P4Ck+SBaVF4CuPqrorgGebs8wzoA/QtEPdD2sCmizZBsacLO2B2wJArf2NwJtruQkL
	 pZvQtUEu8H61y+e77KshKoKxubj5MAlKZVPE+3AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfDEBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbfDEBzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:55:09 -0400
Subject: Re: [GIT PULL] RISC-V Patches for 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554429308;
        bh=7RK7k6zFwe59aDB+ZRyHm3AIeEx5K1b8F35cTQk2CQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ehqQUIZRzyMCmGesa4Qjvzos/wIrI6DK2pyNRavt1b+pegr9R2hCVItGhDnscJtmN
         CVzuvDLpqQ4gj8bZYbJHp6a6wFEUPe5n1gkp2BXGNp8ExtfkxoQZzBd6ge4B0fgdaM
         iyRwlITsXSQIoGD2GA1kK4RJtSOlfn+UI1Xr1gEY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-2bff106e-098e-4cc8-bdb6-48f05d1065d9@palmer-si-x1c4>
References: <mhng-2bff106e-098e-4cc8-bdb6-48f05d1065d9@palmer-si-x1c4>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-2bff106e-098e-4cc8-bdb6-48f05d1065d9@palmer-si-x1c4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 tags/riscv-for-linus-5.1-rc4
X-PR-Tracked-Commit-Id: da4ed37873918eeb4e8db7f0cf55e0a7e18788c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e22ba96d44c4ad5f9970565c54ab1876448a5ca
Message-Id: <155442930872.31474.1009985731463982825.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 01:55:08 +0000
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Apr 2019 16:29:44 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e22ba96d44c4ad5f9970565c54ab1876448a5ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
