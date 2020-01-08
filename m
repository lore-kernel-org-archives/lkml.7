Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6148C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32D020692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAHQiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:38:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:47566 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgAHQiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:38:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211591690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 08:38:07 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipELP-0005Qp-W6; Wed, 08 Jan 2020 18:38:07 +0200
Date:   Wed, 8 Jan 2020 18:38:07 +0200
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
Subject: Re: [PATCH v2 02/36] platform/x86: intel_scu_ipcutil: Remove default
 y from Kconfig
Message-ID: <20200108163807.GV32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-3-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-3-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:27PM +0300, Mika Westerberg wrote:
> This driver is by no means essential for system to boot up so remove
> default y from it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/platform/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 27d5b40fb717..dd4326736d11 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -997,7 +997,6 @@ config INTEL_SCU_IPC
>  config INTEL_SCU_IPC_UTIL
>  	tristate "Intel SCU IPC utility driver"
>  	depends on INTEL_SCU_IPC
> -	default y
>  	---help---
>  	  The IPC Util driver provides an interface with the SCU enabling
>  	  low level access for debug work and updating the firmware. Say
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


