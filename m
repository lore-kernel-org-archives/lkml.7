Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAF12053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDZOf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:35:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:51728 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:35:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP; 26 Apr 2019 07:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="146091844"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2019 07:35:23 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK1wf-0005O5-L1; Fri, 26 Apr 2019 17:35:21 +0300
Date:   Fri, 26 Apr 2019 17:35:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@geanix.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: 8250: Add support for 8250/16550 as MFD
 function
Message-ID: <20190426143521.GW9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426084038.6377-1-esben@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:40:36AM +0200, Esben Haabendal wrote:
> This series adds a driver for adding 8250/16550 UART ports as functions to
> MFD devices.
> 

The patch 2/2 disappeared.

> Esben Haabendal (2):
>   serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
>   serial: 8250: Add support for 8250/16550 as MFD function
> 
>  drivers/tty/serial/8250/8250_core.c |  36 ++++++-----
>  drivers/tty/serial/8250/8250_mfd.c  | 119 ++++++++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig     |  12 ++++
>  drivers/tty/serial/8250/Makefile    |   1 +
>  include/linux/serial_8250.h         |   2 +
>  5 files changed, 155 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/tty/serial/8250/8250_mfd.c
> 
> -- 
> 2.4.11
> 

-- 
With Best Regards,
Andy Shevchenko


