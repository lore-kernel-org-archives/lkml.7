Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A09C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D64D254CC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQ4HCu1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfE3Ix3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfE3Ix3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7aH335K8bkoHEjqmekfUR/dxSx+60OHumVq1hGf49IM=; b=dQ4HCu1qVgISjGAbLPD/Q3rw8v
        1foKw4rPUo8IVyIavrr82ZM8Z//0KK+u3uEp7R1+o6P8b9DIpr9mXpyYgdRuT/KMvuG/DxNnEG5o2
        AwI1mmuVei2+4lTWig4t4cbY40g/AR/A42JqFdVkZRC1S4imIWKR91C0Rfpd0N4faVUvhTy2WAQC2
        sxc5Qo9A3V3TUyG1Vgp6fglA6LE/DpeXRovD2++zTKiqSO23a27Rid5l34b5jfalO5y5/IW9yYaZA
        uYzOoV/0bu0TIboplGAVRAayDwpRVRXAgXejY9+5b2+ROH9ztyUWOetv/V6YewC/kHoo3jcphtnu4
        br8X/bvQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWGoO-0002lZ-N8; Thu, 30 May 2019 08:53:25 +0000
Date:   Thu, 30 May 2019 10:53:21 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs fix for 5.2
Message-ID: <20190530085321.GA24647@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.2-2

for you to fetch changes up to f6122ed2a4f9c9c1c073ddf6308d1b2ac10e0781:

  configfs: Fix use-after-free when accessing sd->s_dentry (2019-05-28 08:11:58 +0200)

----------------------------------------------------------------
configs fix for 5.2

 - fix a use after free in configfs_d_iput (Sahitya Tummala)

----------------------------------------------------------------
Sahitya Tummala (1):
      configfs: Fix use-after-free when accessing sd->s_dentry

 fs/configfs/dir.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
