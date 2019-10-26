Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2421D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572122708;
	bh=umG20ABRJsxkRhhQ91mmYdVIBHy/04I+j7usqg0HtLI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N6+r4Q2ZP3Ues9XUWzs3w4PIovbs01dhexkKfptSx7ZrHl1E/zbk4oeZ7WX/NdLOB
	 G3IW3kalZfJ6sT7HW7JoxgoufuPSkUMPSJi3WB1WV808bFYoRvgzYSu/JpWvv7qjSA
	 KSBLNh1jjMOHCaRvGRfgbE3wpLycSnVc4VMZ+ORs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJZUpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfJZUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:06 -0400
Subject: Re: [PULL REQUEST] i2c for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122705;
        bh=umG20ABRJsxkRhhQ91mmYdVIBHy/04I+j7usqg0HtLI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jiAOno5vVMrSzwIiUo8vKAi8mcgbqBwL8BIaUTSLXEbfdl/ySGPx/bqTi/Pn7564N
         lsmHDoy8YS0ZvwybM2000wg6hGySKnm6iTItWF1DOSXUkl2X8G4+hF2wWQv9Guju3r
         fmq//9Kd4h1JRIfWG0RhiyjgS7JRActBKes+10lI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026143655.GA5216@kunai>
References: <20191026143655.GA5216@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026143655.GA5216@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: 348e46fbb4cdb2aead79aee1fd8bb25ec5fd25db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 992cb107e1ac8442ca00a42d452ade2e7dfb44ff
Message-Id: <157212270587.6077.8761381131706441289.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:05 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 16:36:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/992cb107e1ac8442ca00a42d452ade2e7dfb44ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
