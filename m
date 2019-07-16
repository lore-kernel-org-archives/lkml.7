Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76510C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CB20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563298520;
	bh=Sw6G1ZnosnI0CUcwosNoY9FjLHgWm8eQtW+B36A7SX8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XkDfum1mXLqskpMgnr4MvQR/ek25xR5SsnpmiiqoeT6Qc95kZ28pdMGewKhZuL1DZ
	 Fmoa9VEEWgNW5Y9vVqitvOGwkwfyBQ9v8L2ga6YY3DBibxJoCPPpwjepA4IYDvi5pd
	 dPHLIs+lj60hWFeIm+Aw01tw0SPuYdNdDIij76Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfGPRfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPRfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:35:18 -0400
Subject: Re: [GIT PULL] Backlight for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563298518;
        bh=Sw6G1ZnosnI0CUcwosNoY9FjLHgWm8eQtW+B36A7SX8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zfPvFujcMCFsba0d0hCPafSEHYW+5eMssvfvVocwx+cSrDPH+NaBgDJqD1Nc7pym2
         XvSFihEQN6e2zKFbbEu0uu8eKtVedPYzcWoPLj8x5WayEmMPjMp0znhiJOParrGarF
         TueaXlkhoz4EDNb9eNbHOkqYja5YA5gCS9Wlt2PU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715080009.GD4401@dell>
References: <20190715080009.GD4401@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715080009.GD4401@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 backlight-next-5.3
X-PR-Tracked-Commit-Id: 73fbfc499448455f1e1c77717040e09e25f1d976
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50950626414a982c8ed539128c7f69a3d328a970
Message-Id: <156329851813.6656.3301753205079827662.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 17:35:18 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 09:00:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50950626414a982c8ed539128c7f69a3d328a970

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
