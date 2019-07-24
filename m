Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EEE206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000486;
	bh=b7qJCq6Y1gDomSWzEJNlYYZHOIci9QX5fViswFYfmoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DrEtsJPHQ7ELV/TL3CVV+C8pb8ejGjxpSGPkpNQGonIwZmqbXd1BKOwJRKPSa42hs
	 +Y6F29BmtcO+6vmOqBeBR0diCtcYmoafymbTyMvsQOtU1r7m/aMfh6IeYEVEqvgCKE
	 +lQV0FX73kt4/KmL0w+vndRNFXtnK7V5bFq/SmdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfGXUep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:34:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41090 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbfGXUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:34:43 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so88278831ioj.8;
        Wed, 24 Jul 2019 13:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHLqz6FDkSCI8LzqIEBRdrQs7zeUsE0ZRMiorxW3eeM=;
        b=OZkOOH6XGRw5toLoh7UNUatXnUD/sdqLhWbJcD7YEL+oswd1czwfTneOUVECSEXZNs
         yw439iSg9Yaq/lhfQVQ+mPsJRfSlk/eeUk6GGWD3sJGogP6ZUt5tmJVwp3cZY8InsJlv
         OOzuSA24uLr73oU4hbFY3WA/dcKeLSPHssPdDlnEdb5clMFHL6YpwqLX/4nFahxZqksk
         eVPffTDrINE+elUHa+l/bbxKpyHuWJTc4FtJVlt+Wl7VP8z3GKGIMIfIj34bgPMjAsYW
         z6roznpiHpsJ06thP+9qbVxLx8lCFlrn3NBKwikXVw+4UVlEsNuJkvb/ABgpXAyVOFXX
         2/9A==
X-Gm-Message-State: APjAAAVlEhTIgPId7bLrnCcbIcFq5NIA+i1NE8qcEeSFjIaX/SS1CsAT
        Amh2HKq3E0qbdOFR7v+8EQ==
X-Google-Smtp-Source: APXvYqyiTSzmcos+LtyMuQu0VL4DAqAkhvqzWm1usV7kqdE4UV43i+gHAw7kW1rK2LIWDuuVMITEbA==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr13123190ioo.258.1564000482978;
        Wed, 24 Jul 2019 13:34:42 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c14sm37067202ioa.22.2019.07.24.13.34.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:34:42 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:34:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Message-ID: <20190724203441.GA22721@bogus>
References: <20190711023714.16000-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711023714.16000-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 10:37:13 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add compatible for i.MX8MN and add i.MX8MM/i.MX8MN to the description.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
