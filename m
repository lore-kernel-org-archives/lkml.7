Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E8C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695B2218FC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfHHHtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:49:02 -0400
Received: from verein.lst.de ([213.95.11.211]:44133 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHHtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:49:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B117968B02; Thu,  8 Aug 2019 09:48:58 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:48:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190808074858.GA30308@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com> <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de> <20190806154403.GA25050@lst.de> <1565191457.2323.41.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565191457.2323.41.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:24:17PM +0200, Lucas Stach wrote:
> I would suggest to place this line above the comment, as the comment
> only really applies to the return value. Other than this nitpick, this
> matches my understanding of the required changes, so:
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks, I've applied it with that fixed up.
