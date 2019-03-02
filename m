Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B15FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B502083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551486021;
	bh=1v7JwTDhFErcdUbXUSacRBTuWy9JRRNtT48RmZYe66w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fXDwTDjXQtlsTVKfagJnsyz8js2te7GzfRy61Sz+gWKIZngDApbFG69d/FyiKpD7y
	 SabKKDehfPwcuTDji2IKPaJX3SRMVApKCvVcHBtCja0PahBt/ebj3rL5lO9OQfULVm
	 q5KsLXigjyLXBTKT1bov3VbJyDeT0/MSsZRpdrjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCBAUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfCBAUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:20:04 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.0-rc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551486003;
        bh=1v7JwTDhFErcdUbXUSacRBTuWy9JRRNtT48RmZYe66w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TITqvV7V1OADbh6M6bpc3hgBGz5v/Z3vpBnykfNlAedH4ex6KjtoOsruoOiQp/YSJ
         iMZkOB+rM6IcCQDJ9o3mnnizdFoI7e/l5DWpPNb749R3Ljd8jKqOGilHnuqkYgqM48
         hXYQAwC/e0l1rfkQsWBljTZBlQEFMmo/jr7ApVZU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190228142239.4078-1-ulf.hansson@linaro.org>
References: <20190228142239.4078-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190228142239.4078-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc8
X-PR-Tracked-Commit-Id: e30be063d6dbcc0f18b1eb25fa709fdef89201fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a8ed368fc8544d002129d919cf651accf43582c
Message-Id: <155148600359.30240.8711133847178164835.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 00:20:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Feb 2019 15:22:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a8ed368fc8544d002129d919cf651accf43582c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
