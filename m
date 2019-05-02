Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A076C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427C8205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfEBPm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:42:57 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54324 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfEBPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:42:55 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so4106695ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgRltt9mKzKFkWid2jC0d7CivMviw3PVlrovQvkWUY0=;
        b=O9/HfWL3UvwxCHJFkzkMph2Nnviw8rDOoib6l8c+NaX4b66t8HPovC+8H+IPDfzERq
         IQTKNTx90hXFy108h7lvAXA0EVa5TquvuMhHDFYZ/CaWtb2hQXRBo1ikSbOY+fIzryxm
         u9QbQcqVwxuqt4FyRj1jbKips8qkFIIahPTA4tXB2ZLDo2YS7tWZq7BqlujEMEUqE6jq
         M2LjvmBADn7eolaG4gwHWpqb23AHybSOFSghO8xtwPyt+5j4ZLVlHQ2zqwxfApgDzUhN
         BWGIHmQKD3f8C7y2k07b5XVARyvhnmm4z0ya1JY+E5J3UAhS0D+WyCYywaFNOB3ZRMvp
         f+kA==
X-Gm-Message-State: APjAAAXaRUt+mKR9mPBlovnMpeu0qfNz1hY8wfxKtXnVp1YwBV5HRRSj
        oAx0yPSwTNzgH7aLUeHppsugdw==
X-Google-Smtp-Source: APXvYqzEE6fGCQnogPRhO8dCkQ+ch5Y4EWRqETjULbeEJ7Mnea0b6DvrcjoovagYfJos3eSUEjIYdg==
X-Received: by 2002:a02:a1d4:: with SMTP id o20mr3155865jah.49.1556811774318;
        Thu, 02 May 2019 08:42:54 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id 127sm33865iox.65.2019.05.02.08.42.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 08:42:53 -0700 (PDT)
Date:   Thu, 2 May 2019 09:42:49 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>,
        djkurtz@chromium.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Sen, Pankaj" <Pankaj.Sen@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Avri Altman <avri.altman@wdc.com>, gene.chen@amd.com,
        Chris.Wang@amd.com
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Message-ID: <20190502154249.GA25027@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ou Thu, May 02, 2019 at 09:32:16AM +0300, Adrian Hunter wrote:

Gene or Chris,
Can you sign off on the patch.

Thanks,
Raul
> Cc: some AMD people
> 
> On 1/05/19 8:54 PM, Raul E Rangel wrote:
> > AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> > Otherwise it can get into a bad state where the DATA lines are always
> > read as zeros.
> > 
> > This change requires firmware that can transition the device into
> > D3Cold for it to work correctly. If the firmware does not support
> > transitioning to D3Cold then the power state transitions are a no-op.
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > 
> >  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 99b0fec2836b..532fbcbd373b 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/gpio.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/mmc/slot-gpio.h>
> > @@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> >  	return 0;
> >  }
> >  
> > +static u32 sdhci_read_present_state(struct sdhci_host *host)
> > +{
> > +	return sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +}
> > +
> > +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> > +	struct pci_dev *pdev = slot->chip->pdev;
> > +	u32 present_state;
> > +
> > +	/*
> > +	 * SDHC 0x7906 requires a hard reset to clear all internal state.
> > +	 * Otherwise it can get into a bad state where the DATA lines are always
> > +	 * read as zeros.
> > +	 */
> > +	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> > +		pci_clear_master(pdev);
> > +
> > +		pci_save_state(pdev);
> > +
> > +		pci_set_power_state(pdev, PCI_D3cold);
> > +		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> > +			pdev->current_state);
> > +		pci_set_power_state(pdev, PCI_D0);
> > +
> > +		pci_restore_state(pdev);
> > +
> > +		/*
> > +		 * SDHCI_RESET_ALL says the card detect logic should not be
> > +		 * reset, but since we need to reset the entire controller
> > +		 * we should wait until the card detect logic has stabilized.
> > +		 *
> > +		 * This normally takes about 40ms.
> > +		 */
> > +		readx_poll_timeout(
> > +			sdhci_read_present_state,
> > +			host,
> > +			present_state,
> > +			present_state & SDHCI_CD_STABLE,
> > +			10000,
> > +			100000
> > +		);
> > +	}
> > +
> > +	return sdhci_reset(host, mask);
> > +}
> > +
> >  static const struct sdhci_ops amd_sdhci_pci_ops = {
> >  	.set_clock			= sdhci_set_clock,
> >  	.enable_dma			= sdhci_pci_enable_dma,
> >  	.set_bus_width			= sdhci_set_bus_width,
> > -	.reset				= sdhci_reset,
> > +	.reset				= amd_sdhci_reset,
> >  	.set_uhs_signaling		= sdhci_set_uhs_signaling,
> >  };
> >  
> > 
> 
