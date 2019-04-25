Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF58AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC001206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDYOSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:18:49 -0400
Received: from verein.lst.de ([213.95.11.211]:34787 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfDYOSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:18:49 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C43A268B20; Thu, 25 Apr 2019 16:18:32 +0200 (CEST)
Date:   Thu, 25 Apr 2019 16:18:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        "kernel-janitors@vger.kernel.org H Hartley Sweeten" 
        <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove an unnecessary NULL check
Message-ID: <20190425141832.GA16643@lst.de>
References: <20190424142437.GA29490@mwanda> <20190424142743.GC20974@lst.de> <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3142dc82-1d4c-5f01-678e-628038d86bd6@mev.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:13:49PM +0100, Ian Abbott wrote:
> So for comedi_isadma, we can just replace the NULL with a pointer to a 
> static dummy device with a 24-bit coherent mask?

It should be converted to a proper isa_driver, so that it gets a real
struct device.
