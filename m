Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE6218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575255029;
	bh=1NEFka9hmnXxHttmZxWYuxv559QWcB3UM6F2sez2fkA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=05a5LvyGApLLU1A97QPiMKPMYivpArt68I6rUvk8GG94+hDQnjl4vxS4jNPxwPE7D
	 fH+97dJbkF62OkbHmICdZ3q1biIb4sk2r9RnY2e8kUBIs8A/1AyN/5ghXWYIXXuIGc
	 jPO2IoG77KQZDj5PPbwY2AwVnYtnD7mxQaZVlm3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLBCu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfLBCuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:50:24 -0500
Subject: Re: [GIT PULL] rpmsg updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575255024;
        bh=1NEFka9hmnXxHttmZxWYuxv559QWcB3UM6F2sez2fkA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F50MBVm790SUKMW/xI0r0nlWwtX9PXbdm7ulvKXviLUpkCjaKpcQ/zkwhmsAmCDIG
         KY/18f9jRBUk9F36E4RV2gbkNDqOLo7oRD17sZ2VE00Eyh3aQgKqpF9CGFgyaWQgt2
         qDioLM7YB1uud5vF2WhxwCfSAIMDz7O0CyjWcLmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130191423.GB151303@yoga>
References: <20191130191423.GB151303@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130191423.GB151303@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rpmsg-v5.5
X-PR-Tracked-Commit-Id: 8cf9b615653e40debdcf3b6f1d69e6b580d71173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 687fcad8a3ab95f228e62a58b03eb10af67146f4
Message-Id: <157525502401.1709.6584412870186406628.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 02:50:24 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 11:14:23 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/687fcad8a3ab95f228e62a58b03eb10af67146f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
