Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2EC2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfC1JL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:11:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:12899 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1JL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:11:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 02:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="155974846"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2019 02:11:53 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9R4h-0000Qc-U8; Thu, 28 Mar 2019 11:11:51 +0200
Date:   Thu, 28 Mar 2019 11:11:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20190328091151.GU9224@smile.fi.intel.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
 <20190327123314.GJ9224@smile.fi.intel.com>
 <20190328044004.GB3251@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328044004.GB3251@icarus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:40:04PM +0900, William Breathitt Gray wrote:
> On Wed, Mar 27, 2019 at 02:33:14PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 27, 2019 at 02:02:39PM +0900, William Breathitt Gray wrote:
> > > Replace verbose implementation in set_multiple callback with
> > > for_each_set_clump8 macro to simplify code and improve clarity.
> > 
> > > +	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
> > 
> > > +		bank = (chip->registers - 1) - (offset / 8);
> > 
> > Excessive parens, but it's minor.
> 
> Fair point, this could do without parens around (chip->registers - 1).

And around division too.

> Since this and renaming 'idx' to 'index' in find_bit.c are such a minor
> changes, I'll wait first to see if something else comes up to be fixed
> in this review. If so, I'll add these changes to the next version of
> this patchset.

It seems inline proposal would going to be implemented.

-- 
With Best Regards,
Andy Shevchenko


