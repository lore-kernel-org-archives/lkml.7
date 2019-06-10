Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28418C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40FF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560189312;
	bh=UvRMWHtb8FevOEKlUTtXKgJHVD3tkZp8O0Vm2nPtVjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uJgeHZxmPRYGJuQKEK+uPLVAEhkf7P1OwPjIG8CE1hls0GsRdhG/AMt0M4HwtJkyL
	 ElflYAsdJ7DA200WOc5ie/LXYWZde1/0gzMD/cyzUww94ED9fHpFBg3Ah5HDJg43Cv
	 vGNKhL2+s6MIt23qGV75U001pq0NNH4lrb3XZyKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfFJRzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388108AbfFJRzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:55:11 -0400
Subject: Re: [GIT PULL] spi fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560189310;
        bh=UvRMWHtb8FevOEKlUTtXKgJHVD3tkZp8O0Vm2nPtVjA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MxUbbGEstwEIXI+MN1TNniDpbxHXR00xl/Z0zu0VGut5U1ceW+ME53p8JfCa9clLY
         lTn5HDo2rgnADzUlH48ZPibAkO2BFb/arMF4smN3ib/QGopGH2a3JzlJqzhAakR+jI
         acUoPmmRmbq6NDlwT9WMV4GcPpA9Mju6/SCdS2k4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190610142648.GB5316@sirena.org.uk>
References: <20190610142648.GB5316@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190610142648.GB5316@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.2-rc4
X-PR-Tracked-Commit-Id: f3440d9a0da292dc4998d9393162fcfb996fd671
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59bf4282c8b0abd27cc4d550e20ec5b85ccaa19
Message-Id: <156018931064.9867.6363959559174999618.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jun 2019 17:55:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jun 2019 15:26:48 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59bf4282c8b0abd27cc4d550e20ec5b85ccaa19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
