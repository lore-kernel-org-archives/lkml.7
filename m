Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4A4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F622070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179133;
	bh=dnwM7XjZooR/q4G7qPNF5DV2oKs3nqYWtd6hsHVT8QU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YG/K9lI23nw7jFxhIhp7JDKCpV+zW+cJ4aCB3iyejTgDzxQcoTyVt2Yokl7evJHe9
	 XdHdrvV+uE29ioxJgtjOell9hhJycORay3GENFARv3BbSv9YuqhGigBn2m/k9Tq0DJ
	 0TwVhXnN2CsZpm049wHi3X8Djl9YSOFEpAozXOfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfIVTFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbfIVTF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:05:28 -0400
Subject: Re: [GIT PULL] rpmsg updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569179128;
        bh=dnwM7XjZooR/q4G7qPNF5DV2oKs3nqYWtd6hsHVT8QU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0044Yp1HFI0mc1GAZEqH7sOQeE1n1xC0k96T6c2oleFfaijqYlAsw9F1szpGE10yj
         d7JHSznKOcFxGJHd2hFB8JYlibw52kkb7rZECTgn1LD7I9BoE+SUc9+uS0IVoxTx9k
         CS7SHwQngIaZZ0NuQA2jdkGiuCVn5QoywY2C1Hco=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190921165912.GB6693@tuxbook-pro>
References: <20190921165912.GB6693@tuxbook-pro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190921165912.GB6693@tuxbook-pro>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc
 tags/rpmsg-v5.4
X-PR-Tracked-Commit-Id: 9fe69a725e238ac279027f0132e50617a63b847d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 379bb045171dea3e2ee01b32fe88f2afe1fe2fa8
Message-Id: <156917912820.24588.8130624863228290812.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 19:05:28 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Sep 2019 09:59:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc tags/rpmsg-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/379bb045171dea3e2ee01b32fe88f2afe1fe2fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
