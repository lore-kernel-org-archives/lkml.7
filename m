Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916CBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D20206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576617315;
	bh=MS1zmuUvVlmqtq6FvDvYIY6IIhJBwPhbK+u7q6QgZRU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XbDR+bW3NKkIS3NU2/YbtIhnV/Y7/OBtvKxxUXIi63YZaR1G2+q4v7E/4Pmlxwlqq
	 9QmiS1bh/T1ik7yrTBJYOj4D3GuIbcmJf/YnbysPf5GOK/yQYq46VSkG+q9/M0TIws
	 kofmg12ciueYCZayI9B3H6tjZJheVNfBZUs4XjxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfLQVPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfLQVPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:14 -0500
Subject: Re: [GIT PULL] SPI fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576617313;
        bh=MS1zmuUvVlmqtq6FvDvYIY6IIhJBwPhbK+u7q6QgZRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yiDa7hDAOK16z4g80r2LuO0t2gds6JbG9hsV+oTqrf3cWgds0SN456s7x8IaqCZbM
         WvvtFSUBSOKAAB52FufdzkGK37nndBghQStOh/TbsVSZ+zvuDGrF5tmBPOcLLg2P+L
         BEXm5Q5T+SzBj9O+rVTL73ZCKENWV27J/Pwbw1h4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217121932.GD4755@sirena.org.uk>
References: <20191217121932.GD4755@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217121932.GD4755@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.5-rc2
X-PR-Tracked-Commit-Id: 63aa6a692595d47a0785297b481072086b9272d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a922f1a9aec1102a94505622290c0ecf4ef79cec
Message-Id: <157661731374.2643.8035727650650933097.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 21:15:13 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:19:32 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a922f1a9aec1102a94505622290c0ecf4ef79cec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
