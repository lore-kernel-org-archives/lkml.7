Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84599C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C122D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfHUFeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:34:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:18832 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfHUFeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:34:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 22:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="169308087"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2019 22:34:22 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 432D95803FA;
        Tue, 20 Aug 2019 22:34:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190820103133.53776-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190820135602.GN30120@smile.fi.intel.com>
 <20190820135921.GO30120@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <d9a793ae-e66c-a6ae-ab05-d253b8eb27d7@linux.intel.com>
Date:   Wed, 21 Aug 2019 13:34:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820135921.GO30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/8/2019 9:59 PM, Andy Shevchenko wrote:
> On Tue, Aug 20, 2019 at 04:56:02PM +0300, Andy Shevchenko wrote:
>> On Tue, Aug 20, 2019 at 06:31:33PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>> +#define DR_TY_50OHM(x)		((~(x) << 28) & DR_TY_MASK)
>> For consistency it should be
>>
>> #define DR_TY_SHIFT(x)		(((x) << 28) & DR_TY_MASK)
>>
>> with explanation about 50 Ohm in the code below.
>>> +	/* Drive impedance: 50 Ohm */
>> Nice, you have already a comment here. Just use DR_TY_SHIFT(1)
> It should be DR_TY_SHIFT(6) now since I dropped the negation.

Thanks Andy, will update the review comments.

Best Regards
Vadivel
