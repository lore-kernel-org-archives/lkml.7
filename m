Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E73C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5258B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfDBNbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:31:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:50358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:31:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 06:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="158027406"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2019 06:31:45 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH 1/2] firmware: Intel: Add Stratix10 ECC DBE SMC call
To:     Borislav Petkov <bp@alien8.de>
Cc:     mchehab@kernel.org, james.morse@arm.com, atull@kernel.org,
        richard.gong@intel.com, gregkh@linuxfoundation.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553870639-23895-1-git-send-email-thor.thayer@linux.intel.com>
 <20190402085529.GC6826@zn.tnic>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <b250c876-11d8-5558-9650-d75061d67919@linux.intel.com>
Date:   Tue, 2 Apr 2019 08:34:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402085529.GC6826@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 3:55 AM, Borislav Petkov wrote:
> On Fri, Mar 29, 2019 at 09:43:58AM -0500, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Reserve ECC Double Bit Error SMC call to alert U-Boot that
>> a DBE has occurred. Moving the call from local EDAC header
>> file to this common file.
> 
> Is there any particular reason this needs to be two patches or can I
> merge them into one?
> 

Yes, they can be merged into one. I split into 2 patches since the 1st 
required the firmware directory sign-off and the 2nd required your EDAC 
sign-off. I see your point, it could have been 1 patch.

Thanks for reviewing,

Thor
