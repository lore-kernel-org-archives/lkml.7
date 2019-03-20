Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11FE2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553105115;
	bh=w6bYvjpD1052bFhSlSEJrkaRHr5ItprgG4s6iuMczTA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f7WEushZEaxVN0tz7L6+xfGIuOXm29aAJCrYKF193GgZfaAUJW2u5RTgk/TG5H10T
	 /5iAWNjkSA2UIJVpiGnXm/m5KRaw/z2eow27EtWMJJRFwoEwJR+lUY6J1lk200DYUh
	 /po5SzwwwkImFRXvEnm4e7bC45BBGKTq6yDuFapc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCTSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfCTSFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:05:12 -0400
Subject: Re: [GIT PULL] ARC updates for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553105112;
        bh=w6bYvjpD1052bFhSlSEJrkaRHr5ItprgG4s6iuMczTA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jSINWm6LAk/NvBXOcJEHoQnyBpndU2BYjf5yoy5TpiUK78hAxPhhbyheD5ITVFBRg
         SqlBiLIBfM8FHY477oBFIUCGKL1FgTBh04yV3EOJf/Wyb488Y9IvUVKM7mVDtHwCUC
         p6yhr6GlcP3a8iSU+1j7d9T3IQRo59S7iX+Ougcs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <84416b56-150b-1725-30de-6ae563862a87@synopsys.com>
References: <84416b56-150b-1725-30de-6ae563862a87@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <84416b56-150b-1725-30de-6ae563862a87@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.1-rc2
X-PR-Tracked-Commit-Id: 9a18b5a412baf23137c8fddb4ea7f0c14087f31c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54c490164523de90c42b1d89e7de3befe3284d1b
Message-Id: <155310511212.8172.11743085761175872439.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Mar 2019 18:05:12 +0000
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Mar 2019 14:58:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54c490164523de90c42b1d89e7de3befe3284d1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
