Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E00C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63CD20730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKRLuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:50:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:17761 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRLuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:50:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 03:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="204047463"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 03:50:20 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iWfXv-00012e-PD; Mon, 18 Nov 2019 13:50:19 +0200
Date:   Mon, 18 Nov 2019 13:50:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J., Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] gpio: sch: Add interrupt support
Message-ID: <20191118115019.GW32742@smile.fi.intel.com>
References: <046793ee-ba51-6a1b-1aa5-14560d849df7@siemens.com>
 <20190429131900.GD9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429131900.GD9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:19:00PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 29, 2019 at 07:55:52AM +0200, Jan Kiszka wrote:
> > Validated on the Quark platform, this adds interrupt support on rising
> > and/or falling edges.
> 
> Can we split it to two:
> - Add IRQ support on edge
> - Add ACPI handler (with explanation in the commit message why we do like this,
>   based on the thread from v1)
> 
> ?

Jan, anything you would like to do with this or is it abandoned?

-- 
With Best Regards,
Andy Shevchenko


