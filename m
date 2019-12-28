Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE51C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A904320CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfL1D1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 22:27:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:24092 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1D1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 22:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 19:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; 
   d="scan'208";a="243387313"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 19:27:22 -0800
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: trace: Extend map_sg trace event
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20191211014255.8020-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3e78f293-369b-3764-842f-7c1773b9e7b7@linux.intel.com>
Date:   Sat, 28 Dec 2019 11:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211014255.8020-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:42 AM, Lu Baolu wrote:
> Current map_sg stores trace message in a coarse manner. This
> extends it so that more detailed messages could be traced.
> 
> The map_sg trace message looks like:
> 
> map_sg: dev=0000:00:17.0 [1/9] dev_addr=0xf8f90000 phys_addr=0x158051000 size=4096
> map_sg: dev=0000:00:17.0 [2/9] dev_addr=0xf8f91000 phys_addr=0x15a858000 size=4096
> map_sg: dev=0000:00:17.0 [3/9] dev_addr=0xf8f92000 phys_addr=0x15aa13000 size=4096
> map_sg: dev=0000:00:17.0 [4/9] dev_addr=0xf8f93000 phys_addr=0x1570f1000 size=8192
> map_sg: dev=0000:00:17.0 [5/9] dev_addr=0xf8f95000 phys_addr=0x15c6d0000 size=4096
> map_sg: dev=0000:00:17.0 [6/9] dev_addr=0xf8f96000 phys_addr=0x157194000 size=4096
> map_sg: dev=0000:00:17.0 [7/9] dev_addr=0xf8f97000 phys_addr=0x169552000 size=4096
> map_sg: dev=0000:00:17.0 [8/9] dev_addr=0xf8f98000 phys_addr=0x169dde000 size=4096
> map_sg: dev=0000:00:17.0 [9/9] dev_addr=0xf8f99000 phys_addr=0x148351000 size=4096
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v5.6.

Thanks,
-baolu
