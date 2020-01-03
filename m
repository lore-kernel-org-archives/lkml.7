Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF71C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07E4215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578079520;
	bh=lx1bfBQGzFpSyQGdwAcBBNmZ/I2xtfwj30gPs7sNi3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KqqIGaAVC4KUAY2foVHK2d2prCUKeZ3orilh86DR+glClflYLrlpkj0y2O0S4XWDI
	 G/yXrSz40mjxon8IarvXHLKqtaW34VL+ebj6HGYChnr1RatsKqqHa+HjAwliAt2rpM
	 zAtU7OrONJfIeT2n8xnnNX7YCoZNV2Tcohk/gSQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgACTZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgACTZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:09 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079509;
        bh=lx1bfBQGzFpSyQGdwAcBBNmZ/I2xtfwj30gPs7sNi3s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=imTkYoDNvtbzNEKuWpBMTGUjZ9iHf7mFXVD29edl6Ms3ZfP0+qrFpk/cThe4l7a55
         XhzYPLhcCQ1UzjzYG4HtH23OjHRXGOlU+qopez+DgbBp8wkYOWsFAiixe0TLO4Fgx0
         uBi22JprNgCPXQVfbFnRi7IOAZnq6ZTkIA1WwgmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATRUHZSvrhzm8MkGhHO1G4L=ZbTjo+8m4tmXSZcEE_8bg@mail.gmail.com>
References: <CAK7LNATRUHZSvrhzm8MkGhHO1G4L=ZbTjo+8m4tmXSZcEE_8bg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATRUHZSvrhzm8MkGhHO1G4L=ZbTjo+8m4tmXSZcEE_8bg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.5-2
X-PR-Tracked-Commit-Id: 8ffdc54b6f4cd718a45802e645bb853e3a46a078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed723519a72c0f68fbfaf68ed5bf55d04e46566
Message-Id: <157807950938.16643.2435758738520592275.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:09 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jan 2020 00:09:02 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed723519a72c0f68fbfaf68ed5bf55d04e46566

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
