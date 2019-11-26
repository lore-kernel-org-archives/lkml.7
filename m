Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BBCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F832082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574734507;
	bh=xqVOCJ/WVWb4zVZQzDnH1QPsDpkxwaF73ez1zhIf1Zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HOzeMMkbeX1KH6Scr2hUJA3WgR6rwpNS7OSp8NZSPbVRetAZgoRZ/khCRmarIxmju
	 Cc14pmng+Aj6sTxuwal7l1xNfzbByhnP6uas9igC9Xa+i6cF9jAw0RLBRyb84ddRDF
	 mDyRZ6TyGripRLYobi8q8BYV8v9eyEOyXpwdpAvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfKZCPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfKZCPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:05 -0500
Subject: Re: [GIT PULL] arm64 updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734504;
        bh=xqVOCJ/WVWb4zVZQzDnH1QPsDpkxwaF73ez1zhIf1Zs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fHzyAb/7XhXExmt+wHFtSqegCg6K5h4maEIEsGWvshORSwn+yrpLpdk3heS2VjIdt
         9nQNeG/TrGjNMWg+sTJW3rOpWefw2K8utyixN7aeXgQHvQaQAlXW7mgIxrAdb83h46
         PUkzoWnlybC6/myuve9nNYAN1IwGikvwn9Mrp0io=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191122184806.GA3422@arrakis.emea.arm.com>
References: <20191122184806.GA3422@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191122184806.GA3422@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: d8e85e144bbe12e8d82c6b05d690a34da62cc991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ba380f61624113395bebdc2f9f6da990a0738f9
Message-Id: <157473450478.11733.10274137800769893426.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 18:48:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ba380f61624113395bebdc2f9f6da990a0738f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
