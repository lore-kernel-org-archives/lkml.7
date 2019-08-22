Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA4C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F0A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfHVA2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:28:23 -0400
Received: from verein.lst.de ([213.95.11.211]:42082 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHVA2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:28:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 149D468BFE; Thu, 22 Aug 2019 02:28:18 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:28:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ
 element size
Message-ID: <20190822002818.GA10391@lst.de>
References: <20190807075122.6247-1-benh@kernel.crashing.org> <20190807075122.6247-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807075122.6247-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:51:20PM +1000, Benjamin Herrenschmidt wrote:
> +#define NVME_NVM_ADMSQES	6
>  #define NVME_NVM_IOSQES		6
>  #define NVME_NVM_IOCQES		4

The NVM in the two defines here stands for the NVM command set,
so this should just be named NVME_ADM_SQES or so.  But except for this
the patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

So maybe Sagi can just fix this up in the tree.
