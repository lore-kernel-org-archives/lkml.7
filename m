Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFA9206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:50:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:46234 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZMuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:50:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 05:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="341047301"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2019 05:50:32 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1hK0JD-00042T-IW; Fri, 26 Apr 2019 15:50:31 +0300
Date:   Fri, 26 Apr 2019 15:50:31 +0300
From:   Andriy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux@endlessm.com
Subject: Re: [PATCH v3] pinctrl:intel: Retain HOSTSW_OWN for requested gpio
 pin
Message-ID: <20190426125031.GQ9224@smile.fi.intel.com>
References: <20190415055358.9269-1-chiu@endlessm.com>
 <CACRpkdanhW206AEj7m+2FQBhJ5epUzw60Y6v+k-eoJLLW_-SSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdanhW206AEj7m+2FQBhJ5epUzw60Y6v+k-eoJLLW_-SSQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:38:17PM +0200, Linus Walleij wrote:
> On Mon, Apr 15, 2019 at 7:54 AM Chris Chiu <chiu@endlessm.com> wrote:
> 
> > The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
> > responsive after suspend/resume. The following error message
> > shows after resume.
> >  i2c_hid i2c-ELAN1200:00: failed to reset device.
> >
> > On these laptops, the touchpad interrupt is connected via a GPIO
> > pin which is controlled by Intel pinctrl. After system resumes,
> > the GPIO is in ACPI mode and no longer works as an IRQ.
> >
> > This commit saves the HOSTSW_OWN value during suspend, make sure
> > the HOSTSW_OWN mode remains the same after resume.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> 
> This v3 patch applied with Mika's ACK.

Hmm... It's supposed to go along with our PR.

-- 
With Best Regards,
Andy Shevchenko


