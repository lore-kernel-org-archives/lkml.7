Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276ACC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B532081B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387988AbfIMJkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:40:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:22636 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387593AbfIMJkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:40:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 02:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,500,1559545200"; 
   d="scan'208";a="200931543"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Sep 2019 02:40:07 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 13 Sep 2019 12:40:07 +0300
Date:   Fri, 13 Sep 2019 12:40:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/2] gpiolib: introduce devm_fwnode_gpiod_get_index()
Message-ID: <20190913094007.GE28281@lahna.fi.intel.com>
References: <20190913032240.50333-1-dmitry.torokhov@gmail.com>
 <20190913032240.50333-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913032240.50333-2-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 08:22:38PM -0700, Dmitry Torokhov wrote:
> devm_fwnode_get_index_gpiod_from_child() is too long, besides the fwnode
> in question does not have to be a child of device node. Let's rename it
> to devm_fwnode_gpiod_get_index() and keep the old name for compatibility
> for now.

Shouldn't we convert all the users and drop that monstrosity
devm_fwnode_get_index_gpiod_from_child() completely?
