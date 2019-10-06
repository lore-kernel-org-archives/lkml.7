Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DDECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE12087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 22:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJFWex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 18:34:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:52159 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfJFWex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 18:34:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Oct 2019 15:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="192937257"
Received: from dnlarsen-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.3.159])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2019 15:34:48 -0700
Date:   Mon, 7 Oct 2019 01:34:47 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v7 5/6] tpm: tpm_tis_spi: Cleanup includes
Message-ID: <20191006223447.GB8860@linux.intel.com>
References: <20190920183240.181420-1-swboyd@chromium.org>
 <20190920183240.181420-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920183240.181420-6-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:32:39AM -0700, Stephen Boyd wrote:
> Some of these includes aren't used, for example of_gpio.h and freezer.h,
> or they are missing, for example kernel.h for min_t() usage. Add missing
> headers and remove unused ones so that we don't have to expand all these
> headers into this file when they're not actually necessary.
> 
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
