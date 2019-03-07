Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FB120842
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921627;
	bh=JE3DMGNrQJYpIdlZCTwZltgU9IANwYq4q/U+2IetAQ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jhxpkAZWLj2hLJMXG4gFgfJZjpCHyaTJdf77Ceub/BmFB1iKDFlCpXDvVQtujGEX9
	 oD1eny+1HZx3cSiuhZKU+diWGn4VLCVurLtyiObNK3tkUsIpthyK14iXXJwST361Pn
	 zLIPEQuIjD3UKkic7D/CvAUPOqQ9HH5rt2Rt3j7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCGBU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfCGBUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:20:19 -0500
Subject: Re: [GIT PULL] USB/PHY driver patches for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551921618;
        bh=JE3DMGNrQJYpIdlZCTwZltgU9IANwYq4q/U+2IetAQ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d/8w7PdAvypVk9q4egFHIrl/xVQPPdrpIbXhFYfnNSsKXYRhp6iVdokU64UVyck4Y
         /XnBVLo22jhvt9guJlDoc99o6azPFtlmFAq0CDU/NqDfnZ7NR9YmibNWKXRI/jyxpY
         qezKxku4S4sKFJYCWuvwI26KHLZ7cXnHxb95CtVU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306103531.GA10871@kroah.com>
References: <20190306103531.GA10871@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306103531.GA10871@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc1
X-PR-Tracked-Commit-Id: 1c7cf3d5e1c181caca75012b65252288c18a25f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f90d64483ebd394958841f67f8794ab203b319a7
Message-Id: <155192161879.31671.6913353675738135793.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 01:20:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 11:35:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f90d64483ebd394958841f67f8794ab203b319a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
