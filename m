Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6725C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7203920857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDIRjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:39:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:57576 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfDIRjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:39:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 10:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="162794328"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2019 10:39:40 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDuih-0006Oa-G8; Tue, 09 Apr 2019 20:39:39 +0300
Date:   Tue, 9 Apr 2019 20:39:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>, junxiao.chang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] platform/x86: intel_pmc_ipc: Use BIT() macro
Message-ID: <20190409173939.GY9224@smile.fi.intel.com>
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
 <7bb60283-f99f-679d-4efa-45962ccd68f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb60283-f99f-679d-4efa-45962ccd68f3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:07:35AM -0700, sathyanarayanan kuppuswamy wrote:
> On 4/9/19 4:25 AM, Andy Shevchenko wrote:
> > Use BIT() and BIT_MASK() macros for definitions.
> Looks good to me.

Thanks!

> >   /* PMC register bit definitions */
> >   /* PMC_CFG_REG bit masks */
> > -#define PMC_CFG_NO_REBOOT_MASK		(1 << 4)
> > +#define PMC_CFG_NO_REBOOT_MASK		BIT_MASK(4)
> >   #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
> >   #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
> Do we need 0 << 4 ?

Yes, to explicitly show that this is a value for NO_REBOOT masked bit(s)
(single bit in this case).

-- 
With Best Regards,
Andy Shevchenko


