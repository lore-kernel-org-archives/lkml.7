Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61112C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2995820684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757231;
	bh=kgKUs6CB2OVqa+OQ+Mkv6MbdlbqdAMWR44sDfGqmF2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QtPBVA5PMxXl4nUu9qVcHwzi5vhSEqtY0qVNO6z/rqTZJFJOFyrahLgGJLOUfyAYs
	 qIVZfRA1FYkAmBe5N8SL4rLll0v3B5Rogd+lKBqGs7mmBtAX3xTF8xTPyhJh92XHZu
	 9A3yhCiqxWNKeJy04Ogh/jJvJnLawW2X4pXroDOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCEDka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfCEDkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:04 -0500
Subject: Re: [GIT PULL] mtd: Changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757203;
        bh=kgKUs6CB2OVqa+OQ+Mkv6MbdlbqdAMWR44sDfGqmF2A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gjf3g8/H9+JvKK6eWTu1LinNPCEviGPA6jznOdDxsuuBMENe8z/pYEKpWH27EL+Zm
         fOZCsX24YM8FKqUgO0yicxY36roO/pmPA5eWKdMoczuIkrszuhwGQYhltDT7FFS44A
         oLeq/O3jzWdcQMCPG8xptoxhVvgw9PeUaDz/Vh3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190225094526.580e0dbb@collabora.com>
References: <20190225094526.580e0dbb@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190225094526.580e0dbb@collabora.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-mtd.git tags/mtd/for-5.1
X-PR-Tracked-Commit-Id: 9220d7befc9c28bf714701e6e26163644750d871
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 811c16a2a2de6fcdeea188a770600210943f8947
Message-Id: <155175720373.14960.4410023755111714346.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:03 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Feb 2019 09:45:26 +0100:

> git://git.infradead.org/linux-mtd.git tags/mtd/for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/811c16a2a2de6fcdeea188a770600210943f8947

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
