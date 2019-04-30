Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB28C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2FC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUTZ9ARH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfD3Lna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:43:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfD3Ln0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c4e/nTvtQGyaW5Djk9MygY1aHxVTJJByJwYRDeIZNMg=; b=aUTZ9ARHMuIHgk7JMGKcAsU8V
        dOhiiyl3m5nLsfJJwXXDr1mi6pPqBRqNnH0WCj2SzVwxWsTCmEl7J449q2rQSSTNiCqPjt/J30rU5
        jyi7W54hKpBz5yMhHPgv1s4WoEEw8Pw8Wb/jhyh/Xh+lqvz96ioZ9prEv0a6PDzfyqiO7mjcob0gx
        XZcZaYfejPRMk5JsjjPVK16nH4FgN5Y0umtIFzozFQH1ouPr5rnz2gjxqGoU1glX+vSZUHQAuWoGT
        zrh9geTYeQtTJiK5wisUNzaqGODb0W0SpnOe4Uv8mXo3JId5lnPsO5cxhXJ6HhpXo6YxOkNWREQ2W
        lttonOT5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLRAP-0002g8-VK; Tue, 30 Apr 2019 11:43:21 +0000
Date:   Tue, 30 Apr 2019 04:43:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rds: ib: force endiannes annotation
Message-ID: <20190430114321.GA9813@infradead.org>
References: <1556593977-15828-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556593977-15828-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch looks good, but the force in the subject sounds weird now.
