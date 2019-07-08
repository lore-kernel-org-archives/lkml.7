Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D41C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0F217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614238;
	bh=gDSgH1UghIBBa4Kc+a5srXCu0zfSvwVcaJ9P/khcXKQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SgFgzHeXEb4cVyir2TVSrfX0wXyz/tUCPCmxjcveF3NulJBRpS9xdHOm2f8/rjYek
	 wTCbCCCRz/oBSIKreOppZdv1YogZmyvr8s0UG9RJWbIlVPWYTP84SUScjnZDIT9/ZT
	 RCTTWD/C1mnTIY6LnbFDd4ucTf8Mwl2MVlpGV5Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbfGHTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGHTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:06 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.3 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614206;
        bh=gDSgH1UghIBBa4Kc+a5srXCu0zfSvwVcaJ9P/khcXKQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cOf8vY6BW0SmjlPyF5+qVqNsYvZOdw09f3EXvKA/eN5cZAogAIM6P1zdkye5w7hz0
         UIENfwy9eE4IB20XdlQKshTQjfPJfF07Izl8KBSMMHntuH2m3DcGSymCVpawifOIG2
         fa8RAyLkPmSfD7Js/eZMV9QfqyG6QUskfofkF+E4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01562573328-ext-8139@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git s390-5.3-1
X-PR-Tracked-Commit-Id: 499723d12063aab97dfe6b41c822e9c1c74eff3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1758feddb0f9751debdc865fefde94b45907c948
Message-Id: <156261420606.31351.17681092519828073675.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:06 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 10:22:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git s390-5.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1758feddb0f9751debdc865fefde94b45907c948

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
