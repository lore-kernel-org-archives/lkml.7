Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA42CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC55208CB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfIBNTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:19:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:19525 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfIBNTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:19:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="266020670"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 02 Sep 2019 06:19:21 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4mEq-0002PJ-W7; Mon, 02 Sep 2019 16:19:20 +0300
Date:   Mon, 2 Sep 2019 16:19:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] reset: Remove copy'n'paste redundancy in the comments
Message-ID: <20190902131920.GK2680@smile.fi.intel.com>
References: <20190819105252.81020-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819105252.81020-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:52:52PM +0300, Andy Shevchenko wrote:
> It seems the commit bb475230b8e5
> ("reset: make optional functions really optional")
> brought couple of redundant lines in the comments.
> 
> Drop them here.

Any comment on this?

> 
> Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/reset/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 213ff40dda11..2badff33a0db 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -334,7 +334,6 @@ EXPORT_SYMBOL_GPL(reset_control_reset);
>   * internal state to be reset, but must be prepared for this to happen.
>   * Consumers must not use reset_control_reset on shared reset lines when
>   * reset_control_(de)assert has been used.
> - * return 0.
>   *
>   * If rstc is NULL it is an optional reset and the function will just
>   * return 0.
> @@ -393,7 +392,6 @@ EXPORT_SYMBOL_GPL(reset_control_assert);
>   * After calling this function, the reset is guaranteed to be deasserted.
>   * Consumers must not use reset_control_reset on shared reset lines when
>   * reset_control_(de)assert has been used.
> - * return 0.
>   *
>   * If rstc is NULL it is an optional reset and the function will just
>   * return 0.
> -- 
> 2.23.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko


