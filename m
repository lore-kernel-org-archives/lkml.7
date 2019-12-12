Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464DAC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2693320663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfLLLVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:21:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:4991 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbfLLLVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:21:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 03:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="220672957"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Dec 2019 03:21:36 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 12 Dec 2019 13:21:35 +0200
Date:   Thu, 12 Dec 2019 13:21:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Use new GPIO direction defines for intel pinctrl
Message-ID: <20191212112135.GE2110480@lahna.fi.intel.com>
References: <cover.1576132131.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1576132131.git.matti.vaittinen@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:33:54AM +0200, Matti Vaittinen wrote:
> We added definitions for GPIO line directions here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?id=9208b1e77d6e8e9776f34f46ef4079ecac9c3c25
> 
> Let's use them on Intel pincontrollers too.
> 
> Changes for v2:
>   - Replaced ternary operator with if() for better readability
> 
> ---
> 
> Matti Vaittinen (3):
>   pinctrl: pinctrl-intel: Use GPIO direction definitions
>   pinctrl: pinctrl-cherryview: Use GPIO direction definitions
>   pinctrl: pinctrl-baytrail: Use GPIO direction definitions

Andy, please pick these up with my,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
