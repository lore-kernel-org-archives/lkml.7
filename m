Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED0EC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CF621738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfDEKHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:07:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:12846 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfDEKHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:07:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 03:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="146826188"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2019 03:07:04 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hCLkV-0006YX-OE; Fri, 05 Apr 2019 13:07:03 +0300
Date:   Fri, 5 Apr 2019 13:07:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
Message-ID: <20190405100703.GX9224@smile.fi.intel.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
 <271a33ae-b4fc-0528-cf59-5053dc46cce0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271a33ae-b4fc-0528-cf59-5053dc46cce0@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:04:04PM +0800, YueHaibing wrote:
> +cc Rafael and linux-acpi

Yeah, but please, address my comments and send v2.

-- 
With Best Regards,
Andy Shevchenko


