Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4356C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB61820857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDIKDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:03:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:24415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfDIKDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:03:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 03:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="335126563"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 03:03:17 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDnb1-0001WB-Tb; Tue, 09 Apr 2019 13:03:15 +0300
Date:   Tue, 9 Apr 2019 13:03:15 +0300
From:   Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
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
        Lu Baolu <baolu.lu@linux.intel.com>, Liu@smile.fi.intel.com,
        Yi L <yi.l.liu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 05/18] iommu: introduce device fault data
Message-ID: <20190409100315.GD9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554767973-30125-6-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:59:20PM -0700, Jacob Pan wrote:
> Device faults detected by IOMMU can be reported outside the IOMMU
> subsystem for further processing. This patch introduces
> a generic device fault data structure.
> 
> The fault can be either an unrecoverable fault or a page request,
> also referred to as a recoverable fault.
> 
> We only care about non internal faults that are likely to be reported
> to an external subsystem.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

JFYI: we have a Co-developed-by tag as well for better granularity of what
certain person/people did.

-- 
With Best Regards,
Andy Shevchenko


