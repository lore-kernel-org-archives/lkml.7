Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D89208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385395;
	bh=sYZmf5MRziKXZGI2tO2ucFKHOv9wfU6jvyDyhDA3kDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cuLinIPIjPIFUbbgyrdE8cbl1egK9domErYrYSgTzcv2PtZjej9Rgv5o9YpfU45z5
	 Lutb9OAFdIAH4TyYf05QzPWXm9LJHrCao72+AIZWHvsqOnyUbOOfVxFzP1eAXmiTlO
	 NIILdgyfeCp+gF5WXKJOTh99mZHXw1UotBslEGiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfIMOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:36:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfIMOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so29631288otj.11;
        Fri, 13 Sep 2019 07:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=EE+keOIZ1AFHTETx/xa5OA2Ucn28ZMv9VA7ngTJ2uO4=;
        b=Sx/qwDQMYx6IRLSYPYrt1izcJv4PBYaEnMMwRgkrD5C4n2z9kFNJL6HXaX7ldMnJRw
         B1L+taMl00krgIHm9U/tVZ6z3WVtz2O50gWBntfTjDN40O6NZRXFTvriUgmSvdlqlina
         1I2uPOBXthV/9Qmj60IfFEe5tPgxp6jbeCeoX6LcZ6GCkzzqiTTu2lmzjpBmRw3mbzuP
         1jYJGvO41kI+7mtfLSYt1Iu/ADmJeIzWj0m9xVaCIlgaCft3xYNEJH8MSnle3d6+/8Vx
         qjglfAj4F5NfPVvL5ANO7ZZI+I9MJWfXQZ7lFThRsSLXhH2e2ZSYHO8EYtiVO8FCtMOL
         GwoA==
X-Gm-Message-State: APjAAAVR4DKErL9qurU1bIZ56qD7S0xjz9AAQbzCuzI0BJgYktyTYHAj
        IziI48A4ZXoxYkL702A6yA==
X-Google-Smtp-Source: APXvYqyRB/M5XLXv7J5tHMtHFVpUxo8jev2xZZpJoYNBxXFfRA5I0vTsW+cuHiU4kLiCtEPE7YhWUg==
X-Received: by 2002:a05:6830:100e:: with SMTP id a14mr13806578otp.238.1568385389243;
        Fri, 13 Sep 2019 07:36:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t7sm525642otp.58.2019.09.13.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:28 -0700 (PDT)
Message-ID: <5d7ba96c.1c69fb81.ee467.32b9@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:28 +0100
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add documentation for DMA domains
References: <20190910115037.23539-1-peter.ujfalusi@ti.com>
 <20190910115037.23539-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115037.23539-2-peter.ujfalusi@ti.com>
X-Mutt-References: <20190910115037.23539-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:50:35PM +0300, Peter Ujfalusi wrote:
> On systems where multiple DMA controllers available, non Slave (for example
> memcpy operation) users can not be described in DT as there is no device
> involved from the DMA controller's point of view, DMA binding is not usable.
> However in these systems still a peripheral might need to be serviced by or
> it is better to serviced by specific DMA controller.
> When a memcpy is used to/from a memory mapped region for example a DMA in the
> same domain can perform better.
> For generic software modules doing mem 2 mem operations it also matter that
> they will get a channel from a controller which is faster in DDR to DDR mode
> rather then from the first controller happen to be loaded.
> 
> This property is inherited, so it may be specified in a device node or in any
> of its parent nodes.

If a device needs mem2mem dma, I think we should just use the existing 
dma binding. The provider will need a way to define cell values which 
mean mem2mem.

For generic s/w, it should be able to query the dma speed or get a 
preferred one IMO. It's not a DT problem.

We measure memcpy speeds at boot time to select the fastest 
implementation for a chip, why not do that for mem2mem DMA?

> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml

Note that you have several errors in your schema. Run 'make dt_bindings_check'.

Rob

