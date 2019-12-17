Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40FCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910B3207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLQL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:58:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:25876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLQL6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:58:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:58:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="209669568"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 03:58:18 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ihBUY-0001wt-Nh; Tue, 17 Dec 2019 13:58:18 +0200
Date:   Tue, 17 Dec 2019 13:58:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: crc64: include <linux/crc64.h> for 'crc64_be'
Message-ID: <20191217115818.GA32742@smile.fi.intel.com>
References: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
 <20191217115703.GZ32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217115703.GZ32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:57:03PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 17, 2019 at 11:26:33AM +0000, Ben Dooks (Codethink) wrote:
> > The crc64_be() is declared in <linux/crc64.h> so include
> > this where the symbol is defined to avoid the following
> > warning:
> > 
> > lib/crc64.c:43:12: warning: symbol 'crc64_be' was not declared. Should it be static?
> 
> Thanks!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, one nit to be addressed...


> > Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> > ---
> > Cc: Coly Li <colyli@suse.de>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  lib/crc64.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/crc64.c b/lib/crc64.c
> > index 0ef8ae6ac047..f8928ce28280 100644
> > --- a/lib/crc64.c
> > +++ b/lib/crc64.c
> > @@ -28,6 +28,7 @@
> >  
> >  #include <linux/module.h>
> >  #include <linux/types.h>

> > +#include <linux/crc64.h>

May we preserve ordering, i.e. it should be first header in the block.

> >  #include "crc64table.h"
> >  
> >  MODULE_DESCRIPTION("CRC64 calculations");
> > -- 
> > 2.24.0
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


