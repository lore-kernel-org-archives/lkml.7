Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C70C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25F62087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfC0Mq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:46:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:34229 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0Mq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:46:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 05:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="218008761"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.64.67]) ([10.252.64.67])
  by orsmga001.jf.intel.com with ESMTP; 27 Mar 2019 05:46:55 -0700
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Mark local function static
To:     Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553632152-18888-1-git-send-email-linux@roeck-us.net>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <4554bd3e-fabb-44aa-fc82-52ec9cbf9b2c@linux.intel.com>
Date:   Wed, 27 Mar 2019 18:16:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553632152-18888-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27-Mar-19 1:59 AM, Guenter Roeck wrote:
> 0day reports:
>
> drivers/platform/x86/intel_pmc_core.c:833:5: sparse:
> 	symbol 'quirk_xtal_ignore' was not declared. Should it be static?

Looks good to me.

> Mark the function static since it is indeed only called locally.
>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> Fixes: 238f9c11351f ("platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/platform/x86/intel_pmc_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f2c621b55f49..9908d233305e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -828,7 +828,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
>    * the platform BIOS enforces 24Mhx Crystal to shutdown
>    * before PMC can assert SLP_S0#.
>    */
> -int quirk_xtal_ignore(const struct dmi_system_id *id)
> +static int quirk_xtal_ignore(const struct dmi_system_id *id)
>   {
>   	struct pmc_dev *pmcdev = &pmc;
>   	u32 value;
