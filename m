Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A5FC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDD20848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/vJ44ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEPIab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:30:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l2s4pBaM0QsdmyeFmIft5iVXiAaDdNaD+gsfqUyo/Cs=; b=X/vJ44ahCUxI9RZErNkN+r3JXp
        IYMqvC4G4X2L312Nr6zF4JeixB66vNAVjb+EcDCpB6GVA5iOFYGf2oP6vKz/n/zLg16rj8i5ka0ad
        +HN7K41F/P3VdO3PMPw7yDI/IEBL49obnqLrccjhY/x0OByl5S87b0WkRio6c25z1IjFqSlKFXTCS
        ob3KSTOOC9psXmIc1zyJD8DDcmxDAc+PXDR2gvkAJZrYrB6+ymghv5TK4xw7MCctpVTEmfBj8g1Nh
        Megh1r541B1fhU9+5PGZEaMFFUOm05G3ItgNhHha8BsdI8q1DdWBEmm+Rk4HWy6W1Ev3lHYlKM1EQ
        SsS+M2QQ==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBmX-0000jy-2D; Thu, 16 May 2019 08:30:29 +0000
Date:   Thu, 16 May 2019 10:29:42 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs update for 5.2
Message-ID: <20190516082942.GA19549@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-5.2

for you to fetch changes up to 35399f87e271f7cf3048eab00a421a6519ac8441:

  configfs: fix possible use-after-free in configfs_register_group (2019-05-08 08:55:19 +0200)

----------------------------------------------------------------
configs updates for Linux 5.2:

 - a fix for an error path use after free (YueHaibing)

----------------------------------------------------------------
YueHaibing (1):
      configfs: fix possible use-after-free in configfs_register_group

 fs/configfs/dir.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
