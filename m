Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D323C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EBC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562820005;
	bh=d+0qNiXJBziVo7jDXzUp/u6MR+Wpq8yaV/+7PcMGcyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=07hD6Lq+zlfAnh+FV9rZW6p9MmVYuPzuE/yCU6GUJyJrU5kXuD0sXlA/ZDQ5e+jtc
	 xgTnZeH8DIm5JR7x1Fr/GNiiB3RSliya2auzCCR0ommYNZp9twaF8PNYiQzo0M1/Fs
	 3lGYfRCNX3eZFUlVDcc/GJpJVjhSxZ6p1A/k3+YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfGKEkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfGKEkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:02 -0400
Subject: Re: [GIT PULL] nfsd changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820001;
        bh=d+0qNiXJBziVo7jDXzUp/u6MR+Wpq8yaV/+7PcMGcyk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iR4Y1ceaP6J3epoAG+cejE6VZs06nDMaSJh9aMQQz4hJylm/i695XOoB7ie6GOb33
         ScpCSigkMSdLprDiBh3VhI8GLF7ca5I1CzI0N23PZC4vHIGnVuzx8uxTzabWhwB5tX
         iVRfOQxexD10fRM7s57RFmahjFlZdWvK41kxizrE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710220236.GA11923@fieldses.org>
References: <20190710220236.GA11923@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710220236.GA11923@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3
X-PR-Tracked-Commit-Id: b78fa45d4edb92fd7b882b2ec25b936cad412670
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2b6b4c832f7e3067709e8d4970b7b82b44419ac
Message-Id: <156282000176.18259.2153303986834115313.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:01 +0000
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 18:02:36 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2b6b4c832f7e3067709e8d4970b7b82b44419ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
