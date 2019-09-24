Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7513C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90820673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569293126;
	bh=vvGQZszQA5AWTrwpasObgM6vqCA99hYVhPVIuBZkIuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=scQVu6NcC7fJDN4V88hR//a6jlcru5NcDj3GgCv+zi4FJOzrJRrS17Y8WFo5Bgm1G
	 +5B+W4ggXGPbfkZBFpeo77DUsMcHv2OJh0w24Ip7tUYKg2mEVo5fusgV9H5zqizzGs
	 65QMYbRURf56WAfCmS5N+x5cNf9IakBU9QHZB/iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394408AbfIXCpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:45:25 -0400
Subject: Re: [GIT PULL] Backlight for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569293124;
        bh=vvGQZszQA5AWTrwpasObgM6vqCA99hYVhPVIuBZkIuM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q0jkB7N8AkiuxKhCLoyhpcuT6WzyG3CipPTWRHXA+lwe+9mlSI+rbOxvfwke/BRSZ
         powrzjNlRQFlvKdQzCrEBd70aQB9McYzKE187lIyfoeeaE/RE34FPe/hu+KuM6CMrR
         NHo/0npGeLlwtRCCx+QPmxvfUeINJCP+dTwziRm0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923230554.GA4469@dell>
References: <20190923230554.GA4469@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923230554.GA4469@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.4
X-PR-Tracked-Commit-Id: c0b64faf0fe6ca2574a00faed1ae833130db4e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0b3cfee333eb7eecb6ce72f06f5a02d249b9bdf
Message-Id: <156929312450.18533.12664240217150168697.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 02:45:24 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 00:05:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0b3cfee333eb7eecb6ce72f06f5a02d249b9bdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
