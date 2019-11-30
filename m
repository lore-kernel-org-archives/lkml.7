Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA92084E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575139216;
	bh=HNyvNjPP8I7M7Zzgdj8BUUs4Bi4yHGX2THFPNKA6RUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=awBaCEl54QTZJWejaCSYdRx24anXfkY3P9Z1iCIx//FD/pmpBBb2nd7Aud3y1PQyQ
	 ay/QYCS4BFwNcsxxyC8EoxfFU0WEPyfbuLw5ns3WxB/KewJgnb00UK4GRUPJ7F78yD
	 PD01wF295NfTjtbTtIRHWOxUUKDZ58TenFONC9rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfK3SkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfK3SkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:40:15 -0500
Subject: Re: [git pull] mm + drm vmwgfx coherent
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575139214;
        bh=HNyvNjPP8I7M7Zzgdj8BUUs4Bi4yHGX2THFPNKA6RUg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S/ACLge4+Q11OtN9Gnu7hsqxo9Pw7vSsOLKHVuSzy+IM98LGKJlCPVnM/FGKJ2uF3
         Zls+4564gGkoeJ3lOGgPVSxVhuffjdL7JQToCl+zsheevyPHAE1HerreCUB/GfFWcv
         uQFmZj6z73c+HVUVF3+qekENpQQ0nakmP8BN6V/E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
References: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txVpjxR1UAOPpXn-ZqMamAUdzfq_HOEav99A0A0sfFBUw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-vmwgfx-coherent-2019-11-29
X-PR-Tracked-Commit-Id: 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5bb349dbbe27537e90a03b9597deeb07723a86d
Message-Id: <157513921458.25154.3957731534983081875.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 18:40:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 11:15:13 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-vmwgfx-coherent-2019-11-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5bb349dbbe27537e90a03b9597deeb07723a86d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
