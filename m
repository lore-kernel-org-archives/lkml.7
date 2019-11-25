Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD3C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658792084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574721911;
	bh=5AoFm34wipj/pyRMsUWZ1JJWSjOpgukiY6w9igyapVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=o6qZmn2XX8a25vXFP52fuMu84aVx+4m+5ZxcpIAgsqGEPpcGwCfV3Mv7cahC8DHzX
	 Qkqqw/QYWNlR0Wt7hdxXPEAC+0j2BFFRXvnejAa+7m+Jla1DZBsuz43RI2JTbkratv
	 WOjzrESDiuZN+yCYXbx3R3bFYhDBF7GSp8wyXDlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKYWpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfKYWpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:06 -0500
Subject: Re: [GIT PULL] mtd: Changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721906;
        bh=5AoFm34wipj/pyRMsUWZ1JJWSjOpgukiY6w9igyapVw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GTZu79n0eT2Lnz91avU6nWaer8RJv4Xzojv9RKNip6uT2ipu6YB4wASK8N0l53Jwc
         40pvepUhVAEBa50wnPcpiyb0tOTmCeo7x3tOexHQgrAL7I8gmXlrN6ppUlnfrw2pdD
         g2+/qlCJt/vkN2OY2INi+8xHTZuhaBK2X8Jf8iKc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191122210520.3f714435@xps13>
References: <20191122210520.3f714435@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191122210520.3f714435@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.5
X-PR-Tracked-Commit-Id: 589e1b6c47ce72fcae103c2e45d899610c92c11e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b88176b9c72fb4edd5920969aef94c5cd358337
Message-Id: <157472190634.22729.5736916559423617241.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:06 +0000
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

The pull request you sent on Fri, 22 Nov 2019 21:05:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b88176b9c72fb4edd5920969aef94c5cd358337

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
