Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE5EC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907CA214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561800612;
	bh=r24RVyVNU63oHseAg7oNfQeo4PfQI//arxmz7S3gLaw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D1iwcDVj/WLm+XGcMEXfBKxPZZv8sWjarUMCKfGqxlfIgtM1KdoY5OcOYCDCHakVN
	 eZLlpyu/gMXs7vo3Px3YUoRY7gT4rIBZ7MRJaNBh94wS+2To29etm1ozHN5GgJ5bqv
	 dXTsevb2TXuwWb4QZMpWXCBqZs0HKknXRsuBu2as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfF2JaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 05:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfF2JaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 05:30:06 -0400
Subject: Re: [GIT PULL] ARC fixes for 5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561800606;
        bh=r24RVyVNU63oHseAg7oNfQeo4PfQI//arxmz7S3gLaw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rg5PTXMWSVGlrywbFCLaPEogPnOxARjfVvctWWJdnT9gM+BbstEjPW7Q0wLr1aNJz
         /zpMc3lVpMaXW/OC9qbQREJ9qx8ohkKItdzOzcTG9VS6WNcDsSrn1Yfe0n0mtnnl7D
         cVL6EsplOj4DYwMrfOT31d0QWDjTJMuquCaHhiE0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b799ad4e-cafb-bf1f-3d92-34a5035ea7b5@synopsys.com>
References: <b799ad4e-cafb-bf1f-3d92-34a5035ea7b5@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b799ad4e-cafb-bf1f-3d92-34a5035ea7b5@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.2-rc7
X-PR-Tracked-Commit-Id: ec9b4feb1e41587c15d43d237844193318389dc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8b5c72227618780f49e53fb77b0e7ddb2996552
Message-Id: <156180060623.8003.8022382941002971289.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 09:30:06 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 00:12:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8b5c72227618780f49e53fb77b0e7ddb2996552

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
