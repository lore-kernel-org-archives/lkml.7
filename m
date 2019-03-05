Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFF120652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551814509;
	bh=HJo5p4g76HXz6dWqRr2iCch4LR26aJJlgsj5QUlfZ4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Btyh9HoKyb+kRtnY38+ueu8vFBiCe5lEQGKZimZqcZioKiKd1UPZLCXJiBUr14rSI
	 6ssNOKolHDN1hoXWk0P+Aesp3PGR+bu6guTYVU8285DXcugpVIk8r0t/8kPr2HDjwQ
	 js0t7IWDlcdBrO6zm2iaLH183FMxiRbKiPdeJNiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfCETfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfCETfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:35:04 -0500
Subject: Re: [git pull] m68k updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551814503;
        bh=HJo5p4g76HXz6dWqRr2iCch4LR26aJJlgsj5QUlfZ4Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OZ5QAwDFfAUCcJVPLOE352jUdj/ANLzcJ8bSUNkAfuFpgwNJNwogwLUxzA6yJjX+r
         iskOK0AtsQ6oIIjtxAwzuZb7eyK3263uze1oTdupuBJnuWdvH2GEnkJd6PyELrBgpf
         O5qoIY2OFEHAToApfIhTmQR35NtyDA/4q19fTJYU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301135001.29176-1-geert@linux-m68k.org>
References: <20190301135001.29176-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301135001.29176-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.1-tag1
X-PR-Tracked-Commit-Id: 28713169d879b67be2ef2f84dcf54905de238294
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45f5532a2f65afeda9e8a02bf1aca15c2b4c9be8
Message-Id: <155181450347.15853.13498006693794137186.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 19:35:03 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Mar 2019 14:50:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.1-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45f5532a2f65afeda9e8a02bf1aca15c2b4c9be8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
