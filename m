Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF31C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218B720651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfDOTZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:33527 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfDOTZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:25:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 12:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="164965520"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 15 Apr 2019 12:25:10 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 15 Apr 2019 22:25:09 +0300
Date:   Mon, 15 Apr 2019 22:25:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     andriy.shevchenko@intel.com, heikki.krogerus@linux.intel.com,
        drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH v3] pinctrl:intel: Retain HOSTSW_OWN for requested gpio
 pin
Message-ID: <20190415192509.GH2654@lahna.fi.intel.com>
References: <20190415055358.9269-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415055358.9269-1-chiu@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 01:53:58PM +0800, Chris Chiu wrote:
> The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
> responsive after suspend/resume. The following error message
> shows after resume.
>  i2c_hid i2c-ELAN1200:00: failed to reset device.
> 
> On these laptops, the touchpad interrupt is connected via a GPIO
> pin which is controlled by Intel pinctrl. After system resumes,
> the GPIO is in ACPI mode and no longer works as an IRQ.
> 
> This commit saves the HOSTSW_OWN value during suspend, make sure
> the HOSTSW_OWN mode remains the same after resume.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
