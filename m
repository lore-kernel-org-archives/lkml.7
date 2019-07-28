Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68304C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4241121738
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564290026;
	bh=9vHIEX/HP3w7SZRgfGUMAW/ipa2bxSzdCa4/ZUUFQPQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iwXut4Ukr2kwNdPvuXrKJAfIvTWHcmHMmqOncByEzoWmAAQwie0Gzdl2hOh9W8LwH
	 I06n08YBoVLikhTrucNSBOPEjANJ+qcnI9dtnM+2bwwmiqRC2uibgkRK/OIxYjDp/7
	 sYw9ONnJWuuTiG9Uzf+4kwR4wvSzwDxzd+tW78GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfG1FAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 01:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfG1FAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:23 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290022;
        bh=9vHIEX/HP3w7SZRgfGUMAW/ipa2bxSzdCa4/ZUUFQPQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bl+2zKHRM/qzQHe+/ph5o/5TUy1GtoemQmvKER6jOTfN9R4KFc2vszqKaJXt1KLmD
         1dnYmh2OMXLfCLKFiGJfokWzoSRfaSU5vJFyawVmxzsVKnHoV/vdO2m4gEfeOb2BbW
         D8RbtNftZ2NmlmN4VXG8pG4j5Otw22J+JKZ/TskE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
 <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 289a2d22b5b611d85030795802a710e9f520df29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750991f9af5b4019fd0232c23a4815682ff91021
Message-Id: <156429002231.32180.16977131787063752082.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750991f9af5b4019fd0232c23a4815682ff91021

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
