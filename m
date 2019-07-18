Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F7AC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012BC2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563468621;
	bh=YmJhX/tMxM3yDYef/MStj63pU5kcSA7S06sIfI4oBP0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2LX1tBVUpZttwg7mUDCme4yzkoy7T+Fw6h/oFNId0lwh6Wj0HSZH82lwsgDOEBv6X
	 T6T6pWPi7ilMYV6Vbdm4CcFUH8A1+TlShtFw60S8gOPifcEwwwJ3yYR48hghpIkKLM
	 WS195Sxq64iPk9xqtR9vPeMv4xw0QOixW0CeLpVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfGRQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390323AbfGRQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:50:18 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563468617;
        bh=YmJhX/tMxM3yDYef/MStj63pU5kcSA7S06sIfI4oBP0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OvhGCLeBaiNncrrQsyRFnW5WEGcdX1Vsih2aR+0iWnnthoA9G9vwU7c0BUYP00IiD
         dAtuT+t+jOc+OXyt1gauqa+glfxGlGN6+S04Zjsq1yV5R262A30TkISwyOixu+FFzX
         VLT1BfX3A3NPtGyxDRhIEFX0N4bFm41Ayg/jCi28=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblxrpsl7.wl-tiwai@suse.de>
References: <s5hblxrpsl7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblxrpsl7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.3-rc1
X-PR-Tracked-Commit-Id: 4914da2fb0c89205790503f20dfdde854f3afdd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ae048e16636afd7521270acacb08d9c42fd23f0
Message-Id: <156346861733.19804.1983223122027489541.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 16:50:17 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 12:03:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ae048e16636afd7521270acacb08d9c42fd23f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
