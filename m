Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DDDC4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3F421855
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568766920;
	bh=231tSAJpuA2jpDPF/dmFnuyIOzadfVzwTqHEgrCMei4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u0u7egt+tsX+PNyXhZJHsmDdSul78nazBULZkNd186efWkzey3Y0EmuU1ERBIIpuQ
	 4YFi55QE4lAlTbo19guOFT4SWu5egcQ9mf5cNS5P5ezN1LJdowgY4FyapcLndbklVp
	 nYfSBVUxy5CgYTrO6rsq9gjL7fDRKMYUpCQptnn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfIRAfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbfIRAfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:35:19 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766919;
        bh=231tSAJpuA2jpDPF/dmFnuyIOzadfVzwTqHEgrCMei4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K04oOZCh4OC4BxH9GPqbbHPCsB3dC6KB11g7fFZ1fHN0IQCFkir0wbOw/uyteHu2R
         PoIVWGv9d6bWx+rNvLHtzecEaeSqP+GOiBW9DnF+EdyioGtj+TWHFi23uVXNwLODa2
         e+BdsSd+2RvVGpS0ZPVxft4Pg+RteZKnbTkhB6jM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917090912.6758-1-ulf.hansson@linaro.org>
References: <20190917090912.6758-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917090912.6758-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4
X-PR-Tracked-Commit-Id: b46119796721301e410a357b91195eed46980ea6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea982ba7f79141d86eb7a440fcba6796ed718b9b
Message-Id: <156876691917.9665.10106888397011727842.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:35:19 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 11:09:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea982ba7f79141d86eb7a440fcba6796ed718b9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
