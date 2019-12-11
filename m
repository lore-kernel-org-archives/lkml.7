Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C9BC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2DD20409
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfLKR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:57:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:28533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbfLKR5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:57:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 09:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="225610402"
Received: from cmclough-mobl.ger.corp.intel.com (HELO localhost) ([10.251.85.152])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 09:37:13 -0800
Date:   Wed, 11 Dec 2019 19:37:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de
Subject: Re: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI
 transfer delays
Message-ID: <20191211173700.GE4516@linux.intel.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
 <20191210065619.7395-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210065619.7395-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 08:56:19AM +0200, Alexandru Ardelean wrote:
> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current `delay_usecs`
> with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6485 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")

Not sure why you use ` and not '?

/Jarkko
