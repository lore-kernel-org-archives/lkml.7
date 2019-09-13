Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E0C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957DB20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfIMKYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:24:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:25166 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:24:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 03:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,500,1559545200"; 
   d="scan'208";a="210309025"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2019 03:24:11 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i8ikL-0001lD-Qu; Fri, 13 Sep 2019 13:24:09 +0300
Date:   Fri, 13 Sep 2019 13:24:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        John Garry <john.garry@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
Message-ID: <20190913102409.GF2680@smile.fi.intel.com>
References: <20190913050105.1132080-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913050105.1132080-1-hs@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:
> Use software emulated RS485 direction control to provide RS485 API
> 
> Currently it is not possible to use rs485 as pointer to
> rs485_config struct in struct uart_port is NULL in case we
> configure the port through device tree.

Thank you for the patch, few recommendations for the future submissions.

> Patch is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> commit:
> 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"

More reliably is to base on corresponding subsystem tree, i.e. tty-next for
this case.

> checkpatch output:
> $ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
> total: 0 errors, 0 warnings, 43 lines checked
> 
> 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.

There is no need to mention this. It's supposed that submitter did that
themselves.

When you gather people to send the patch to, I recommend to use some threshold,
e.g. `scripts/get_maintainer.pl --git --git-min-percent=67 ...`

-- 
With Best Regards,
Andy Shevchenko


