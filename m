Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD742C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33C721734
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559062217;
	bh=yryTIORFujiT7sUdeULow+fh1QkMuOSIn4FJCcW+f+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ce3w4ajEk9l7t+yR6USqZ3lt9bmbju5hyca0A9sW7nhbUJeOID5YMSVGd/jnJJSR8
	 J4Iv0v/YKug46ZtMzdofZe75uo8c2enW+IjHYURRKJsX96r1HJR1AA7of60NfgdeHX
	 UZnwsMtd/GFBiw25ocDXj7HHiOZqXhbK4YthvsYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfE1QuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE1QuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:50:16 -0400
Subject: Re: [GIT PULL] pin control fixes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559062215;
        bh=yryTIORFujiT7sUdeULow+fh1QkMuOSIn4FJCcW+f+4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EKyUNjZenWur8Q2i34rbCenoDn76B5lWYh93enek/THQsKCdIPqIoelv2Yf7Cc2dp
         NAh5gVuAA6JpHG/0EuvLxoRRj2Z/i5El8EFlDG2fbTZNLq1xaLM7B+YWoZ2BqZjkcH
         p0/+8MuEwajigkpEM5dbP/R22nYzkAdi9AvdhxwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
References: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.2-2
X-PR-Tracked-Commit-Id: b1fa7d8592c730d1b44536b5cacadeb318d369fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb67d643f6f1892a08ee3a04ea54022d1060bb0
Message-Id: <155906221546.16286.17261469406240264372.pr-tracker-bot@kernel.org>
Date:   Tue, 28 May 2019 16:50:15 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 May 2019 10:43:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb67d643f6f1892a08ee3a04ea54022d1060bb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
