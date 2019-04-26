Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2A02067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDZNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:06:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:18426 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfDZNGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:06:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 06:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="341050813"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2019 06:06:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK0YR-0004Hm-KL; Fri, 26 Apr 2019 16:06:15 +0300
Date:   Fri, 26 Apr 2019 16:06:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Message-ID: <20190426130615.GT9224@smile.fi.intel.com>
References: <20190424081802.GV2654@lahna.fi.intel.com>
 <5a28f22c-22f7-760a-d076-68ff19800d44@siemens.com>
 <20190424084259.GW2654@lahna.fi.intel.com>
 <7e328b7e-f4f0-851a-4152-a9ffd058201c@siemens.com>
 <20190424094506.GA2654@lahna.fi.intel.com>
 <292e6eff-82cc-6e4d-925b-77a60399e2e0@siemens.com>
 <20190424100130.GB2654@lahna.fi.intel.com>
 <1200464b-f969-ebc2-ae82-1f8ca98aaca1@siemens.com>
 <20190424103306.GC2654@lahna.fi.intel.com>
 <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9377620b-d74a-04d9-a51e-8590400b1c0f@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:39:35PM +0200, Jan Kiszka wrote:
> On 24.04.19 12:33, Mika Westerberg wrote:
> > On Wed, Apr 24, 2019 at 12:19:02PM +0200, Jan Kiszka wrote:

> > > And even if that were possible, we would be back to the square of existing
> > > devices without those definitions. If this were a recent chipset, I would
> > > say, "go, fix future firmware versions". But this one is legacy.
> > 
> > Is it fixing some real issue with these legacy platforms? I mean without
> > the patch some GPE event is not handled properly? It was not clear to me
> > from the commit message.
> > 
> 
> Without that patch, you are forced to poll for event changes in your
> application, timer-driven. There are application that cannot process these
> GPIOs because they lack such logic (mraa with node-red-node-intel-gpio is a
> public example).

Just a side note: MRAA is a hack itself. It abuses almost all interfaces Linux
kernel provides.

-- 
With Best Regards,
Andy Shevchenko


