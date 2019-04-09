Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3887C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FE02084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDIQbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:31:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:33162 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbfDIQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:31:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 09:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="147810650"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Apr 2019 09:31:38 -0700
Date:   Tue, 9 Apr 2019 09:34:13 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 09/18] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20190409093413.603b5333@jacob-builder>
In-Reply-To: <20190409100859.GF9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190409100859.GF9224@smile.fi.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 13:08:59 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 04:59:24PM -0700, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> > IOMMU driver should rely on the emulation software to allocate
> > and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> > register set to support this. This includes a capability register,
> > a virtual command register and a virtual response register. Refer
> > to section 10.4.42, 10.4.43, 10.4.44 for more information.
> > 
> > This patch adds the enlightened PASID allocation/free interfaces
> > via the virtual command register.  
> 
> > +	pr_debug("vcmd alloc pasid\n");  
> 
> Perhaps tracepoints should be in use?
> OTOH we have function tracer, so, this message in any case is a noise.
> And this is applicable to other similar cases.
> 

Agreed, I added that for debug purpose.

Thanks,

Jacob
