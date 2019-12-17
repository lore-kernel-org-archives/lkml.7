Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F1CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B120CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLQB0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:26:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:1402 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQB0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:26:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 17:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="416654626"
Received: from chauvina-mobl1.ger.corp.intel.com ([10.251.85.48])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2019 17:26:12 -0800
Message-ID: <f4ac8ac982daf33f5b2a5bdc0bf63f67fd40413a.camel@linux.intel.com>
Subject: Re: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI
 transfer delays
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Date:   Tue, 17 Dec 2019 03:26:11 +0200
In-Reply-To: <6920bc5e8bc932dd85fa8e14755d2e6999512f25.camel@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191210065619.7395-1-alexandru.ardelean@analog.com>
         <20191211173700.GE4516@linux.intel.com>
         <6920bc5e8bc932dd85fa8e14755d2e6999512f25.camel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 07:21 +0000, Ardelean, Alexandru wrote:
> That's a habit from Github's Markdown.
> We keep our kernel repo on Github and Markdown formats `text` into a
> certain form.

Ah.

> When I open a PR, the PR text is formatted to highlight certain elements
> [that I want highlighted].
> I did not get any comments on it so far.
> 
> I can change it if you want.
> 
> As a secondary note: Markdown seems to be used on Gitlab and Bitbucket

Please change it.

/Jarkko

