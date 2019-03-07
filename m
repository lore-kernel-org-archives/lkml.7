Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3424C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB50D204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCGHHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:07:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:50311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfCGHHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:07:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP; 06 Mar 2019 23:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="150071980"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 06 Mar 2019 23:06:58 -0800
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h1n7J-0003ZS-9C; Thu, 07 Mar 2019 09:06:57 +0200
Date:   Thu, 7 Mar 2019 09:06:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Darren Hart (VMware)" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>, andy@infradead.org
Subject: Re: [PATCH] MAINTAINERS: Include mlxreg.h in Mellanox Platform
 Driver files
Message-ID: <20190307070657.GB9224@smile.fi.intel.com>
References: <b0b6ac4eee58fbda83574f020d89651a12a8e40f.1551937716.git.dvhart@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b6ac4eee58fbda83574f020d89651a12a8e40f.1551937716.git.dvhart@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:50:32PM -0800, Darren Hart (VMware) wrote:
> Avoid conflicts from other subsystems by including the header with the
> rest of the driver files.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51029a425dbe..eb0b9aba4802 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9711,6 +9711,7 @@ M:	Vadim Pasternak <vadimp@mellanox.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Supported
>  F:	drivers/platform/mellanox/
> +F:	include/linux/platform_data/mlxreg.h
>  
>  MELLANOX MLX4 core VPI driver
>  M:	Tariq Toukan <tariqt@mellanox.com>
> -- 
> 2.17.2
> 
> 
> -- 
> Darren Hart
> VMware Open Source Technology Center

-- 
With Best Regards,
Andy Shevchenko


