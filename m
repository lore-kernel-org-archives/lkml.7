Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A837CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A352084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392203AbfJXBPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:15:55 -0400
Received: from verein.lst.de ([213.95.11.211]:43058 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390315AbfJXBPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:15:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2D1F68BE1; Thu, 24 Oct 2019 03:15:53 +0200 (CEST)
Date:   Thu, 24 Oct 2019 03:15:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 2/7] nvmet-tcp: Don't set the request's data_len
Message-ID: <20191024011553.GB5190@lst.de>
References: <20191023163545.4193-1-logang@deltatee.com> <20191023163545.4193-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023163545.4193-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 10:35:40AM -0600, Logan Gunthorpe wrote:
> It's not apprporiate for the transports to set the data_len
> field of the request which is only used by the core.
> 
> In this case, just use a variable on the stack to store the
> length of the sgl for comparison.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
