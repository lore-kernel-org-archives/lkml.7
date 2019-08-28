Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA55220828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfH1NrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:47:16 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:54928 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfH1NrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:47:15 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 13:47:15 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x7SDlEXA030573
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Aug 2019 09:47:14 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x7SDlEep030572;
        Wed, 28 Aug 2019 09:47:14 -0400
Date:   Wed, 28 Aug 2019 09:47:14 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Message-ID: <20190828134714.GA30547@people.danlj.org>
References: <20190827003335.2494-1-benchuanggli@gmail.com>
 <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:13:03PM +0300, Adrian Hunter wrote:
> On 27/08/19 3:33 AM, Ben Chuang wrote:
> Looks good, one minor comment
...
> > +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 
> Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
> making the accessors always available.  So for now, I'd prefer to select
> MMC_SDHCI_IO_ACCESSORS:
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 14d89a108edd..c3bd967d8a1a 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
>  	depends on MMC_SDHCI && PCI
>  	select MMC_CQHCI
>  	select IOSF_MBI if X86
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the PCI Secure Digital Host Controller Interface.
>  	  Most controllers found today are PCI devices.

Unless I'm missing something, this seems like a separate patch;
are you asking for it first, as a predecessor to the GLI patch?
