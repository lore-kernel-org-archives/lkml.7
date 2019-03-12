Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFDA214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552362317;
	bh=O//aaIvkoTFtYKicU/FpH+a42n1rsDt+rVF25t+R8LY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OCW3eXdaXb2p5OFe/nhSCeBA7QQaoUf6ShonkYPwIuT7XM8jU83oN/Wkl71XUSlwk
	 tvsel2Vq/DxnmbVYUHmSGaweoIlezMx7Qnf57BggYBYrmm71yRmzhLq0ZrX0INwQLP
	 dAkkd8Y+yFiL48VLbTNyR/S5jDZHTr9kVNxSSClQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCLDpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfCLDpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:45:15 -0400
Subject: Re: [GIT PULL] XArray updates for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552362314;
        bh=O//aaIvkoTFtYKicU/FpH+a42n1rsDt+rVF25t+R8LY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eKAgj3Bs4vQUdfvXOwJJAl+f86xZw6sZqg+ObtY18myIeS57OBuo64/JdGN0KWm/j
         HI/1IC77SLmuTUJgk3fmXX8sF4G2ILTdtErNkc6vGZJshminuUG28tkNa1Q9MRKe8h
         njJhg+IzRWSxGC1jIGxXkvT/3IRW8pXP2TrlgG5U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190311182829.GE19508@bombadil.infradead.org>
References: <20190311182829.GE19508@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190311182829.GE19508@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git xarray
X-PR-Tracked-Commit-Id: 4a5c8d898948d1ac876522cdd62f07a78104bfe9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea295481b6e313b4ea3ca2720ffcafd6005b5643
Message-Id: <155236231471.1472.11682929119367395097.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 03:45:14 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 11:28:29 -0700:

> git://git.infradead.org/users/willy/linux-dax.git xarray

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea295481b6e313b4ea3ca2720ffcafd6005b5643

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
