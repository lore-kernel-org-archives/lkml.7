Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28CC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789AE22CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165525;
	bh=UBAKE6BAsIPXe1KS+aRjQRwFDvQNCEb9dXo6spFXWZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CXRmijmgwb8Shf3Tv/Q/o+5pI8xWs9IzUIwn7hSEUf1PAOoSCc4tcP8ogO9mS7+0Y
	 u+7VEyHt9OdNSnbsGk1vNGu1jZ6pJLapotV54gph5i1Pc5ym0ooLfZ4Dkho/b3hHlH
	 ko5H8XuMXe7NFAmIA9nZ0DicYIHpl86n6KqqeCAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387532AbfGZSZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfGZSZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:23 -0400
Subject: Re: [GIT PULL] (ibft) for-linus-5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165522;
        bh=UBAKE6BAsIPXe1KS+aRjQRwFDvQNCEb9dXo6spFXWZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YVGOCY4hFFtncFyxPTeh6+YOCIvS2YbIhWAJGvf/FRT05FjWFwS8eINND5nxIVDNL
         3Q8REK8VJT15/QzBXvVt8Sy8aChdXsUG7f3EWKfS1dzOkmV+SCZrKXSaa6jiwzaDRr
         Y3Mnq6GVM+QDzy9lIwxPxSs59PK2UtU89mpFTGos=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190725175207.GC11606@char.us.oracle.com>
References: <20190725175207.GC11606@char.us.oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190725175207.GC11606@char.us.oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git for-linus-5.3
X-PR-Tracked-Commit-Id: 94bccc34071094c165c79b515d21b63c78f7e968
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55d31aaec0da46801e7337779bb3ebe88b034ef3
Message-Id: <156416552201.19332.11360030302385846743.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:22 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 13:52:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git for-linus-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55d31aaec0da46801e7337779bb3ebe88b034ef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
