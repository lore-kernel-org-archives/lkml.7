Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF45C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC86C2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="LqdTURpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKNRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:19:42 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:42072 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfKNRTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:19:42 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 21B3A42E7D;
        Thu, 14 Nov 2019 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1573751977; x=1575566378; bh=P3FU1d3ro99r7uRl5lGjcNRn5
        WqlYzCAmN7MBkdbr3Y=; b=LqdTURpIXk1RD39o6BfgxURK8wwxrfauvNYFNb6YL
        7tPSe2Xiua69ovHuZqN0lAj4Nq/33qjR3XOOvOVhCAfY3lw4FZRcTKhQqUvsObMt
        itpqEASW82dQU5Vjy44qmb/ffpzTwtOHoS8AW26CUAM6t8P0aAESBbrur6WVnb73
        tM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k52oKM3PmY_C; Thu, 14 Nov 2019 20:19:37 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D050A411D9;
        Thu, 14 Nov 2019 20:19:35 +0300 (MSK)
Received: from localhost.localdomain (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 14 Nov 2019 20:19:35 +0300
Message-ID: <b443738f5e2a3c7ba96b329a8347374f7f934483.camel@yadro.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion
 sighttps://elixir.bootlin.com/linux/v4.6/ident/sdhci_opsnal presence
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Date:   Thu, 14 Nov 2019 20:19:31 +0300
In-Reply-To: <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
         <20191114125435.27756-3-i.mikhaylov@yadro.com>
         <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-14 at 15:10 +0200, Adrian Hunter wrote:
> On 14/11/19 2:54 PM, Ivan Mikhaylov wrote:
> > Change the default .get_cd callback. Add inverted signal card detection
> > check.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-
> > aspeed.c
> > index 8962f6664381..186559ee8fcc 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -143,6 +143,19 @@ static inline int aspeed_sdhci_calculate_slot(struct
> > aspeed_sdhci *dev,
> >  	return (delta / 0x100) - 1;
> >  }
> >  
> > +static int aspeed_get_cd(struct mmc_host *mmc)
> > +{
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
> > +			 & SDHCI_CARD_PRESENT);
> > +
> > +	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> > +		present = !present;
> 
> Perhaps safer to flip the bit using CONFIG_MMC_SDHCI_IO_ACCESSORS and
> ->readl() callback
> 

Sorry, don't quite understand what you're saying. You want to instantiate
'.read_l' callback instead of '.get_cd' in sdhci_ops and substitute the real
value?

res = readl(base, reg);
if (reg == SDHCI_PRESENT_STATE)
	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
		return !res;
return res;

Something like this?

>  
> > +	host->mmc_host_ops.get_cd = aspeed_get_cd;
> > +	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
> > +		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion
> > enabled\n");
> 
> Is this print really needed?
> 
I can remove it if you think it's redundant.

Thanks.

