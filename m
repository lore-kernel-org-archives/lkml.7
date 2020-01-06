Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CDC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19EC21744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578344730;
	bh=JTF/FpZa04zfpDw/Kg7Pt2l1gB3EiFXrFudDGVfmegw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DwtzWiS6Zvc4bBrP9gR5F9Q+jzKuGckFVrZ6+NDVnJV8QOn0zwNmdvH1Q+tU80T4Q
	 zZBTtXhLXzpPvWKWpqp5tq2GwJMy8huOGVBRWrHbMkA8vsq0wsOIBY9YKt9LJVmfvH
	 9++8RFjSCisSYQyDgtVKyTp+I7PXqeAZ6L9lp4vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgAFVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:05:10 -0500
Subject: Re: [GIT PULL] spi fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578344709;
        bh=JTF/FpZa04zfpDw/Kg7Pt2l1gB3EiFXrFudDGVfmegw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o3e9jldxsGkEFO8liuMmFV8j9HnSNw8bVQAgPUuzsijBO/nYJAq9Nix7VRHyvZd1h
         IoQGvJkeeGpGC2Y4jAWv/wYvX9jNBrV66HaIZBgMTyeyZ2bjV+8vnyvS0pv5G1j5//
         y5BCwaolxU7lPKXcVB2yaieEQMRx0AKy46fV9Wyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106131232.GC6448@sirena.org.uk>
References: <20200106131232.GC6448@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106131232.GC6448@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.5-rc5
X-PR-Tracked-Commit-Id: 09b6636cea4f8e419d7cca4155e8695e462535a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec7b3f5372e2f674ce19c23ca8f5a2c103025264
Message-Id: <157834470942.27503.4619949117616234858.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 21:05:09 +0000
To:     Mark Brown <broonie@kerenl.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 13:12:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec7b3f5372e2f674ce19c23ca8f5a2c103025264

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
