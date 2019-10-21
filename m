Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20974CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC0C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571645453;
	bh=YgWyBo8MjRj07MfbrlPv0kNCL/8hgHqP/T1LhKJ4jFw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=1546E5R2/HndzsTUIVcLF64O1oaXXU72rjuUegwZjdF67OQWLgXsq9q041Vx16xzN
	 KnVAGEviB/6BHVJrnnepSnY71negkTIeQsercA8Y12aBC3qT3XRil8bJIe/7U7bqxp
	 RXWd5Tn3GhkQZrofLEOhujS2HoQjXUYTiA/J2CZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfJUIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:10:52 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:53197 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfJUIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:10:51 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iMSm9-0007tu-RH; Mon, 21 Oct 2019 10:10:49 +0200
To:     Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 11/13] drivers: irqchip: qcom-pdc: Add irqchip for  sc7180
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Oct 2019 09:10:49 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
In-Reply-To: <20191021065522.24511-12-rnayak@codeaurora.org>
References: <20191021065522.24511-1-rnayak@codeaurora.org>
 <20191021065522.24511-12-rnayak@codeaurora.org>
Message-ID: <18195431666bd42aa31cf4ec1eed2881@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: rnayak@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mkshah@codeaurora.org, ilina@codeaurora.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-21 07:55, Rajendra Nayak wrote:
> From: Maulik Shah <mkshah@codeaurora.org>
>
> Add sc7180 pdc irqchip
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
> v2: No change
>
>  drivers/irqchip/qcom-pdc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index faa7d61b9d6c..954fb599fa9c 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -310,3 +310,4 @@ static int qcom_pdc_init(struct device_node
> *node, struct device_node *parent)
>  }
>
>  IRQCHIP_DECLARE(pdc_sdm845, "qcom,sdm845-pdc", qcom_pdc_init);
> +IRQCHIP_DECLARE(pdc_sc7180, "qcom,sc7180-pdc", qcom_pdc_init);

What I gather from these 3 irq-related patches is that as far as
the PDC is concerned, SDM845/850 and SC7180 are strictly identical.

Why the churn?

         M.
-- 
Jazz is not dead. It just smells funny...
