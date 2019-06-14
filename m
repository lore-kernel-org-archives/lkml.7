Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938212177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfFNPbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:31:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:45628 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:31:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 08:31:41 -0700
X-ExtLoop1: 1
Received: from mdumitrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.245])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2019 08:31:37 -0700
Date:   Fri, 14 Jun 2019 18:31:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 7/8] tpm: add sysfs attributes for tpm2
Message-ID: <20190614153136.GF11241@linux.intel.com>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-8-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613180931.65445-8-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:09:30AM -0700, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add sysfs attributes in TPM2.0 case for:
>  - TPM_PT_PERMANENT flags
>  - TPM_PT_STARTUP_CLEAR flags
>  - lockout-related properties
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

You can use /dev/tpm0 for this from user space.

/Jarkko
