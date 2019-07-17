Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59941C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329DF21848
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563382220;
	bh=SU6raH3/FUvVwY7V8GkrbIe7n02f3DAgoo2kaOjNTcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qx7Ytim72VVc8Yjir5yL2pDgWdxs8NsibX8SKhrLPg+Abjt3J8mAgdb0XYp7H0op7
	 J8waW9yAeVxZtQJ05NN9PV/pk7tNPGeoni7scUNFv8ADYrkyHQOPPnjgU9ILnTsIrl
	 YByFbda8Wd5Z8dBq4kH22UX11vgDIlXMkfxnsvUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfGQQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfGQQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:50:17 -0400
Subject: Re: [GIT PULL] arch/sh update
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563382216;
        bh=SU6raH3/FUvVwY7V8GkrbIe7n02f3DAgoo2kaOjNTcc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xKrxLSsu7l+ufM+3WGbtn4OBBlfc+TNM0DziBC/BZWlhrppsUC/S+4ikH5obCUR5Q
         PcdlyUCSD0Pm5wKQ+WdAw+o7DHTpXOZ+jLj5pNCTj9chxC25MSMQHOQyywboh5+oFf
         EDByaZM2rMRR021uPYL21lDBuLiQRELjotuop02I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zhldp03a.wl-ysato@users.sourceforge.jp>
References: <87zhldp03a.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zhldp03a.wl-ysato@users.sourceforge.jp>
X-PR-Tracked-Remote: git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git
 tags/for-linus-20190617
X-PR-Tracked-Commit-Id: d3023897b4370bbf7f289806667a2380576d13dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 415bfd9cdb175cf870fb173ae9d3958862de2c97
Message-Id: <156338221686.6265.7605811848098125155.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 16:50:16 +0000
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 16:54:49 +0900:

> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/for-linus-20190617

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/415bfd9cdb175cf870fb173ae9d3958862de2c97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
