Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096012085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbfCAJYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:24:06 -0500
Received: from 8bytes.org ([81.169.241.247]:56362 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfCAJYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:24:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2A13125A; Fri,  1 Mar 2019 10:24:05 +0100 (CET)
Date:   Fri, 1 Mar 2019 10:24:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: Several fixes for 5.1
Message-ID: <20190301092401.GA10516@8bytes.org>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:23:09AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This includes several small fixes. All are stable kernel irrelated.
> Please consider it for 5.1-rc1.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (4):
>   iommu/vt-d: Disable ATS support on untrusted devices
>   iommu/vt-d: Set context field after value initialized
>   iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
>   iommu/vt-d: Get domain ID before clear pasid entry

Applied, thanks.

