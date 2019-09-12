Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647AC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D602075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="asDt2qez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbfILMRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:17:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfILMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hc4pr/JgOy8jge1sULbZMWg1OXydBU1WsUPv7831t4U=; b=asDt2qezyg+T7KO3RqFIU5Nr8
        HAh9g7yO3V9DqeenDcb1NJOtekvqnlAUigcLmAZHgHCxv6ywixvMIVuSoDFxY5JnSQ6TpXdreb5BB
        Tx9wqCcvzXgxhDmyCW0XW2ZE77irAHhbW93bViqYhBe+Cw03/MYqVLQRdtHFwaevhEFCkr6sOh3pm
        5EPTIlU4AflqwXpAt9RfZMqqh64FDzFJnBe/GVZ1mppcdVydHn7AkdOd3GhEYMz4w85J1hwDFIVWv
        aSuoFTcEPICHlG7QLLXtWwY2kxCl6WIYk1j5MFzRYaqKdmtbf4MZRSmn9w1HtXz7N5gI7fZlah+Xn
        BJNhWlCfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8O27-0004Uq-Gs; Thu, 12 Sep 2019 12:17:07 +0000
Date:   Thu, 12 Sep 2019 05:17:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
Message-ID: <20190912121707.GA16029@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
 <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void append_badrange_entry(struct badrange *badrange,
> -		struct badrange_entry *bre, u64 addr, u64 length)
> +				  struct badrange_entry *bre, u64 addr, u64 length)

Please stop sending this kind of crap.  Two tabs are a very common
style used in a lot of the kernel, and some people actually prefer it.

Instead of arguing what is better just stick to what the surrounding
code does.

Or in other words:  Feel free to be a codingstyle nazi for your code
(I am for some of mine), but leave others peoples code alone with
"cleanup" patches.
