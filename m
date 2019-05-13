Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA24C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EE2208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEMKuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:50:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:61314 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbfEMKuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:50:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:50:31 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2019 03:50:28 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hQ8XL-0000HW-1g; Mon, 13 May 2019 13:50:27 +0300
Date:   Mon, 13 May 2019 13:50:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Robin Murphy <robin.murphy@arm.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH 7/9] genirq/timings: Add selftest for circular array
Message-ID: <20190513105027.GQ9224@smile.fi.intel.com>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
 <20190513102953.16424-8-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513102953.16424-8-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 12:29:51PM +0200, Daniel Lezcano wrote:
> Due to the complexity of the code and the difficulty to debug it,
> let's add some selftests to the framework in order to spot issues or
> regression at boot time when the runtime testing is enabled for this
> subsystem.
> 
> This tests the circular buffer at the limits and validates:
>  - the encoding / decoding of the values
>  - the macro to browse the irq timings circular buffer
>  - the function to push data in the circular buffer

>  kernel/irq/timings.c | 119 +++++++++++++++++++++++++++++++++++++++++++

Is it possible to have it in a separate C-file?

> +config TEST_IRQ_TIMINGS
> +	bool "IRQ timings selftest"

> +	default n

This is already default.

> +	depends on IRQ_TIMINGS
> +	help
> +	  Enable this option to test the irq timings code on boot.
> +
> +	  If unsure, say N.

-- 
With Best Regards,
Andy Shevchenko


