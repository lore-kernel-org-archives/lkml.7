Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309BC20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfDYOdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:33:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYOdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:33:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95696A78;
        Thu, 25 Apr 2019 07:33:37 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4AAB3F5AF;
        Thu, 25 Apr 2019 07:33:35 -0700 (PDT)
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Yi L <yi.l.liu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
 <220a581e-0ee8-70e2-796b-b434594e4825@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <a2880e11-90fe-36d4-01ad-bf3c346c6d7f@arm.com>
Date:   Thu, 25 Apr 2019 15:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <220a581e-0ee8-70e2-796b-b434594e4825@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 14:21, Auger Eric wrote:
  We could add a
>> IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find it
>> weird to denote the validity of a bitfield using a separate bit.
>>
>> Given that three different series now rely on this, how about we send
>> the fault patches separately for v5.2?

Sorry I meant v5.3 - after the merge window

>> I pushed the recoverable fault
>> support applied on top of this, with the PERM_READ bit and cleaned up
>> kernel doc, to git://linux-arm.org/linux-jpb.git sva/api
> 
> my only concern is is it likely to be upstreamed without any actual
> user? In the positive, of course, I don't have any objection.

Possibly, I don't think my I/O page fault stuff for SVA is likely to get
in v5.3, it depends on one or two more patch sets. But your nested work
and Jacob's one may be in good shape for next version? I find it
difficult to keep track of the same patches in three different series.

Thanks,
Jean
