Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EC8C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9EE21855
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566064210;
	bh=78zR3XNz15/8fX/IXVHrbZCn0tf/df5NoeperNcnbQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kK6gVm7563TKmOec0qsmrw+vH5uXirb+1Jk5NPC+4y/m2vOH1aydInoGpzDW3TqzP
	 e/mqoSWi9etneeA8UooDyt8tGY8Q+n8z7oVQyshJTBy3nhnUhqsowm/yxrX2YstFSo
	 Xu+XWUdf4v75bypR5Memn8HNvC2P3ZwU/cVRMxCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfHQRuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 13:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfHQRuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 13:50:06 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566064205;
        bh=78zR3XNz15/8fX/IXVHrbZCn0tf/df5NoeperNcnbQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YpKqFhHigEhtgl36cZ9g9tIR0dLIcYYZ1zQS75XWy4+/zVPOAeqZvSeX0SVotWK7S
         xo9TR+oGdHtrDFRZagXyAyyIS0e6hQXKcqT35UGhDN+sqTi6TT2Rxz40gnSQ6WPGIE
         NqdM5rvmVHcd07eDaf3B8I84iHE+30O2BEQM3uQE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1908161824300.18249@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908161824300.18249@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1908161824300.18249@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc5
X-PR-Tracked-Commit-Id: 69703eb9a8ae28a46cd5bce7d69ceeef6273a104
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f478b60118f48bf66eaddcca0d23e80f87a682d
Message-Id: <156606420515.15242.4838104817894309424.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Aug 2019 17:50:05 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 18:25:40 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f478b60118f48bf66eaddcca0d23e80f87a682d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
