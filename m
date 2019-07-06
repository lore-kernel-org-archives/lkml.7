Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C01C48BD5
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC17920656
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562434814;
	bh=Q+VW4ArjfCIKmYSycw9+Q/L3I9hKNIS8YH7BanKZjPA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=12WfAKCaUwE81YFD1XbRL2BT6jZjrpsqJK3POanLUF87BMYPWGlF9tq0oO9y69phF
	 8SIz6uqBFQj8Fcvs4wGhTfFo88WnmLkwlYPlvs64C+JZ2TEyP4mvWMMKWDVozhBt2D
	 Luptm6BO3i6iQsasJbqIocqWsECbp8qpXDmFcTOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGFRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfGFRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:40:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562434806;
        bh=Q+VW4ArjfCIKmYSycw9+Q/L3I9hKNIS8YH7BanKZjPA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uq0RT2dA2vjinCmdkyK6kvU8+Hut5ETQs1jkzO1GJRSyxVYg9XRTZES/ccBNuKjr6
         QT9s0Np4h1dBxEuNpSRajoW7qO0MKzsMpVkP7oFVLE/1OdsqkYQDFbUkjLx/8QpYai
         MNqOZfPKpQVqGOfcPmYCarfrZI4MTjhQOYla7O60=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562390573.10899.20.camel@HansenPartnership.com>
References: <1562390573.10899.20.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562390573.10899.20.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 5dd6c49339126c2c8df2179041373222362d6e49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f8b49092c37cf0c87c43bb2698d43c71cf0e4e5
Message-Id: <156243480631.9000.929100396790254739.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 17:40:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 Jul 2019 22:22:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f8b49092c37cf0c87c43bb2698d43c71cf0e4e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
