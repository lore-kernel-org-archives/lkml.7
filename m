Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC8C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E740021851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566147309;
	bh=PkfNAouq6ycRz61vC3rveUOxYFDama50+jBdAyrpdr0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hqTlsZ/LXLYZyvgBuG4VHTj2q7SeiqgKlSka9iuMfNwMzD0MxuAy47KmVN6Oj2ObO
	 0X5CAItRl3r1OEQ3aJ5MtSXbpK08tPccaUOapIjjSUnxuUHOe4B8bkujBtDPoHtfHS
	 1pPuo/lMGaJ83eiDURBTxyYPZl8fPHw0L/KFPc44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfHRQzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:07 -0400
Subject: Re: [GIT PULL] USB fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147306;
        bh=PkfNAouq6ycRz61vC3rveUOxYFDama50+jBdAyrpdr0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iPwRikkSWkMYvBHT5c47xZhAahNL14p1AE8S6rnlCgMjTHF3cONM2Z1Bm9Y3zfcVz
         l7HtdfX52Q+JBhriIRzAuw0aldH70AtgRMUaXTmxFMKcaEDL+vkScqXCB7aUhOnaS2
         8tzPlo8YA2kzkQQ9h2WeLg5fqpeFoH45Rz6ANTIs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190818085624.GA28589@kroah.com>
References: <20190818085624.GA28589@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190818085624.GA28589@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc5
X-PR-Tracked-Commit-Id: 6a5f43d1d8bd3779e428178438caf33f60427124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359334caf777854fc0647c610f4c34be5eaeb3ca
Message-Id: <156614730629.21549.11044540914517402297.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 10:56:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359334caf777854fc0647c610f4c34be5eaeb3ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
