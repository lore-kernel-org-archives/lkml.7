Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA054CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17A720717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572366418;
	bh=PLlx7MHmT1TOlNVUl2jtbMRfAPct/ltp+XlI2VrncQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIYLOZWGm5nVzIRzoFIaoso9YXQSFpeNIVBTOZYCSo24oUYuhQe1sQz6cJaSE7lOg
	 EGOj7kTMTT/1tcJ2XzUrmNht1WX81LRgmYb/F0Qgf+OPpB7iP3Js0JXOVlQYorUAmh
	 jP6UX9k3QX1ZO5eVTmxQMvcim/y4bxY/95vEiKC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbfJ2Q05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:26:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34872 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfJ2Q04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:26:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id n16so7178405oig.2;
        Tue, 29 Oct 2019 09:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBrS3MfVSTC+NWeWcKLokfVo46JF7z5WKYX8AZ96bEs=;
        b=ZRpBIHgeUsV0KUoauN3Js4yaM5QSNjQocOjOSmZGgAFiykW/Qj/FwXdyIc0mszcmQN
         BCpFma9S6n07zjYFJdH0VAzsbz2+3eg0lpbp/EbARDCNN+AUpUx4CWV89edeBozIaPQ9
         nD1hhMDFBkqdti+QSWGwwxpdXnHoV0yA1YZWD0Ac9Eg/eR3einElDCeWYPU2KmJju5JK
         u/a+2DFYQgS+6yvNEWB78h0VRkDzOlEAMaAXDHOANjtoOOtiyyGaY/K12KZqqgZbbv9n
         jiCgpcUOHor5qZ/SXIWuVTbtpM/y6B1FNS25jDtRJ6zkee3lBRCcTKKXNt9vMTF3DeSt
         MpkA==
X-Gm-Message-State: APjAAAUoC9T1LZ8mEY85VQ1paW0bVGo7+znKbRxnp730348KiACJ9Clz
        1VMWed1vKtgdbe7dD3O+o5aRHG4=
X-Google-Smtp-Source: APXvYqxEa1wFIy5eI8c76naEf1um9AkqRDCmhD7e8H7V0IT8l4+SP7VWsyKgYPUmFCvjNWr1elf5ag==
X-Received: by 2002:a54:4f83:: with SMTP id g3mr5071578oiy.24.1572366415703;
        Tue, 29 Oct 2019 09:26:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w9sm186161oiw.48.2019.10.29.09.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:26:54 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:26:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] dt-bindings: soc: amlogic: canvas: convert to yaml
Message-ID: <20191029162653.GB1057@bogus>
References: <20191021133950.30490-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021133950.30490-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 15:39:50 +0200, Neil Armstrong wrote:
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Canvas over to a YAML schemas.
> 
> Cc: Maxime Jourdan <mjourdan@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/soc/amlogic/amlogic,canvas.txt   | 33 -------------
>  .../bindings/soc/amlogic/amlogic,canvas.yaml  | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
> 

Updated 'title' and applied, thanks.

Rob
