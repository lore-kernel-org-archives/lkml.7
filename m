Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED54EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E0A22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564071922;
	bh=6GZ6RGgSX864lLqxarLspo2pFTIRkvOhJAKWGpZpFJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e0916W4UFA2RXcWdDu3ay4i1GRJtw3uEMy8n6Y9I+7AgGEQhjEWW0/wzrUZpzHGJ1
	 lCP0Fu846kQ2X2LeU62DPMcN/vOMbxOPYhoZbnIV+u+8doJ+mD/sjxZg/kEaYk1Wav
	 53+Dl0iGQ8C4EPp8X2aPVXUPkMY+CYF9uK15WQhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbfGYQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387722AbfGYQZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:20 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564071919;
        bh=6GZ6RGgSX864lLqxarLspo2pFTIRkvOhJAKWGpZpFJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c0tvnRUa4vAXkj9lqa+27k4aWZo+s8RuWemee8gIBqeL8sgw97rChwCDpleBqZkck
         jYvejNeEJaNxjPUqyXd51kveWCGZ9pIqq78zhTLN+rS//AYhFzjmk7SuoDv0/227vr
         RqEub1bpWd0AkjkCi9d5T13XAXC3IpWk8PzNCLXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1907241331250.28120@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907241331250.28120@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1907241331250.28120@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc2
X-PR-Tracked-Commit-Id: 26091eef3c179f940d2967e9bef6e22c9e1c445f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a51edf751b660f3fc1d0724bc4cb839bdaf5576c
Message-Id: <156407191942.26857.7692173476303162261.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jul 2019 16:25:19 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 13:34:03 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a51edf751b660f3fc1d0724bc4cb839bdaf5576c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
