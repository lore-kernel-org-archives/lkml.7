Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1144FC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC4421927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576940123;
	bh=vRI5cb79SKWBsPZ7gdqzulQFP3uucn9J4Oh57uvAuRU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ltWArQ7PqffPdec5LgC8W2px0+j2IojhDg5hOAX/tu/+ef88cTCa1fuGFd4tUbnxO
	 9GjGrUFepYJXu7FfGTZ3XzKQGkn1FSZjj3bkz651wt/f+X6IB7yovAO/iWVPR1+fed
	 vQTLzHDqVv7WIq7wA2rkobDvr44xJflv0MROTyWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLUOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfLUOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:10 -0500
Subject: Re: [GIT PULL] clk fixes for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940109;
        bh=vRI5cb79SKWBsPZ7gdqzulQFP3uucn9J4Oh57uvAuRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=057pf5fIJn0fyXesbPN3MNA3rAAnkuLJPtQ2fgAcdTTdtna5bhR6J2Q4JDAgsQIcI
         fOqsJXpn9ABcNjjGYskTC9nHA+q4eY3D4F+TovA8+tuR59lizRukNx1miJNQwrVa1A
         mgNOdWxgHzxGWLM19M/uVp4GnZHiiCEe6xoGjKQ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221040950.59130-1-sboyd@kernel.org>
References: <20191221040950.59130-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221040950.59130-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 781d8cea68ac41d11a80df2a5f5babd584f86447
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12ac9a08fc4cb240a28e6690dec016abd298e52f
Message-Id: <157694010990.20544.639890836279380592.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:09 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 20:09:50 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12ac9a08fc4cb240a28e6690dec016abd298e52f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
