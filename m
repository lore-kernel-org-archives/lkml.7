Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFEC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF70E23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNxWJcbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH3Pq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:46:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfH3Pqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VI0bXCVY8P10H0YT3Rjq7E9GvaiLma/bGh4rBPUdQKg=; b=UNxWJcbn1PB9qyM05AHzrOjp5
        5OskrUVMmr8E657vBPDa4nkoWpXwS48U5vGj4wCTVjhSjPsYF9oRgdHtWUmvFMhrCJAYi/vj/FF0A
        eqtZ6wSH1lfvGv1GPkgsPpPIerkGgc7t5x48gBu1tOfBVOwSYvcK0/+EU/sPIZC46P/wLirq4zdqU
        XfhYtWeTiF4DB0ggGTGH8aPlSjIycvvzNj0plwZ/TqjzP75Kh270DOEmNsNXfzL6jiP1W4xRkNnM5
        QTf5A+zcHpKdOVTuqhQsqOUXWgmr7Sb/YmJMUEZy2PoFRAneQ98gZ5p6Kk+TNiIOqEihoP7TgLOWt
        aI3ChGSWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3j6w-0005vs-1C; Fri, 30 Aug 2019 15:46:50 +0000
Date:   Fri, 30 Aug 2019 08:46:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 6/7] erofs: remove all likely/unlikely annotations
Message-ID: <20190830154650.GB11571@infradead.org>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-6-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830033643.51019-6-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 11:36:42AM +0800, Gao Xiang wrote:
> As Dan Carpenter suggested [1], I have to remove
> all erofs likely/unlikely annotations.

Do you have to remove all of them, or just those where you don't have
a particularly good reason why you think in this particular case they
might actually matter?
