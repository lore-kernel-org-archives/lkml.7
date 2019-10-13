Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EEBECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CAD2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570983307;
	bh=l3PUiyUzcVRzu9ZjGfW0o+6z6+yhGNHQ5vU+b73MK9I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V5/eQopMJItcZzyKzIs7O22HQkPycPMKTOdhJLbodotGGZjX6ErGmHrzgprTgdJ1m
	 XaEvFu47tR7jVwWZR448pVW+u6+fklX/DERAXcIP5gaEKR5U0bYrHjy1HM5gZDWEVK
	 MfI/PaaXY5x4ho3qTNA93ZKz+cM8GuKD9+lxXlrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJMQPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 12:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfJMQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 12:15:06 -0400
Subject: Re: [GIT PULL] mtd: Fixes for v5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983305;
        bh=l3PUiyUzcVRzu9ZjGfW0o+6z6+yhGNHQ5vU+b73MK9I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NxpLRAMRt5/vZ0IFd4MiE3R5jGRHjoQPnytwfCie1n7paj61EVBmB4QKcVBUYYS+T
         aqiUNURruczlQIjZpUWMGqmgZHOUCxZ87fxJQiNKF9zBrBxGd2DT+hoV5KjKSWwnl/
         TWF2t8iAZG4Ru/E13JQdVky1OMoKfGKSzqWXwpnM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
References: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1615396520.21318.1570912156820.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/fixes-for-5.4-rc3
X-PR-Tracked-Commit-Id: df8fed831cbcdce7b283b2d9c1aadadcf8940d05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71b1b5532b9c58f260911ee59c7b3007d6d673a5
Message-Id: <157098330559.26372.16017055334585777960.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 16:15:05 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 22:29:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71b1b5532b9c58f260911ee59c7b3007d6d673a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
