Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27088C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03682206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfC0TWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:22:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:18072 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbfC0TWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:22:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 12:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="310925863"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2019 12:22:07 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9E7i-0002fO-1A; Wed, 27 Mar 2019 21:22:06 +0200
Date:   Wed, 27 Mar 2019 21:22:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190327192206.GQ9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
 <20190327093530.GH9224@smile.fi.intel.com>
 <20190327184526.GA11095@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327184526.GA11095@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:45:26PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 27, 2019 at 11:35:30AM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> > > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > > of USB, as previously. The higher level protocol is not publicly
> > > documented and hence has been reverse engineered. As a consequence there
> > > are still a number of unknown fields and commands. However, the known
> > > parts have been working well and received extensive testing and use.
> > > 
> > > In order for this driver to work, the proper SPI drivers need to be
> > > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > > reason enabling this driver in the config implies enabling the above
> > > drivers.
> > 
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > According to last changes this should be GPL-2.0-only
> 
> What "last changes"?  "GPL-2.0" is a totally valid SPDX identifier for
> the kernel.  Don't buy into the "-only" prefix crud that the newer SPDX
> version adopted for crazy reasons.  The in-kernel documentation lists
> the valid identifiers and the version of SPDX we are currently using.

Thanks for this clarification.

// offtopic

Bartosz, so, it seems my first mail has been a correct one: in-kernel
documentation clarifies things for kernel.

// offtopic

-- 
With Best Regards,
Andy Shevchenko


