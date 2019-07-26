Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C761C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBC220823
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGZMML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:12:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:30299 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZMML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:12:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 05:12:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="322024243"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 05:12:08 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hqz4x-0001ao-Fj; Fri, 26 Jul 2019 15:12:07 +0300
Date:   Fri, 26 Jul 2019 15:12:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v1 1/2] extcon: axp288: Add missed error check
Message-ID: <20190726121207.GU9224@smile.fi.intel.com>
References: <CGME20190725203413epcas5p115dbc8d8119e17e39c38e5fb847d3ac5@epcas5p1.samsung.com>
 <20190725203405.65523-1-andriy.shevchenko@linux.intel.com>
 <bf2b9870-8504-17da-50b8-b1414b7d9b39@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf2b9870-8504-17da-50b8-b1414b7d9b39@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:15:30AM +0900, Chanwoo Choi wrote:
> On 19. 7. 26. 오전 5:34, Andy Shevchenko wrote:
> > It seems from the very beginning the error check has been missed
> > in axp288_extcon_log_rsi(). Add it here.

> >  	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
> > +	if (ret < 0)
> > +		return;
> 
> It need to print error log because axp288_extcon_log_rsi() has the void'
> return type if there is no any error log, it is not possible to check
> the error status.

Makes sense.
Will add in v2.

P.S. You answered privately, I had returned Cc list back.

-- 
With Best Regards,
Andy Shevchenko


