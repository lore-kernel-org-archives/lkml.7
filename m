Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0837620989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfEMTWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:22:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37988 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbfEMTWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:22:38 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hQGWw-0001t0-G1; Mon, 13 May 2019 13:22:35 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
Message-ID: <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
Date:   Mon, 13 May 2019 13:22:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org, jglisse@redhat.com, hch@lst.de, bhelgaas@google.com, ira.weiny@intel.com, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
> 
> 
> On 2019-05-07 5:55 p.m., Dan Williams wrote:
>> Changes since v1 [1]:
>> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
>>
>> - Refresh the p2pdma patch headers to match the format of other p2pdma
>>    patches (Bjorn)
>>
>> - Collect Ira's reviewed-by
>>
>> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> This series looks good to me:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> However, I haven't tested it yet but I intend to later this week.

I've tested libnvdimm-pending which includes this series on my setup and
everything works great.

Thanks,

Logan
