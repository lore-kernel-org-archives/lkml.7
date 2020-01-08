Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A769920705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgAHRHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:07:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:39140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgAHRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:07:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="303609752"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2020 09:06:26 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEmp-0005m3-02; Wed, 08 Jan 2020 19:06:27 +0200
Date:   Wed, 8 Jan 2020 19:06:26 +0200
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
Subject: Re: [PATCH v2 36/36] MAINTAINERS: Update entry for Intel Broxton PMC
 driver
Message-ID: <20200108170626.GS32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-37-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-37-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:42:01PM +0300, Mika Westerberg wrote:
> The driver lives now under MFD so split the current entry into two parts
> and add me as co-maintainer of the Intel Broxton PMC driver. While there
> correct formatting of Zha Qipeng's email address.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  MAINTAINERS | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8982c6e013b3..11b8bb4e2867 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8280,6 +8280,13 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/intel_atomisp2_pm.c
>  
> +INTEL BROXTON PMC DRIVER
> +M:	Mika Westerberg <mika.westerberg@linux.intel.com>
> +M:	Zha Qipeng <qipeng.zha@intel.com>
> +S:	Maintained
> +F:	drivers/mfd/intel_pmc_bxt.c
> +F:	include/linux/mfd/intel_pmc_bxt.h
> +
>  INTEL C600 SERIES SAS CONTROLLER DRIVER
>  M:	Intel SCU Linux support <intel-linux-scu@intel.com>
>  M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> @@ -8488,13 +8495,11 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/intel_pmc_core*
>  
> -INTEL PMC/P-Unit IPC DRIVER
> -M:	Zha Qipeng<qipeng.zha@intel.com>
> +INTEL P-Unit IPC DRIVER
> +M:	Zha Qipeng <qipeng.zha@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> -F:	drivers/platform/x86/intel_pmc_ipc.c
>  F:	drivers/platform/x86/intel_punit_ipc.c
> -F:	arch/x86/include/asm/intel_pmc_ipc.h
>  F:	arch/x86/include/asm/intel_punit_ipc.h
>  
>  INTEL PMIC GPIO DRIVERS
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


