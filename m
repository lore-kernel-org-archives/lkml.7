Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B1C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F323E216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669736;
	bh=C/6PseyECzjiJ1b8hqViZjWGUKqI7ydDja4Ogyl6Vbw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZIOPRy8f2LoJVq6wYGLoccb8knxM1/N2CO1hF7ZgFV1WMpjCkVprUXhtEwNc5B68/
	 THUpft8TsCVVV6fVyGv44Ebt4IIgONWdxdj7pnuDcvB40F88fBazh7AaVbIMisE55p
	 G1Ikusj5ujlnWP5FodIxtIECMI1iE5iwbxFDlNGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfIPVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbfIPVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:12 -0400
Subject: Re: [GIT PULL] SPI updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669711;
        bh=C/6PseyECzjiJ1b8hqViZjWGUKqI7ydDja4Ogyl6Vbw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aP35W/PHQ6Tu628TrZs8H0ef9G5pqvl0Hh+OVEIQPfmCSCbroAaRF1JccAE00hGYT
         Tvd1CnrjwZRslQImkrhAff+aWwo1OhSBmZ//TD+M8/lo8NxmpeR1HLB6DdLcTXXbH/
         OsTsqd5xcZJY4I/EaZyhXMIH7lEqttrXFsJxljR8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190915231811.GQ4352@sirena.co.uk>
References: <20190915231811.GQ4352@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190915231811.GQ4352@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.4
X-PR-Tracked-Commit-Id: b769c5ba8aedc395ed04abe6db84a556d28beec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa62325dc38de2be8b1c27eb180ad3751b3f58ec
Message-Id: <156866971191.13102.14352639353908386650.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 00:18:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa62325dc38de2be8b1c27eb180ad3751b3f58ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
