Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00419C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C92070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE2JsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:48:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:5920 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfE2JsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:48:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 02:48:22 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 May 2019 02:48:18 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 29 May 2019 12:48:18 +0300
Date:   Wed, 29 May 2019 12:48:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Message-ID: <20190529094818.GF2781@lahna.fi.intel.com>
References: <20190528230233.26772-1-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528230233.26772-1-ruslan@babayev.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:02:31PM -0700, Ruslan Babayev wrote:
> Changes:
> v2:
> 	- more descriptive commit body
> v3:
> 	- made 'i2c_acpi_find_adapter_by_handle' static inline
> v4:
> 	- don't initialize i2c_adapter to NULL. Instead see below...
> 	- handle the case of neither DT nor ACPI present as invalid.
> 	- alphabetical includes.
> 	- use has_acpi_companion().
> 	- use the same argument name in i2c_acpi_find_adapter_by_handle()
> 	  in both stubbed and non-stubbed cases.
> 
> Ruslan Babayev (2):
>   i2c: acpi: export i2c_acpi_find_adapter_by_handle
>   net: phy: sfp: enable i2c-bus detection on ACPI based systems

For the series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
