Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC554C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010620706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXL0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:26:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:62275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfLXL0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:26:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 03:26:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,351,1571727600"; 
   d="scan'208";a="207573299"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.56]) ([10.254.215.56])
  by orsmga007.jf.intel.com with ESMTP; 24 Dec 2019 03:26:53 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaW9tbXUv?=
 =?UTF-8?Q?vt-d=3a_Don=27t_reject_nvme_host_due_to_scope_mismatch?=
To:     "Jim,Yan" <jimyan@baidu.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
Date:   Tue, 24 Dec 2019 19:26:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/12/24 16:18, Jim,Yan wrote:
>>>> For both cases, a quirk flag seems to be more reasonable, so that
>>>> unrelated devices will not be impacted.
>>>>
>>>> Best regards,
>>>> baolu
>>> Hi Baolu,
>>> 	Thanks for your advice. And I modify the patch as follow.
>> I just posted a patch for both NTG and NVME cases. Can you please take a look?
>> Does it work for you?
>>
>> Best regards,
>> baolu
>>
> I have tested your patch. It does work for me. But I prefer my second version, it is more flexible, and may use for similar unknown devices.
> 

I didn't get your point. Do you mind explaining why it's more flexible?

Best regards,
baolu
