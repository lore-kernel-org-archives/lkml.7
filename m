Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD01C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259FB20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDHRXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:23:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:15103 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfDHRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:23:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 10:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="141056435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2019 10:23:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hDXzd-0001sX-9T; Mon, 08 Apr 2019 20:23:37 +0300
Date:   Mon, 8 Apr 2019 20:23:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     mika.westerberg@linux.intel.com, heikki.krogerus@linux.intel.com,
        drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH v2] pinctrl:intel: Retain HOSTSW_OWN for requested gpio
 pin
Message-ID: <20190408172337.GY9224@smile.fi.intel.com>
References: <20190408095127.6197-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408095127.6197-1-chiu@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 05:51:27PM +0800, Chris Chiu wrote:
> The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
> responsive after suspend/resume. The following error message
> shows after resume.
>  i2c_hid i2c-ELAN1200:00: failed to reset device.
> 
> On these laptops, the touchpad interrupt is connected via a GPIO
> pin which is controlled by Intel pinctrl. After system resumes,
> the GPIO is in ACPI mode and no longer works as an IRQ.
> 
> This commit saves the HOSTSW_OWN value during suspend, make sure
> the HOSTSW_OWN mode remains the same after resume.

Some comments as per v1 are still applicable to this version.

-- 
With Best Regards,
Andy Shevchenko


