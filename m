Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD63204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574746815;
	bh=cFD+f5TFBDp4QmaT2iy0hoGnlywKNzl6LQBc6Ei708M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0VAZHeuke4vF1xKxnrFytTnA/Cxsk9yh8iViaGmIpBAVfiMWaOyiUmCokiiahH9q4
	 Pm9vwmnpdtNIf/58i0g7f2jFIktdMbf1m8j7QbsiZI8Lj4/zjEkAJWo41EuIJ7YBxX
	 sM7gBt8Wc6ATUySCwFe5Uxc7Sc1aaGdv+4/k71JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKZFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfKZFkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:40:10 -0500
Subject: Re: [GIT PULL] SPI updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574746809;
        bh=cFD+f5TFBDp4QmaT2iy0hoGnlywKNzl6LQBc6Ei708M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lIfbI3VjyOAWtd4nCm+/SMmhN1SdTodcyzPghK2FjrrTXFJmjMxKx9ePCavH/6tt8
         l8/hAy0GkTlv0MMl+05S/Xwe452i732GYS12D9LWpFX84vb1bpONfxUqAX2vFiP6Cz
         JQTh1axrFoMq+6gom4gu1UwBd+IQZmSfwEa1bFv8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125132935.GD4535@sirena.org.uk>
References: <20191125132935.GD4535@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125132935.GD4535@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.5
X-PR-Tracked-Commit-Id: e2ce328b282d0c7660576c25af6b9be34a6d2614
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a86f69d3349569a610eb9ff3b9e4bd1c40fe62f2
Message-Id: <157474680931.3611.17306697762251396774.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:40:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:29:35 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a86f69d3349569a610eb9ff3b9e4bd1c40fe62f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
