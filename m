Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715077;
	bh=9njtzHYw/o7ZXpOkYjZg7wb87d2a3rWXOxz37ku2W8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ka8rzAQGuoVfHSWp4WdYci4/6HOg/2uG8UEcXWe73oiRPRQKToVvmcI7jyjMsXm3W
	 F2ze/lBkaTf4+M7s8j+fbNCdXP7/h5DIjQD9XZTzKIHJ7rS0Xpl4biDBeAASFejcQT
	 rJ4vZt94SE7dZtzbm8iiWRJU4iPwykOcm4Q3G05Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfC0TbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:31:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35135 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfC0TbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:31:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so13871015oib.2;
        Wed, 27 Mar 2019 12:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fU6lIgrPbQ8iLPruNsAnQK7UUhqtI/Yrkgl0STLmLaY=;
        b=s2r0NvU20pc+j182WiEAyCb6Kr7x+Ru0PQtm4UxwH7qE+i6XTGSSrHWRbw6fu7c5fl
         gWZok/1ETliuN+qs6f5X4cYH0kDY/Cg+KKF1GOsAp1Wl9FtFincViEpSdn63Wf9zzyBR
         I78LeBKSzyT+YIHEFCfL0fWq/fwcUKfup2BIxrSqaNR6p5gEypjilXwndTFonCeEPQCi
         hRVDjUWPbOyfBPAgxYqN64Q+pkhIchPn+C2am7WyJaqHUDtkO2Uf+i8rR2EJjDNSA95H
         0LUv+8L9uDId+BdgwVPMXHT569kZWsJO64Ik3/UUriCIcon8Sm86+hGusXZdkcoVp/df
         JlUw==
X-Gm-Message-State: APjAAAXIdN1ghBolWOAjhFVgsYMZYAreDO8N8bljPzQ28+mTl8CFLJM5
        Jqsqwk8ta/+HsV+v1iiNIQ==
X-Google-Smtp-Source: APXvYqwe/S/uEjLFQklO/mNOXmHGufCxAjt6z9KWrfle+R9KG0zVgLi4N13XhcCR9WCr7ucyDVXtuw==
X-Received: by 2002:aca:fccd:: with SMTP id a196mr19597272oii.132.1553715071975;
        Wed, 27 Mar 2019 12:31:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v24sm1814640oic.32.2019.03.27.12.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:31:11 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:31:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     xuwei5@hisilicon.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add HI3670 MMC controller binding
Message-ID: <20190327193110.GA11175@bogus>
References: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
 <20190228154511.17566-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228154511.17566-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 21:15:09 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> K3 specific designware driver is reused for HI3670 SoC and the binding
> is documented with fallback approach for compatible property.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
