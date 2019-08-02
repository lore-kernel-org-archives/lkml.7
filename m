Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEDEC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388222087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394993AbfHBUlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 16:41:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:4241 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfHBUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 16:41:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 13:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,339,1559545200"; 
   d="scan'208";a="178255267"
Received: from psathya-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.36.242])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2019 13:41:43 -0700
Date:   Fri, 2 Aug 2019 23:41:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
Message-ID: <20190802204131.pcb73zq7gllyy3ul@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
 <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 02:00:06PM +0200, Alexander Steffen wrote:
> Is it a common pattern to add config options that are not useful on their
> own? When would I ever enable TCG_CR50 without also enabling TCG_CR50_SPI?
> Why can't you just use TCG_CR50_SPI for everything?

Agreed. If the kernel only has the spi driver, we only want option for
that.

/Jarkko
