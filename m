Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA86ECE596
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCC9206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570557623;
	bh=HwzVqlpqTlUCC0/ZTEjrzR58/tMSplLoD1BQABsruxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rR3Z1NBTPqS0Ro88OUN9wJTkZ71lgWSecYHgg2+fHgPQehK9vWQ+pMo+kt+ey79FZ
	 jsslVYY49uTHZljLUHGO09/IcD3JTZmibG2q0I0KChW/IRWjam2ulXjbj3VZK5dxqO
	 BR6meYdVjYZ6UYyfCKqzO3EGmH/JYyD5zlPybhYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfJHSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfJHSAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:00:10 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570557609;
        bh=HwzVqlpqTlUCC0/ZTEjrzR58/tMSplLoD1BQABsruxQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ciRhypSKlarR/snUNq1fn+bjKOyy6Qr+d0GDLdrdE5uAg1QWw+JToScxakmArZ8ZQ
         5iGB4817VhPoUhjYOAAZPQM7+VLV2YFLpwCz2b/6D1zYpOldnA/h3p888HtPMo5Gx2
         5lObbEG/w0RapP5hN6aoh19HXpMeU+JgRye/3mtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
References: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <be198a81-7b4b-5d4c-c8c4-8dc3920f2ae5@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.4-rc3
X-PR-Tracked-Commit-Id: ce3a677802121e038d2f062e90f96f84e7351da0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f54e66ae770fe559fb21383f95d739ac74c03ea8
Message-Id: <157055760984.21274.18416681419306362425.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Oct 2019 18:00:09 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Oct 2019 15:02:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f54e66ae770fe559fb21383f95d739ac74c03ea8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
