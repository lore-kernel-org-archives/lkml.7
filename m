Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA2AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991D6206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567718122;
	bh=PKEnLntocNbyXP/dyHSTSAKjREdQCTKrP5cSIRS53rM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Gk4Bw6BJb+DmlDLnbtuLilql0ed1n1i+NaDdYyM97mX4vPciq6UbWD7iZVh92nyZk
	 79c3AiRH9W3D6rgmZcpzxsZBUnEYtaa3aEh8R+YDalEvelfTzrlcROcwJQ2R5TE787
	 DV6vOL1t3uctG0ueYoc8JqaS/oBoazRbXm/xFgWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbfIEVPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 17:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfIEVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:06 -0400
Subject: Re: [GIT PULL] clang-format for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567718106;
        bh=PKEnLntocNbyXP/dyHSTSAKjREdQCTKrP5cSIRS53rM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CJiWqQXctnnM8Ym150/YD8UIpO8Or/CTxFcPvqqEiwOnK4Yt6ucgudOu95M0LlRbX
         Fhgmh18Af4fuQu1VBBryK0mQa/lzZvD9sTUkkxHGJszQSJbRSnDWNS5jRV02X+SCCK
         z+bctJhPIB7hbpVvO37klqIDbLBsO13AMEFrWzO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190904182949.GA22025@gmail.com>
References: <20190904182949.GA22025@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190904182949.GA22025@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.3-rc8
X-PR-Tracked-Commit-Id: 52d083472e0b64d1da5b6469ed3defb1ddc45929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13133f933ac463f233fbf118061c4c47cd72eecf
Message-Id: <156771810610.8025.1118786210637246111.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Sep 2019 21:15:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 Sep 2019 20:29:49 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13133f933ac463f233fbf118061c4c47cd72eecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
