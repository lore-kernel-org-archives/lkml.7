Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2762C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B154218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UDoIDDID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGCMYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:24:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfGCMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UgSdS+LcNa3zwD10AD2JimuZLbxV3TtpHzyJ+/tBrVk=; b=UDoIDDIDp27kYD+vUzj+WOd/x
        qA/af8OpWKGlaG58JedwTfNudNtn79jCIY3ilgnX5Zoc2AhrEgKGkFUxN7hpDJ9fIDXLqAvKpfHYl
        HAGdBt/1N800dvMubfmU101bRoVW9PA09hLi/fQ8ZqRdnfpW96fOXfL4Xi+Rf75jnVUVn2etspIFA
        j6Oct+3Crt6la+yx0SC6VTJLvHrf0BVjEf7e7ya3u9yxx2Je9wIUbzFv8kIPBIFoWlT1DkW4lDakS
        uq5EizvrixbNEnUKfqoTsOzemLLaiG3b29Woeij+b45ivwS5VUDT7+0g9asYMNQYsdHVtJ/6mEgXV
        U5VlSE2FQ==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hieIp-0002Fj-EV; Wed, 03 Jul 2019 12:23:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: nommu fixups
Date:   Wed,  3 Jul 2019 05:23:56 -0700
Message-Id: <20190703122359.18200-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

the patches are fixups developed for the RISC-V nommu port.  Can you
queue them up in -mm?
