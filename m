Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC1AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2910206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfG2NXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:23:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:11886 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387413AbfG2NXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:23:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 06:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="182744433"
Received: from mylly.fi.intel.com (HELO [10.237.72.159]) ([10.237.72.159])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 06:23:39 -0700
Subject: Re: [PATCH] i2c: busses: Use dev_get_drvdata where possible
To:     Jean Delvare <jdelvare@suse.de>,
        Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723111110.11121-1-hslester96@gmail.com>
 <20190723203452.5714f142@endymion>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <c58ef749-fae3-8df5-2d20-59d766256409@linux.intel.com>
Date:   Mon, 29 Jul 2019 16:23:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723203452.5714f142@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 9:34 PM, Jean Delvare wrote:
> On Tue, 23 Jul 2019 19:11:10 +0800, Chuhong Yuan wrote:
>> Instead of using to_pci_dev + pci_get_drvdata,
>> use dev_get_drvdata to make code simpler.
>>
>> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-pcidrv.c | 6 ++----
>>   drivers/i2c/busses/i2c-i801.c              | 3 +--
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>> (...)
> 
> Looks good to me, thanks.
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
For the i2c-designware-pcidrv.c

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
