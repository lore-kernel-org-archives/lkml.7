Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E4E2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NQuqs9yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfIPHIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:08:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfIPHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8KvjgvpB0tliOwRlNgu9kfQS7Ox5dSnaO0U89tZHGOM=; b=NQuqs9yqPA4Q9D4/DHzCx89Wc
        7HTNu9ysGDnp2hsPL7Xka8MLU53zrYlCBlzj0HVfZrf9q5Sd5EhdyEzAIvv0tCneXrvCQl16yWTFN
        FJXpwMnJVs5xjMQ/ucfi1NZhm7WSRGajfkGiBWxZ9m04boDLEFqpcoZTagMpeLoGbUOO7aakzp451
        U5jI2MNXwByuOO9Ar6glN1Ooc0SLI+YMdaYQ8tWqxQFjnkcjLoSBsuw9MdIT5XrHeK1O/71MGFQnK
        Isr6yKzw3uvUTQT3fI9i2i32z/vrDmGmYrZ+DTSK+r2eJ4yBk/+H67s5INsLwGc5GoTpc6MZ8XPXn
        XAYRzPizg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9l75-0007Uj-FY; Mon, 16 Sep 2019 07:07:56 +0000
Date:   Mon, 16 Sep 2019 00:07:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
Message-ID: <20190916070755.GA22009@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
 <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
 <20190912121707.GA16029@infradead.org>
 <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 08:01:45AM -0700, Joe Perches wrote:
> On Thu, 2019-09-12 at 05:17 -0700, Christoph Hellwig wrote:
> > Instead of arguing what is better just stick to what the surrounding
> > code does.
> 
> That's not always feasible nor readable.
> 
> Especially for the logic inversion blocks where
> the existing code does unreadable and error prone
> things like hiding semicolons immediately after
> comments.
> 
> 	if (foo)
> 		/* longish comment */;
> 	else {
> 		<code>;
> 	}

Which has nothing to do with your patch.

> > Or in other words:  Feel free to be a codingstyle nazi for your code
> > (I am for some of mine), but leave others peoples code alone with
> > "cleanup" patches.
> 
> My point was to avoid documenting per-subsystem
> coding style rules.

It is called common sense.  In many cases different parts of the
subsystem might have slight variations.  Just stick to your
preferred style in the bounds of coding style.  Maintainers will
either remind you if they feel strongly that they have a slightly
different preference or just fix it up.  What we really don't need
need it whitespace cleanup patches in the micro variation area.
