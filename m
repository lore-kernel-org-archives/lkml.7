Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A1C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F5217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557435015;
	bh=d8maCT/5A70Ed6mv/6kwMkpZF+XVKZ2zLQ4NIDlMfXY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2WojJChIU2o0b8gdedNomlasMK5cWNZhQ1KtMjj2kjnDG1AkDybGchOMVw1mUSLnH
	 7EQyfkVMtlHjM/7b/I7XA7hkPSR/VxoiYxRHBNLvdnZvUewatE/Bs/pbL2aMmtk375
	 Tv75qpdVlOYCiAND2KOX1egBQOzlu4yo0J0E+7oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEIUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfEIUuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:50:13 -0400
Subject: Re: [GIT PULL] csky perf unwind libdw patch for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557435013;
        bh=d8maCT/5A70Ed6mv/6kwMkpZF+XVKZ2zLQ4NIDlMfXY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hmr+T9LOPNzmm08lEI3TyKX7J1Rkz+CcsVXzsOqwnrpv/DfKMdNN5LAxNc7eCp2bh
         kqFvWJBCdTaxbHMauGXSfP+YJnr1/GNMVUR2Z7zhhyKCBCTQWODxH/ZkHYFS3inrlM
         y0bQVmLQZf/kBpy5EtvspUY6Zko2Xollc38x4XYI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1557406433-28868-1-git-send-email-guoren@kernel.org>
References: <1557406433-28868-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1557406433-28868-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.2-perf-unwind-libdw
X-PR-Tracked-Commit-Id: 3213486f2e442831e324cc6201a2f9e924ecc235
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1e76c3d3a774298475622bde63010972c9515a1
Message-Id: <155743501323.12157.12846102624780100793.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 20:50:13 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  9 May 2019 20:53:53 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-perf-unwind-libdw

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1e76c3d3a774298475622bde63010972c9515a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
