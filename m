Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232DAC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93AD2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569089724;
	bh=EiG57zb4vKAoSv369pkR5LsK1+EQhcuZFP0Q3Zji8+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wYT4rOqijZdfgMSZldItgZzam0TiD1iUhzAtd3c39yqKZx3pw2YUMAZdLupCR4NEZ
	 yPYJM4O3/Z71IMfoyGM9nS6rolell3h1CtOQYVrluXR5Jig+VuKQk1e7uNZa5hyIvA
	 1fVVUh9+FxSlFa2JwBhOSjw14xVX8566F639o+g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfIUSPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbfIUSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:15:22 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.3+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089722;
        bh=EiG57zb4vKAoSv369pkR5LsK1+EQhcuZFP0Q3Zji8+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FnflgwCb37YF2UtmrUFTKahuERkemwSa25OFsByQslGVDzWOY37TAt27ovCjgNR43
         Z8Dn3pBo6wk18Ysw5V5IJQIjd8/322LApYx0ZLE1ee65T66C2P+B3QEaBEFf7OwgMP
         +I2FtW6Ap5E9kh1Zp4T/sSxD8oBCieoCZgCnK9EY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1568933249.25516.10.camel@HansenPartnership.com>
References: <1568933249.25516.10.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1568933249.25516.10.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: e74006edd0d42b45ff37ae4ae13c614cfa30056b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10fd71780f7d155f4e35fecfad0ebd4a725a244b
Message-Id: <156908972219.32474.7469326079291147244.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 18:15:22 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 15:47:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10fd71780f7d155f4e35fecfad0ebd4a725a244b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
