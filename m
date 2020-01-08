Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DB8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BE020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgAHQqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:46:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:37069 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgAHQqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:46:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211594685"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 08:46:09 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipETB-0005XQ-FM; Wed, 08 Jan 2020 18:46:09 +0200
Date:   Wed, 8 Jan 2020 18:46:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 18/36] platform/x86: intel_pmc_ipc: Make
 intel_pmc_gcr_update() static
Message-ID: <20200108164609.GH32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-19-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-19-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:43PM +0300, Mika Westerberg wrote:
> This function is not called outside of intel_pmc_ipc.c so we can make it
> static instead.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h | 6 ------
>  drivers/platform/x86/intel_pmc_ipc.c | 3 +--
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index 9e7adcdbe031..3b2e8b461520 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -40,7 +40,6 @@ int intel_pmc_s0ix_counter_read(u64 *data);
>  int intel_pmc_gcr_read(u32 offset, u32 *data);
>  int intel_pmc_gcr_read64(u32 offset, u64 *data);
>  int intel_pmc_gcr_write(u32 offset, u32 data);
> -int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val);
>  
>  #else
>  
> @@ -81,11 +80,6 @@ static inline int intel_pmc_gcr_write(u32 offset, u32 data)
>  	return -EINVAL;
>  }
>  
> -static inline int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
> -{
> -	return -EINVAL;
> -}
> -
>  #endif /*CONFIG_INTEL_PMC_IPC*/
>  
>  #endif
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 5c1da2bb1435..9229c7a16536 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(intel_pmc_gcr_write);
>   *
>   * Return:	negative value on error or 0 on success.
>   */
> -int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
> +static int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
>  {
>  	u32 new_val;
>  	int ret = 0;
> @@ -339,7 +339,6 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
>  	spin_unlock(&ipcdev.gcr_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
>  
>  static int update_no_reboot_bit(void *priv, bool set)
>  {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


