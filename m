Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DDAC5B57D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EAC21852
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562380506;
	bh=ClYPlsLkGJ0ky7+3uGwX+CqeUFrp4gTbfIxB86npQH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m/eoeqV9uFg96NK4EqgJfp/cE2RCq/JtCBVkK7N5WZ4PTCup9nzm/8epe6hRGmZqF
	 BS781WTEaobjxDFkX6SNAlE/+GmV0MAhDQATz2rWO4TOZljn7VpCPP+yskXTOS7K4F
	 FDBjh7njwGmx7IizTSSpKCA/x6R+WM/JENP7hSZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGFCfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 22:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGFCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 22:35:03 -0400
Subject: Re: [GIT PULL] nfsd bugfixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562380502;
        bh=ClYPlsLkGJ0ky7+3uGwX+CqeUFrp4gTbfIxB86npQH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j/j6Dj9I2RxkhjWFrabffKYGabTyojsDtLPa2u1LQ157iiUFw3IRIZTHM8bJREcok
         VJ9HddL+LBCd7MUT+JM1g80GIxlTQi0AS1VasINjt+tTX3VGlvl5rJ3OGjf9NYlilK
         V4gdrp8xs5cQPnd96ZI8i6pZZcoosoHiPYVfQYqc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190705174037.GA4203@fieldses.org>
References: <20190705174037.GA4203@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190705174037.GA4203@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-2
X-PR-Tracked-Commit-Id: 3b2d4dcf71c4a91b420f835e52ddea8192300a3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8f46b5afe1c0a83c3013a339e6aeccc2f37342d
Message-Id: <156238050256.5324.1208784276842590540.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 02:35:02 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jul 2019 13:40:37 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8f46b5afe1c0a83c3013a339e6aeccc2f37342d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
