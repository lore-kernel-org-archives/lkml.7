Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF7AC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564783812;
	bh=ZASyBPGmm3S6IHbaChH2bfElSW96PzDvc+KMwQrEEC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VgsR/hB11j8bp2h8TWKkpz9zVdhdl7DchH2BCT8rtDhpUxs+qMdRuJvdgPmuvprPI
	 fSsTP2zZVis7lEvkMbs+Quk73JmYuJPrcgCt+lGp+wp0kriz0YLHajIifti726sssV
	 pjp/dpHTEu0PZFuQQxc6zlv5zyplMW0QZMCklw4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfHBWKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfHBWKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:10 -0400
Subject: Re: [PULL REQUEST] Please pull rdma.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783809;
        bh=ZASyBPGmm3S6IHbaChH2bfElSW96PzDvc+KMwQrEEC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V1Aa3RQ/oHhcPtnxeVFEsmsTFx6FPH/mxR+v32mrQf2eLQfVeaOlKzXwNXL3ww2LJ
         C1QRAA1nEqVufzKKTauqc5RfHMoQ4Jvs+Wx4o3HRcHan0DWCWJ4pG35J2bMfgKW4v/
         CKSBkjazGCsYJGGofa3lHTlwIEIINl1dVyp9pig8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
References: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 020fb3bebc224dfe9353a56ecbe2d5fac499dffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07042ca32ffca69b4e3c3b938bb89ab8aa18035
Message-Id: <156478380974.28292.488788745060344636.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:09 +0000
To:     Doug Ledford <dledford@redhat.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Aug 2019 10:39:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07042ca32ffca69b4e3c3b938bb89ab8aa18035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
