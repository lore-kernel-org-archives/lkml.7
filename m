Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B68C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DA42184D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563648026;
	bh=MKlP6dDSV8abusWQpcYec7uQjtl5PPanksZXTNzX9IQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BTxiLI6NWrbIogCSL5hTXyH6e6VEN/LbsTvqu9ghpysR1oISvweyWU4U7253dimXM
	 s8fggtdlyOx73pkHu7Z9hXRjqCk6SyT48VBdUWWKGg9cNwfIHAyFH1nGvqro46IEjD
	 SXlJvPB+tRAt7nijHmXQ+jg6SsPao76vd/Ce7cLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfGTSkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfGTSkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:24 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.2+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648024;
        bh=MKlP6dDSV8abusWQpcYec7uQjtl5PPanksZXTNzX9IQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xSY1wzhRKXNR7nbRJP+8PKsfD4LFgVHi1qceREikAwlXLJyop65eC7Cej3412IlCZ
         Y7gPL6EbE4TITT2WvKYkaJUBed68fQY1BfmnDcqC5vQVd5MorVpJq27ju9rcxSQXg2
         /jdgzCzLIx+erUvJKUM83NaOTlXB1jgMSqmUTErM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1563579201.1602.7.camel@HansenPartnership.com>
References: <1563579201.1602.7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1563579201.1602.7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 07d9aa14346489d6facae5777ceb267a1dcadbc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f65420df914a85e33b2c8b1cab310858b2abb7c0
Message-Id: <156364802413.20023.10699674701293879168.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:24 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 08:33:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f65420df914a85e33b2c8b1cab310858b2abb7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
