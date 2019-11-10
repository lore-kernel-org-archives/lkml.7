Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC8EC17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1FF20854
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419607;
	bh=Xk3WT20CsVuh7QEQra/eW3izM4oboWFHOOLLE/rHIRQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ONbPp68SfalPBTLxPJGfhcmUC9OjG8sb2kdvvY1YyUipxNkU/xA9C7eYD+yWE5nE+
	 9GwLmjpRb6JwqEyGKhxz19SmPDAR6S9zEq7Sl9QDP/OklPmmrfe6DuBnG38qzWH0lZ
	 HVflHtAnm5aziNjdOPuqsqgxP/csrOoJcWW0a2+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKJVAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJVAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:06 -0500
Subject: Re: [GIT PULL] pin control fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419605;
        bh=Xk3WT20CsVuh7QEQra/eW3izM4oboWFHOOLLE/rHIRQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VtOtGqFCjg5oLSjtiO2tz+K3hdnvVLZqvh1/fq6tA3GH0aMcLmMCE/tFuOgss6p/t
         rjNorkxiPupwKJHHd+RHAU9qCcSWGCOpiypGfwYPLWUvhqQUE0W+4BQFA/LNskLBdU
         I1xiiZBeEq5bTHebL+GpCecwfso0XLh9LmhcmxpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaomX3PGdf9LPvi+S2yzTCs0f-G+TJkdfo=5HcoOJjehg@mail.gmail.com>
References: <CACRpkdaomX3PGdf9LPvi+S2yzTCs0f-G+TJkdfo=5HcoOJjehg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaomX3PGdf9LPvi+S2yzTCs0f-G+TJkdfo=5HcoOJjehg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.4-3
X-PR-Tracked-Commit-Id: 63e006c107ff4235d2a8fd52704f283d23642537
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4763c0894a2b65f7ff97b3baa368246bb3ba2480
Message-Id: <157341960581.30887.5396540832488302889.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:05 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 01:26:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4763c0894a2b65f7ff97b3baa368246bb3ba2480

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
