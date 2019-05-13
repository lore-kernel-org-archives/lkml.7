Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FF8C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B669B21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557754804;
	bh=dvy2E7x/Z0pbk2bxaVpEqIXG2hXlz6zICmMuUGZVNkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hY3lGHNxMBkIxLTr5vxpA8OnUMGZ8WtXnRBN3i9Gz8YwOhOtPXnhw9Xm3Y+pNC/Rq
	 CCTIV8FynMn3wzNHDTMlpV138mJUOUjbX+5TQOQD3uxj99zJxl/fFP3ciW4+Tg8ktb
	 aQW1ZXT7PGy1fr2Zt7/VCrFKZtVZhwwwOGyYnmDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfEMNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfEMNkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:40:03 -0400
Subject: Re: [GIT PULL REQUEST] watchdog - v5.2 Merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557754802;
        bh=dvy2E7x/Z0pbk2bxaVpEqIXG2hXlz6zICmMuUGZVNkY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLBY2eSgPGjORJs5pQFcpzZV+j9RQ095jMrB6TKn9uKwGKRwvqzjaW6Yq1bJ0t6ZL
         tZxLQwVeGUaNtnKgCBtEb6zmn+4SjsCYtJVqE+69ty+reNZvNOHERj6CSRSLr39MYF
         Lmmvdnjd3H8bvP2irY1k6QjCLvLM97Ou8N5I9cow=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513104855.GA5837@www.linux-watchdog.org>
References: <20190513104855.GA5837@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513104855.GA5837@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.2-rc1
X-PR-Tracked-Commit-Id: a9f0bda567e32a2b44165b067adfc4a4f56d1815
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55472bae5331f33582d9f0e8919fed8bebcda0da
Message-Id: <155775480285.19061.18386960375104379671.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 13:40:02 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Bryan Tan <bryantan@vmware.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Colin Ian King <colin.king@canonical.com>,
        Hofmann <georg@hofmannsweb.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ji-Ze Hong <hpeter@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Matteo Croce <mcroce@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        YueHaibing <yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 12:48:55 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55472bae5331f33582d9f0e8919fed8bebcda0da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
