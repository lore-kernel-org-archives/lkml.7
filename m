Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C15FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDD52063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfDJR45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:56:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:1638 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfDJR44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:56:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 10:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="134637799"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 10:56:56 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id E89705807A6;
        Wed, 10 Apr 2019 10:56:55 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/4] platform/x86: intel_pmc_ipc: Use BIT() macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>, junxiao.chang@intel.com,
        linux-kernel@vger.kernel.org
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
 <7bb60283-f99f-679d-4efa-45962ccd68f3@linux.intel.com>
 <20190409173939.GY9224@smile.fi.intel.com>
 <20190410135913.GK9224@smile.fi.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f78c610a-7ae7-0a5c-c58c-ec2b597b7e6c@linux.intel.com>
Date:   Wed, 10 Apr 2019 10:55:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410135913.GK9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/19 6:59 AM, Andy Shevchenko wrote:
> On Tue, Apr 09, 2019 at 08:39:39PM +0300, Andy Shevchenko wrote:
>> On Tue, Apr 09, 2019 at 10:07:35AM -0700, sathyanarayanan kuppuswamy wrote:
>>> On 4/9/19 4:25 AM, Andy Shevchenko wrote:
>>>> Use BIT() and BIT_MASK() macros for definitions.
>>> Looks good to me.
>> Thanks!
> If you have no further comments, can you provide your tag here?
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
>
>>>>    /* PMC register bit definitions */
>>>>    /* PMC_CFG_REG bit masks */
>>>> -#define PMC_CFG_NO_REBOOT_MASK		(1 << 4)
>>>> +#define PMC_CFG_NO_REBOOT_MASK		BIT_MASK(4)
>>>>    #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
>>>>    #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
>>> Do we need 0 << 4 ?
>> Yes, to explicitly show that this is a value for NO_REBOOT masked bit(s)
>> (single bit in this case).
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
>>
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

