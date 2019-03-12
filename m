Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79291C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48011206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415361;
	bh=RC5xY8vjvwIxBfMkXj/5F2rkcXWXg3PDKuShszeJTPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t0vGNXEvyycWQzedAAjWNzq7KSYIEDMcsRqkXo6bCduChvkKE+LnYVNJKcrzGE2Cd
	 B2RQ4Nd06Hx1oZVZEt7wZbuZ3LHHW4YsCpeQyCC4wy9qSi6ivcf9npvCScL1UPQogg
	 /TRkFmxDX5QPUV1aHRKqzg8EKTjeZDRLSkzFv+pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfCLS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:29:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45094 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:29:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id t82so2904201oie.12;
        Tue, 12 Mar 2019 11:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A0W8M0h9pVz4S1woOp3zWrpRBRJfOEQUVwAacXlRraU=;
        b=Kw0UjjABVJaAlGivHbBxLopoFqcy4YO09dAKir4eI13tVMwYdOR6l8dxiy5PbeEUNo
         9ooyTYsHPwzQ0QqD/Pynjql/dSeluSnJP6ViPPpcod0kwpSZckFx8bWYFejzo9HLxWNf
         0oqgApuLJYoUt5rEITohJZyHhjG2t/XEhlY36L0RkLsID8I7Pey7uKy3ypOa2wMz3snV
         vK5aThZTxYM8layJDek+Vkc9XLt7QoneBWq5FTdKwD1lAV8E0CYGnG9sRKjQmjFfjz5V
         pHM6KKSuRulspe750X/fUzoo+gdovh3T5eLem1QPKx2VgO1fVpMxlJqVUEgojuSS6jt7
         W16w==
X-Gm-Message-State: APjAAAXXTwjK4xMpHT8aTFkx6kTeoXarsrN/4ZhNKDa8qrhQvHxd3PMu
        J9O6lpXSZBUH8bNwe2lJ9w==
X-Google-Smtp-Source: APXvYqwFL1fHvcXK2pqJI8F3F50JNEwtKD3vAov4tkJu0f79/0mdEsNA1aRs5AwXdAx1UT4bMe0uSA==
X-Received: by 2002:aca:aacb:: with SMTP id t194mr2653082oie.129.1552415358101;
        Tue, 12 Mar 2019 11:29:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 71sm639965oii.33.2019.03.12.11.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:29:17 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:29:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3
 Glue Bindings
Message-ID: <20190312182917.GA22114@bogus>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
 <20190304103846.2060-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304103846.2060-5-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 11:38:42 +0100, Neil Armstrong wrote:
> Adds the bindings for the Amlogic G12A USB Glue HW.
> 
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
> 
> A glue connects these both controllers to 2 USB2 PHYs,
> and optionnally to an USB3+PCIE Combo PHY shared with the PCIE controller.
> 
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
> 
> The PHYs phandles are passed  to the Glue node since the Glue controls the
> interface with the PHY, not the DWC3 controller.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
