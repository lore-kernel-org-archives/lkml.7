Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F10C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5B5216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393691AbfIJOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:53:26 -0400
Received: from 8bytes.org ([81.169.241.247]:53878 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbfIJOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 04377BDE; Tue, 10 Sep 2019 16:53:24 +0200 (CEST)
Date:   Tue, 10 Sep 2019 16:53:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/5] iommu: Bounce page for untrusted devices
Message-ID: <20190910145322.GB24103@8bytes.org>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906061452.30791-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:14:47PM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   swiotlb: Split size parameter to map/unmap APIs
>   iommu/vt-d: Check whether device requires bounce buffer
>   iommu/vt-d: Don't switch off swiotlb if bounce page is used
>   iommu/vt-d: Add trace events for device dma map/unmap
>   iommu/vt-d: Use bounce buffer for untrusted devices
> 
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/iommu/Kconfig                         |   1 +
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/intel-iommu.c                   | 310 +++++++++++++++++-
>  drivers/iommu/intel-trace.c                   |  14 +
>  drivers/xen/swiotlb-xen.c                     |   8 +-
>  include/linux/swiotlb.h                       |   8 +-
>  include/trace/events/intel_iommu.h            | 106 ++++++
>  kernel/dma/direct.c                           |   2 +-
>  kernel/dma/swiotlb.c                          |  30 +-
>  10 files changed, 449 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/iommu/intel-trace.c
>  create mode 100644 include/trace/events/intel_iommu.h

Applied, thanks.
