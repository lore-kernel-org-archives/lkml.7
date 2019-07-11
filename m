Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C87C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03685216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562879711;
	bh=Y/o72BhLin7wKyl6QOmk5iKhGqxURtOUiohTxPH1RV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ah0QzFAr5mAYGc6tO3e5AmiodWH/O8fGq5IGSS95GuUv4OiPfMdhxhzqkfuHHQ5xM
	 JBRkNRRoiZ/ftL7PFD+78vfpQG3dURnqz6czf6/3m8ZRBBe3sgJw4tDnshFRDZFKpa
	 YCEMWiNbBpfkniLDse1X4mocx6gd+ir3jNIewB0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfGKVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGKVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:09 -0400
Subject: Re: [GIT pull] core/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879708;
        bh=Y/o72BhLin7wKyl6QOmk5iKhGqxURtOUiohTxPH1RV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rVvyX/wJa0tvfguNU0mMmJwtDs9bWG0PSbkAHsU/jonF8lXL17Q3ZhZCQlslqzIcp
         4tAO+ti3fn9SOFaao4g7iEor59v6IqVBEUfMrrvhkM8uhyhTUWOFnFRbR+BiCCZFLA
         0ggB33la98E6ezQJQ6aKDL7bjnPWeMUFsycasf5g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 7e8e6816c6495a1168f9a7a50125d82c23e59300
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02150fab6ae9924ef03e21a15f2d5f7415a9cdf7
Message-Id: <156287970841.8575.3777016484102552467.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02150fab6ae9924ef03e21a15f2d5f7415a9cdf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
