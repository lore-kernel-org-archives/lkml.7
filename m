Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17418208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565350457;
	bh=xvzM+rNMezOxa0Bnv95q/aeInbHv/3aA5R7Clz8rzHM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=flkAslDiM6qtvGUvI81b1fqxJC61mv4f7of2Fe9cL+qyc/2cMrAS2t+42O2FAWOmN
	 PGbHORyFfCmjmPELNHWzxzMjEoJEat0NMEFFYRppvor3ntAWu43gjZv8lz+fFMyZse
	 6X55ogs+T9BQe0vsO15/BapspeuawfZFhGpHn6To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406533AbfHILeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:34:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHILeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sWHbXyMzoEuVyq10lfOyRbyxdV133+TtRJ6b0uPtWz8=; b=daZWmeBN8e9GGRVFEIgn+dvOP
        oMCTXkNDn2JfvAFRz+wGlsiap1blgf3EGKlZqqRTWSOSlFbfR25up2J2IDLXQZhnTXF75KBvjuE/H
        +4AhCvXt7abPbiT4RsqIDS/13EKSGFGHwrlYFGRC+SOTSSZ8q6t5Ps0RoXxppov/OP+y/VDSiama4
        lScIWxzTZcdgagd8c5/dFwSROkvDoMru7vdmaKx6H0vCC5lxK/FdiV6NI8uic7iTY0ssyJe+LXY5l
        twyq4Q83mfflXwwfv9bSgVxy+sDYBpBfqAoyEz8YnI0QHCX/a62oNISITo6h6twI6JKZ+VlFCgxQd
        C/ZixeG5g==;
Received: from [179.162.52.10] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hw39x-0002yh-Nv; Fri, 09 Aug 2019 11:34:14 +0000
Date:   Fri, 9 Aug 2019 08:34:10 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.3-rc4] media fixes
Message-ID: <20190809083410.3997c6b5@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
   git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media media/v5.3-3

For a fix at the vivid CEC support.

-

Last attempt failed due to a mix of factors related to using a different
machine for the pull request. Sorry for that.

Thanks,
Mauro

---

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.3-3

for you to fetch changes up to 92f5b0313e37e2b37aaf8f0bb75b6c50eafb5808:

  media: vivid: fix missing cec adapter name (2019-07-30 11:47:51 -0400)

----------------------------------------------------------------
media updates for v5.3-rc1

----------------------------------------------------------------
Hans Verkuil (1):
      media: vivid: fix missing cec adapter name

 drivers/media/platform/vivid/vivid-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

