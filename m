Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B704220850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfCYLp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:45:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:33946 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbfCYLp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:45:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 04:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="129964529"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2019 04:45:23 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8O2c-000570-Df; Mon, 25 Mar 2019 13:45:22 +0200
Date:   Mon, 25 Mar 2019 13:45:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hendychu@aliyun.com
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190325114522.GN9224@smile.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net>
 <20190322190610.GB9224@smile.fi.intel.com>
 <ca34b30a-c989-d6df-8d6a-93ea1746e920@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca34b30a-c989-d6df-8d6a-93ea1746e920@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:36:26AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 22.03.19 20:06, Andy Shevchenko wrote:
> > On Fri, Mar 22, 2019 at 07:32:28PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> On 21.03.19 10:23, Andy Shevchenko wrote:
> >>
> >>> ...and on top of that GPIO sysfs interface is deprecated.
> >>
> >> I don't like the idea of deprecating this. It might not be enough for
> >> all usecases, but for a lot of usecases, it's a very easy and simple
> >> interfaces.
> > 
> > So, you probably late for more than year. Linus W. and others discussed that
> > a lot and the points of the choice are listed in documentation IIRC.
> 
> If "deprecated" means there just won't be any new features, but
> everything remains as it is, I can live w/ that. But But having to
> rewrite lots of applications in the field for the new interface would
> be really bad.

If you don't want to have new features and OK with broken behaviour, yes,
that's fine.

> Note that the dev interface is *much* more complex than the sysfs one.
> For example, it needs ioctl()s, so this can't be done just w/ a few
> lines of shellscript anymore. (which is very common in many embedded
> devices)

I do it with a shell script, hint: libgpiod is a part of almost all alive Linux
distributions.

P.S. I don't think I would continue wasting time on the topic, since there is
nothing proposed how to improve the case.

-- 
With Best Regards,
Andy Shevchenko


