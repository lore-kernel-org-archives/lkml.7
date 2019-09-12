Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284DC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39F5214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfILN6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:58:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:45955 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731474AbfILN6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:58:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 06:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,497,1559545200"; 
   d="scan'208";a="210032661"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2019 06:58:08 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i8Pbq-0005t1-Rj; Thu, 12 Sep 2019 16:58:06 +0300
Date:   Thu, 12 Sep 2019 16:58:06 +0300
From:   Andriy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 0/2] pinctrl: Add new pinctrl/GPIO driver
Message-ID: <20190912135806.GA2680@smile.fi.intel.com>
References: <cover.1568274587.git.rahul.tanwar@linux.intel.com>
 <CACRpkdb7bPo7oH9w5OhAsOoQXx=MWjJELd5JvBt3R1sPdMjnpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb7bPo7oH9w5OhAsOoQXx=MWjJELd5JvBt3R1sPdMjnpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:11:32AM +0100, Linus Walleij wrote:
> Hi Rahul,
> 
> thanks for your patches!
> 
> On Thu, Sep 12, 2019 at 8:59 AM Rahul Tanwar
> <rahul.tanwar@linux.intel.com> wrote:
> 
> > This series is to add pinctrl & GPIO controller driver for a new SoC.
> > Patch 1 adds pinmux & GPIO controller driver.
> > Patch 2 adds the dt bindings document & include file.
> >
> > Patches are against Linux 5.3-rc5 at below Git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> 
> OK nice, I think you need to include Mika Westerberg on this review
> as well, because I think he likes to stay on top of all things intel
> in pin control. (Also included two other Intel folks in Finland who usually
> take an interest in these things.)

Linus,
nevertheless I guess you may give your comments WRT device tree use
(bindings, helpers, etc) along with some basics, (like devm_*()
[ab]use I just noticed).

-- 
With Best Regards,
Andy Shevchenko


