Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994C4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D94A222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRSpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:45:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:54057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfKRSpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:45:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="204155531"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 10:45:33 -0800
Date:   Mon, 18 Nov 2019 10:50:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 07/10] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Message-ID: <20191118105008.02140761@jacob-builder>
In-Reply-To: <517dcd76-8bc6-45c0-6d0d-baec6b6d0d53@linux.intel.com>
References: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1573859377-75924-8-git-send-email-jacob.jun.pan@linux.intel.com>
        <517dcd76-8bc6-45c0-6d0d-baec6b6d0d53@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 09:43:00 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 11/16/19 7:09 AM, Jacob Pan wrote:
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > IOASID allocator is inclusive for both start and end of the
> > allocation range. The current code is based on IDR, which is
> > exclusive for the end of the allocation range. This patch fixes the
> > off-by-one error in intel_svm_bind_mm, where pasid_max - 1 is used
> > for the end of allocation range.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>  
> 
> Two nit comments in line. With that fixed,
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
Thanks, will fix below.
> Best regards,
> baolu
> 
>  [...]  
> 
> Nit - short line within 80 characters and align the new line with
> open parenthesis.
> 
>  [...]  
> 
> Nit - open parenthesis alignment.
> 
>  [...]  

[Jacob Pan]
