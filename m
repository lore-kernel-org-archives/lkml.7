Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E9BC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CA821019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563474622;
	bh=yp+v1G+WHtqQfLqTmTaMh0XIuJLVgPNGYlbEHdjF3Iw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TyJNuAz4HRIUcXED4vU7fZHlfLdn1sdxdwBi5WnKR5gP6iQg2jN8lQRbL7TosvWM5
	 yY1gtT5UCDRZUgtwRulgkO9mA3U4XDybLalEbDlKHugFg55QLKhB7qEAsCvapE2N95
	 8Mt26THPMk1tX3mnNXBXyYlJ8MmtOj6EPxVMMJNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391225AbfGRSaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391149AbfGRSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:30:19 -0400
Subject: Re: [GIT PULL] libnvdimm for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563474618;
        bh=yp+v1G+WHtqQfLqTmTaMh0XIuJLVgPNGYlbEHdjF3Iw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W8rdAO4Mc/XIaEqO2H9YRT1Xi27zGF63+NUbaVX5oGS3WFr5HIBwDY8A1AHeER0ee
         sFq7WNpeECel/g5+Z3bFp6lz6CWis72GnjEJ7pE8+AOZlhJ8g2HvLIh8ouAE9+qlGd
         bbW3xX5tQ4gSvTtfjDKIo7MKaBmfsLy9pz19t+Y0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
References: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4ji_0CqmeO2hh1ERvUnVJZkFcuj+=QQ3mrSx13y3uSHoQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-for-5.3
X-PR-Tracked-Commit-Id: 8c2e408e73f735d2e6e8b43f9b038c9abb082939
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8c3500cd137867927bc080f4a6e02e0222dd1b8
Message-Id: <156347461871.12683.18224715719343040057.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 18:30:18 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 07:16:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8c3500cd137867927bc080f4a6e02e0222dd1b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
