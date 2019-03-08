Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF32C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803B9208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070142;
	bh=e6m8P3xt63CoiwNeKsGfanmEcxKcHwJXaD4Kt9ipiXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fokUVB9mAQGPn2yURLG+hCaMdDHU79szJd2cy3fbP1qBUm93sP0Xkchq2y1VmpJ4a
	 CPBF87NGcBsXGCfnD+EyKP6WbB4RBcaWcF2DI1GG75x2VWEcpkdLYXMfHFneOjCNjk
	 2tklO2gFBsNZMXUv9+xpDYJTddrMrX7ISEThNdYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfCHSfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfCHSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:24 -0500
Subject: Re: [PULL REQUEST] i2c for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070124;
        bh=e6m8P3xt63CoiwNeKsGfanmEcxKcHwJXaD4Kt9ipiXM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zy5OB/khxgae/pzJIyDG0oD3Rg5vWuDELXX9aqEEXtC+C0vGD0wLeTUl3Xfh1moEi
         1K7xkpiP6xWaRHiFUThCzRGvKlCPACmaBZfywtPQ7bjepCtLoyanqAsFwzsoD8KuS2
         pFfJb1S6hEyAiojF9TRVPfNWRSRVSrtJoa32El00=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305225407.GA16211@kunai>
References: <20190305225407.GA16211@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305225407.GA16211@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.1
X-PR-Tracked-Commit-Id: 93b6604c5a669d84e45fe5129294875bf82eb1ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c3f98faddc7f07981c5365ba2f45905ad75fcaa
Message-Id: <155207012437.7904.14852467995987509876.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:24 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 23:54:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c3f98faddc7f07981c5365ba2f45905ad75fcaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
