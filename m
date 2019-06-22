Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC197C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8CC2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561244706;
	bh=7QUak2VryUzJwlPALMoUzkXCarUVSfSF93ogRPYy7Rw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vUOri0J9scEIgLRQDlZlJFbp1P3lYfAQABbFVurw2sLCMbZMnLbYWEW843lEEcVBg
	 ibv1vY/uyh0SKOpzUU39LMRifc1xXS1I+GMO0YN7yDCLxt9RsbRgYvyv0+EPQT8Tcp
	 ua14zjxon6GP1gtZhS5bTzdKvegb0J8O/vPvFF1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfFVXFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfFVXFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:05:05 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561244704;
        bh=7QUak2VryUzJwlPALMoUzkXCarUVSfSF93ogRPYy7Rw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G7z8ii+ZisH9XgKUpYJfVPRw5IkNG/61M7CIvWj85/D4T8f59zeVh5jRguBtaTHOF
         L5wlNVE5NiiU6RVKS/7w3LUf33OPK4Ru/lknH7a7svM2V1NqCD4lL9Irwf2/SFQcTD
         9I4AJq6PvfVvK41ZhRJc1jaFjmWvYaxESPgK2W8Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190622194641.GA5200@8bytes.org>
References: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190622194641.GA5200@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fix-v5.2-rc5
X-PR-Tracked-Commit-Id: 0aafc8ae665f89b9031a914f80f5e58825b33021
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6698a71a1e360d89514aafcea15ccff837f59038
Message-Id: <156124470420.733.3742446385319983333.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jun 2019 23:05:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Jun 2019 21:46:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6698a71a1e360d89514aafcea15ccff837f59038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
