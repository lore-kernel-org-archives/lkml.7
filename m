Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96320C41514
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AD4214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368521;
	bh=419T7J4k04LmxtI6IPhOmUj3dbhoV69tdbHRuMz03Jg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2dbfDf/1i5Big7eeOSgfUexYKfh/2Dqa/9pnYBg6N0Su62CvK46sXzNeFZtM+mf5/
	 VMkiDmcRuIKGzVYLRskQWq2S6Lhb/qQovITljRX86unNEoVGVp5U5w5z+b5lk9Emsn
	 bbIEJbIeJ9OXfrMZcRsTt/1NqqtzQCYA+2tEyyoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437390AbfHIQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437343AbfHIQfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:12 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368511;
        bh=419T7J4k04LmxtI6IPhOmUj3dbhoV69tdbHRuMz03Jg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jx6W+d++wIGb0nsUYq8WVk8lkMQ7Js5/BGWkyHBDFnJZtmxdiMHT6/SzKIHkIw5t6
         pTXJlwDfShFJ1OcP8fdddiLbkBEGSU9sgYZGIJPP/SstGpWPD4Cxg+RxTYq5sAGM/Q
         ai/rU/rczTpIzp7b+Jj8cAw8pLfEvPZs1D6n70uE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190809161513.GA42536@arrakis.emea.arm.com>
References: <20190809161513.GA42536@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190809161513.GA42536@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 30e235389faadb9e3d918887b1f126155d7d761d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15a555a4b8be26683d77df8d5dbe8ac83f5ec3a6
Message-Id: <156536851143.6429.291425612357631279.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:11 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 17:15:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15a555a4b8be26683d77df8d5dbe8ac83f5ec3a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
