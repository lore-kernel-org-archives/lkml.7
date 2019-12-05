Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA37DC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44E24678
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575578731;
	bh=03Fu5fYuvqvbhxsml0+DONIAkc1U6XblV9t9frUBEfw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EwabyyKd3sPcY8QjZr+QlpjNTWgl4WKnCpYn69d5okfcY6DxGHM+nP+n3uA6ssmIx
	 MFgJ/13PmuDwfF3rc/l0kOoZIM3/tYEDsnb/jWR4jtwXS/Iq7zsc01VocGQc9RSoGK
	 97AHZPu2B89BG9OqLxNaMFznPinqVWzC7Dtg4CB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfLEUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfLEUp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:28 -0500
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578727;
        bh=03Fu5fYuvqvbhxsml0+DONIAkc1U6XblV9t9frUBEfw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FMfDN/RxzAOYr8tz+UGqAPJwzIVCTogL4i4Qj0VB1ipXYY2nc7Hk9psP0rgh/KLyU
         g17U5rKDVlKeqrwtMdTwW6gof19agEGaT7nzrPkPyfhXQgZ9KCl7EAi3psiMf76SJq
         NuSbraKP+/elg/XB20qoc/4GdBeTcVZE6cA12Dg4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205180453.14056-1-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205180453.14056-1-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: ab818f0999dc73af3f966194d087e9f6650f939f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6
Message-Id: <157557872789.26858.3675924643438407119.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:27 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 10:04:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38206c24ab09b4f4c2a57de5c1af0bb2e69cf5b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
