Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0BC2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCBI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:29:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:34836 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfCBI3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 03:29:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 00:29:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,431,1544515200"; 
   d="scan'208";a="148628286"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 02 Mar 2019 00:29:29 -0800
Received: by lahna (sSMTP sendmail emulation); Sat, 02 Mar 2019 10:29:28 +0200
Date:   Sat, 2 Mar 2019 10:29:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Disable ATS support on untrusted devices
Message-ID: <20190302082928.GX4511@lahna.fi.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
 <20190301032313.9311-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301032313.9311-2-baolu.lu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:23:10AM +0800, Lu Baolu wrote:
> Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
> devices") disables ATS support on the devices which have been marked
> as untrusted. Unfortunately this is not enough to fix the DMA attack
> vulnerabiltiies because IOMMU driver allows translated requests as
> long as a device advertises the ATS capability. Hence a malicious
> peripheral device could use this to bypass IOMMU.
> 
> This disables the ATS support on untrusted devices by clearing the
> internal per-device ATS mark. As the result, IOMMU driver will block
> any translated requests from any device marked as untrusted.
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
