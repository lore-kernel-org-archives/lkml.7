Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886BBC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D34B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 05:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UXJaHY/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfGSFPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 01:15:48 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6452 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSFPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:15:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3152090000>; Thu, 18 Jul 2019 22:15:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jul 2019 22:15:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jul 2019 22:15:46 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 05:15:46 +0000
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
To:     Ira Weiny <ira.weiny@intel.com>, <john.hubbard@gmail.com>
CC:     <pavel@ucw.cz>, <SCheung@nvidia.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.vnet.ibm.com>, <benh@kernel.crashing.org>,
        <bsingharora@gmail.com>, <dan.j.williams@intel.com>,
        <dnellans@nvidia.com>, <ebaskakov@nvidia.com>,
        <hannes@cmpxchg.org>, <jglisse@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <liubo95@huawei.com>, <mhairgrove@nvidia.com>, <mhocko@kernel.org>,
        <paulmck@linux.vnet.ibm.com>, <ross.zwisler@linux.intel.com>,
        <sgutti@nvidia.com>, <torvalds@linux-foundation.org>,
        <vdavydov.dev@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719043439.GA26230@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8428df79-94cc-cd17-1a48-c0e4b2202020@nvidia.com>
Date:   Thu, 18 Jul 2019 22:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719043439.GA26230@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563513353; bh=VdrNvSRBFELFK33ytn5kbidh/QHSLYPE/i2QNziYCLA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UXJaHY/FT+BnMPc015XGl2/LQGokhkp4NTsZXg0h2tgOPgcUT+0u16dM5EKAOq6CT
         ErjzrgGNxlW5J+4dmXiqIDGflpOu18927t/ePslvWtMvvwvtXOueaErvyooCjGVIDJ
         IrrHw1AXB2DjlP24qpuWOkTFH7IUOMjkDAqn2OtrbOGtlEz/AuZbY2VJqLp7vebhhz
         5pYF3TAlS/4Bfk30AvNqpWM21Yv7mA2ou9B7LI4gJ8DBGMTRUbyDBbmDrmQJ5/4MN9
         2gjWYy12o5EEXsMgsLOBWFnFybnLPpZwK8mCs//N69DayBt7YzYpBKGZLS3cVpP1l8
         9zZCqEFxz0o2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/19 9:34 PM, Ira Weiny wrote:
> On Thu, Jul 18, 2019 at 06:32:53PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
...
>> +	  Select HMM_MIRROR if you have hardware that meets the above
>> +	  description. An early, partial list of such hardware is:
>> +	  an NVIDIA GPU >= Pascal, Mellanox IB >= mlx5, or an AMD GPU.
> 
> I don't think we want to put device information here.  If we want that
> information in Kconfig best to put it in the devices themselves.  Otherwise
> this list will get stale.
> 
> Other than that, looks good.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 

Hi Ira, thanks for the review, I'll remove that last sentence. I'll post a v2
with your reviewed by tag, in a new email thread. But first I'll wait to see 
if there are other replies.

thanks,
-- 
John Hubbard
NVIDIA
