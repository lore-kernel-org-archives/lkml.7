Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383C5CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F47B2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571418313;
	bh=mJurhGNBf4zRziLgw92gIvSO9ESGtwPa0UPqasQpgSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mjWqnOo2mfoC//G76U3W1+ZfXyR53VXq3bcgZTbAIaPD9OeaCg5EH7qvzgnuvLWM+
	 t8F3ZW/erBS2c6TuHN3fJD09NTpY+e/cWAp6XXN/FE7bnUx71cfUQ6zHNbVoLRxDZr
	 9f/XJ0xQJC0bMBKaX9A7P6+KanCREiwOsgnSphS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505236AbfJRRFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408573AbfJRRFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:05:05 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571418305;
        bh=mJurhGNBf4zRziLgw92gIvSO9ESGtwPa0UPqasQpgSI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=daYMU+06kQue0pkp2OMD5XNHCX8wRMd2CLLEBmA3cH7BxiYSCvMUzW0Wzk5KKooqI
         DFesVL3xEQkTvu7h0vXMIS5dlPKNB5LEDDENVAjDr8po5njOw/xrhKWk34x1ypySDd
         h2LVBF2mwt8kcW1TI+2hu+GMeHkpygANp0KYf0hc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191018100814.5265-1-ulf.hansson@linaro.org>
References: <20191018100814.5265-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191018100814.5265-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc1
X-PR-Tracked-Commit-Id: 28c9fac09ab0147158db0baeec630407a5e9b892
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7571438a4868e7cb09d698ab52e54f9722020eef
Message-Id: <157141830546.1926.13182537401302216866.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 17:05:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 12:08:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7571438a4868e7cb09d698ab52e54f9722020eef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
