Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CBBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503382089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YMU8CEcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDXFcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:32:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T9+ILr1K9dgSXuJiRKMnYcKtiyge06AaO0Stgaxa8VQ=; b=YMU8CEcPD/DO9ybAbqyHPaXaA
        m58fs/meei8Y1qpR75VyKq4nRIVKkWMxPBCx2tj8oAsD8hiRBZNk3of65GMkvYjoFi1HokbK0qkwE
        P/2PA+llqoLj7SNTXGgwa9+irxPi4vEALMySaXOv7xX7LywrjAFcLIrMBaJFVhnYtybFQfU07f5IO
        svTZSrfOE9qDYJIKudTtZuN7XpF+h6wr1gPuE8z89hRhvB38rZq7umANUZo2hDgada3TsrZp3vwZO
        la+DGkRAwghUj0AzhwQB687YdXdZJQHz0or6EAR+26jdatI4OCRN22PrOxLG2VFZFOnmqyUclc4JJ
        +KWasdF0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJAWH-00034e-GJ; Wed, 24 Apr 2019 05:32:33 +0000
Date:   Tue, 23 Apr 2019 22:32:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        murphyt7@tcd.ie
Subject: Re: [PATCH] Remove old no iommu direct mapping code
Message-ID: <20190424053233.GA11783@infradead.org>
References: <20190423200335.3888-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423200335.3888-1-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/amd&id=7a5dbf3ab2f04905cf8468c66fcdbfb643068bcb
