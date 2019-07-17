Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BCC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F9820651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563383723;
	bh=9eKisB7XAqWFXO8QcVdj5/0ZVeCKZWliV+leI9sgv4E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hx5vImIXbCQ1xp5+ERw5HVYVJ/cjCumKL0LTasoJ/yjDMZ1Q0MLWZq1xc/nf6nVH1
	 d6uyByam1z2xHBhbVyt0eDwH0FC0T8K+E+jKvVMGRrAQAYxX0xQ1/5D78tI7VWzu9M
	 ha8U+WDc5wJVscEqLUM9btwCRUXju5aHkE2qIJxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfGQRPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387720AbfGQRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:15:20 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563383720;
        bh=9eKisB7XAqWFXO8QcVdj5/0ZVeCKZWliV+leI9sgv4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xm9lKudUhmbgJFJWQwt3hsKtXOSXk//0f+wJzXZCiQic2OMdadKffRIb2Xji7qi+/
         PSRuqmouwC0ltneiapMR8puSOJV0QggvRXGeMy2SQRSb4lKJu1NLEOFADcn9q+Ect2
         Zc58hup7M6zXQTBU3HejLlzQVgCle/QOCM6inCmo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716171515.62403-1-sboyd@kernel.org>
References: <20190716171515.62403-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716171515.62403-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: b1511f7a48c3ab28ae10b7ea1e9eae1481525bbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 916f562fb28a49457d3d99d156ca415b50d6750e
Message-Id: <156338372008.30487.9417100326122078190.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 17:15:20 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 10:15:15 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/916f562fb28a49457d3d99d156ca415b50d6750e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
