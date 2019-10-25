Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8415BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437436AbfJYHzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:55:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:50101 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437406AbfJYHzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:55:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 00:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="188853263"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2019 00:55:41 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNuRg-0001jo-Ru; Fri, 25 Oct 2019 10:55:40 +0300
Date:   Fri, 25 Oct 2019 10:55:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
Message-ID: <20191025075540.GD32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025075335.GC32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:53:35AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> > This patchset introduces additional regulator driver for Intel Cherry
> > Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> > PMIC, which is used to instantiate this regulator.
> > 
> > Regulator support for this PMIC was present in kernel release from Intel
> > targeted Aero platform, but was not entirely ported upstream and has
> > been omitted in mainline kernel releases. Consecutively, absence of
> > regulator caused the SD Card interface not to be provided with Vqcc
> > voltage source needed to operate with UHS-I cards.
> > 
> > Following patches are addessing this issue and making sd card interface
> > to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> > of the SD Card interface in consumers and exposes optional "vqmmc"
> > voltage source, which mmc driver uses to switch signalling voltages
> > between 1.8V and 3.3V. 
> > 
> > This set contains of 2 patches: one is implementing the regulator driver
> > (based on a non upstreamed version from Intel Aero), and another patch
> > registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> 
> Thank you.
> Hans, Cc'ed, has quite interested in these kind of patches.
> Am I right, Hans?

Since it's about UHS/SD, Cc to Adrian as well.

-- 
With Best Regards,
Andy Shevchenko


