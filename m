Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A70C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0B32070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfFSLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:23:35 -0400
Received: from verein.lst.de ([213.95.11.211]:52806 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfFSLXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:23:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9FA61227A81; Wed, 19 Jun 2019 13:23:02 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:23:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Enable unit test infrastructure compile
 checks
Message-ID: <20190619112302.GA10534@lst.de>
References: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:52:27PM -0700, Dan Williams wrote:
> The infrastructure to mock core libnvdimm routines for unit testing
> purposes is prone to bitrot relative to refactoring of that core.
> Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
> This does not result in a functional unit test environment, it is only a
> helper for 0day to catch unit test build regressions.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I'm still curious what the point of hiding kernel code in tools/
is vs fully integrating it with the build system.
