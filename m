Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699F2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LdKb0SLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDLPT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:19:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DQBDIAN2dt53srUxl1insU7EKWR1CjKsf9cF60Wdstk=; b=LdKb0SLrwcsSRq3O/X0qf19DJD
        DwRg4L3Ms0TZ/IZwAl0w8Uiyf4EO3bpGsBGHWiK2AskMKh/m8cS7Bl+X44dgQZhpvvrXAuYc/dfBO
        muGPzmJWo0KsS0SiZ0+9f/gUWYH2cF3CPMi9LVCKBMVZhVjgMZnn1sppzWcukBFTtMLNIAK+sXrhH
        kQWME/9F9B35urHxpuytidfWSqk9z5Frd1czRRoMxDQiAhv1/vPX66CcLJSAQS+QF0HBkwtpJh94A
        yuzajCdL24dElsmgOCQu91QXzVxdXzttY7FOWdjd4sgMCqFrH4EnNkgsFBxxrZRyR2b8bK1q+XOkF
        KKY18M9Q==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExxc-0005Cs-Ls; Fri, 12 Apr 2019 15:19:25 +0000
Date:   Fri, 12 Apr 2019 17:19:01 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for 5.1
Message-ID: <20190412151901.GA14497@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1-1

for you to fetch changes up to 8c5165430c0194df92369162d1c7f53f8672baa5:

  dma-debug: only skip one stackframe entry (2019-04-11 19:29:50 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.1

Fix a sparc64 sun4v_pci regression introduced in this merged window,
and a dma-debug stracktrace regression from the big refactor last
merge window.

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc64/pci_sun4v: fix ATU checks for large DMA masks

Scott Wood (1):
      dma-debug: only skip one stackframe entry

 arch/sparc/kernel/pci_sun4v.c | 20 +++++++++++---------
 kernel/dma/debug.c            |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)
