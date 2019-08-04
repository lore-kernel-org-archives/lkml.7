Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1648DC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 23:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96E217D9
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564962312;
	bh=qv/lWZrl1Q5IsRPZpWPmFdP9Rf9bJ+WFUfQfHmBjajY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=USqiv2HcxQtkYkHrGDVAkiXVOfoYYHmroLf6PU3rfGbFClBGM8uXfdNwbjIcfwIrY
	 FWnaGj5hId5OWIIc1e8cX0kFs6Be3lfekeRf+eKAPuuCVV6a8c5BJ6P6WDGs9Cm0aw
	 K5Zm4C1VfkG+P2PvFh8a8DNJXXYNoHxJnpzgeJPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfHDXpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 19:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfHDXpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 19:45:11 -0400
Subject: Re: [GIT PULL] mtd: Fixes for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564962310;
        bh=qv/lWZrl1Q5IsRPZpWPmFdP9Rf9bJ+WFUfQfHmBjajY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ug/hvANDvEVsgfUzHz15uwmv20WolG/1LQrfpmdqGoVK43Qr17UkZTdfOm3LccRqI
         jwr6EiwR52QkkEwfNpJ5q0VshH/CQc2/uYpOtFO71Qtsp6gL+p8Xe693rvf/4ZuhjQ
         majn39ng8DZ4081l0p+XPLidmVGHBBF+SqtBlzoY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190804232928.08b4b69a@xps13>
References: <20190804232928.08b4b69a@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190804232928.08b4b69a@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/mtd/fixes-for-5.3-rc3
X-PR-Tracked-Commit-Id: 2b372a9685a757a1d3ab30615ef42b2db7c45298
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62d1716304d1bb35ad9cdafe40efbbb6b3981cfe
Message-Id: <156496231039.14797.7123620641839744800.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 23:45:10 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Aug 2019 23:30:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62d1716304d1bb35ad9cdafe40efbbb6b3981cfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
