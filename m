Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A45C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76765208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfHNGL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:11:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34981 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfHNGL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:11:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20CAC68B02; Wed, 14 Aug 2019 08:11:51 +0200 (CEST)
Date:   Wed, 14 Aug 2019 08:11:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 5/5] memremap: provide a not device managed
 memremap_pages
Message-ID: <20190814061150.GA24835@lst.de>
References: <20190811081247.22111-1-hch@lst.de> <20190811081247.22111-6-hch@lst.de> <20190812145058.GA16950@in.ibm.com> <20190812150012.GA12700@lst.de> <20190813045611.GB16950@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813045611.GB16950@in.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:26:11AM +0530, Bharata B Rao wrote:
> Yes, this patchset works non-modular and with kvm-hv as module, it
> works with devm_memremap_pages_release() and release_mem_region() in the
> cleanup path. The cleanup path will be required in the non-modular
> case too for proper recovery from failures.

Can you check if the version here:

    git://git.infradead.org/users/hch/misc.git pgmap-remove-dev

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pgmap-remove-dev

works for you fully before I resend?

> 
> Regards,
> Bharata.
---end quoted text---
