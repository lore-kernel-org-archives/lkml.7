Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45224C282E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EA621851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558734619;
	bh=Spu67w/gP3+ms2BlsOe2fVnV1Tq87bPWCS+w9oDOglg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uy/p10OCNVMM8EEIumN/Ecvv5PQG9NvJZZDC2SESvf+EWP9XK3z4En3oz43b9lXuR
	 hRclix39GnZoy6lokBnKa+gYuCQIJ/P6h4Ct4z5XURs0V/eqv1DLpWqPX1+UD/VX4Y
	 QRhcIXE23+K2WEokvlJpbo8h8sdrsm78wlhyjeKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404340AbfEXVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:50:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404313AbfEXVuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:50:18 -0400
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558734617;
        bh=Spu67w/gP3+ms2BlsOe2fVnV1Tq87bPWCS+w9oDOglg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a1L2HWpS4I2t/lzZkOhEL9wBecJPwSTM5hmjkonHJ2WnOJitxGh/ovWzSeDFrSUYa
         5tmaphw5cXVl5wGoEeE07x7E6qQhE0KM7mjWfYZasjGnnisYDpoRBXS+qsyoS5mEt6
         RiOxSGuwihMuSwtZoJWv8SxE3gDG5DvOHyrHXwDY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524180233.GA28288@kroah.com>
References: <20190524180233.GA28288@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524180233.GA28288@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/spdx-5.2-rc2-2
X-PR-Tracked-Commit-Id: 060358de993f24562e884e265c4c57864a3a4141
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86c2f5d653058798703549e1be39a819fcac0d5d
Message-Id: <155873461746.25303.398025531969308932.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 21:50:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 20:02:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86c2f5d653058798703549e1be39a819fcac0d5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
