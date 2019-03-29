Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D232184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfC2Ciq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:38:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:53153 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfC2Ciq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:38:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 19:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="126827275"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 19:38:43 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
To:     Christoph Hellwig <hch@infradead.org>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
 <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
 <20190328161134.GA27879@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f1d6340e-88d8-3286-2f23-44094563c1c7@linux.intel.com>
Date:   Fri, 29 Mar 2019 10:33:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328161134.GA27879@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/19 12:11 AM, Christoph Hellwig wrote:
> On Thu, Mar 28, 2019 at 02:33:04PM +0800, Lu Baolu wrote:
>> For the swiotlb APIs, I am thinking about keeping current APIs untouched
>> and adding below new ones for bounce page.
> 
> In the lon run I'd like tow avoid duplicate APIs, especially as the
> current low-level swiotlb APIs only two callers.  But please go ahead
> with the new APIs for now, I will try to see if we can do something
> on top later.
> 

Sure.

Best regards,
Lu Baolu
