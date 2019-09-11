Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EDC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DAB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfIKRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:12:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:53505 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbfIKRMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:12:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 10:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,494,1559545200"; 
   d="scan'208";a="214751396"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2019 10:12:47 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i86Ah-0001yg-G4; Wed, 11 Sep 2019 20:12:47 +0300
Date:   Wed, 11 Sep 2019 20:12:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 09/11] gpiolib: of: tease apart acpi_find_gpio()
Message-ID: <20190911171247.GU2680@smile.fi.intel.com>
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
 <20190911075215.78047-10-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911075215.78047-10-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:52:13AM -0700, Dmitry Torokhov wrote:
> Tease apart acpi_find_gpio() into common function that works on the
> firmware node, and a fallback handler that works on the ACPI device
> structure, so that we can later use acpi_find_gpio() in
> fwnode_gpiod_get_index().

Title should start with "gpiolib: acpi:"


I review from this one later on.

-- 
With Best Regards,
Andy Shevchenko


