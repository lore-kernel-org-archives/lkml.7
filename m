Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D032C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572B521880
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563565533;
	bh=i+PCBNu57gHOpirHmEo1+Qwpm5zVD18MBNcnfEZKYPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C2k2s99/UWLrMkC0yZdloGSoS2dTsntRz/X8HXbupF/p5JZOSzYQB8yt0mxGMPQzI
	 eBDDYKYO4ITeyNgfj2SfAig5Da/uxyUg1L6HK+oAekf2n7fFQTnny/87y9FH0v324y
	 eA7n7x2EyADfb98bcOBFKJJe8Oa6huf6QIl92Q4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfGSTp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387565AbfGSTpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:25 -0400
Subject: Re: [PULL] drm-next fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565524;
        bh=i+PCBNu57gHOpirHmEo1+Qwpm5zVD18MBNcnfEZKYPg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Megbv5LGEDYK7/pSL5O+w8eZZxQInmOV5nNlUAdLTLFrMEaH7c9ad5aCor2Jtu4Av
         aj2PTfv9ED1/kYCxpJ9627PelcwetpXglNRttuRtpCo5AryAs9tr5nOCZz5qXLrzBd
         rysi0O5x70dC3LW7DvKRS5l4tDB7B/U6KazUH6eo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719154207.GA9708@phenom.ffwll.local>
References: <20190719154207.GA9708@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719154207.GA9708@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-07-19
X-PR-Tracked-Commit-Id: 8ee795625665208589a97972b01790bb04ea83e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31cc088a4f5d83481c6f5041bd6eb06115b974af
Message-Id: <156356552472.25668.6959970865866797426.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:24 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 17:42:56 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31cc088a4f5d83481c6f5041bd6eb06115b974af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
