Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C1ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0504F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569937493;
	bh=cDLGZOEKPcejJ8BC4dY+lAl+SSVuZo2OcqMrFTLR3VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P0negnPakhhGMBH3skSPM0s7xIHi9jyh6xSWUZbuwkBB6oHeaSEAHMKRPD/Ry9PxM
	 AUwa89xINtyZPj1ij1UnQIRyfcEDICfnPCU+19u8tpAh6q6WfduTTalDdLHoPxcyh7
	 K9d/ot1Jc9IXJbbet492//vaqjorHuPnMQXx1vxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfJANow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:44:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34585 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJANow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:44:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so14460687oii.1;
        Tue, 01 Oct 2019 06:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEk9hnIUXWE3u1Rb3n2bhHYcH2Wd7u6ueEiS5QFdFr0=;
        b=mE+5HtLXTWbP6dRQRQmAotRIbCU+lk3lH6pOBTZQrEFzLdc5UoldO+iRlWpruobPr0
         L+BpqZIlNDP+q3iXCPDB7AsTniJREmCQVntIv8LnSOCa+9YGnnv1BKKIuTSTWPH0j4T6
         xdV7/ex80UAbAd1mFd27qjJ6eoNA1BqelgPLH5EGYrsS2DGznbAnmuR31rR+RkffUorh
         KeC7pzTQBBeQyKsNT5D7jJk8g8f05e8NJCI2X2JtltY8oGs0iKymTnJ1RfMMoQymujzC
         iubrjJgirisP5GiTVFhYb5KQmTlsIMVR6gjXZa9kLre9+b+1Klr9m7Z1kc4Y5gqOXLcv
         tmOg==
X-Gm-Message-State: APjAAAVLOvcrbyGybFgglY3QxPy6U8m8DK2IxI2HPCOWFtfdsrnC8rve
        mYcf6/0jJPXkLeIAF5pDmw==
X-Google-Smtp-Source: APXvYqwOufGQSK3HWFRGN91rsiUi3BhlQyYODzFgebhOif+j+ruhjh6YpWFbeO3JiM9jfqQ60ojUuw==
X-Received: by 2002:aca:f0d4:: with SMTP id o203mr3677322oih.15.1569937491029;
        Tue, 01 Oct 2019 06:44:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v75sm5301353oia.6.2019.10.01.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:44:50 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:44:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v3] dt-bindings: gpu: Convert Samsung 2D Graphics
  Accelerator to dt-schema
Message-ID: <20191001134449.GA23645@bogus>
References: <CGME20190927143325eucas1p289cb46e8dcbb1ace0b1f80ade738c29b@eucas1p2.samsung.com>
 <20190927143319.12232-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927143319.12232-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 16:33:19 +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung 2D Graphics Accelerator to newer dt-schema format
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> ---
> v3:
> - Merged two if-statements with single if-else statement
> - Added 'additionalProperties: false'
> - Listed all missing 'properties' in properties scope
> 
> Best regards,
> Maciej Falkowski
> ---
>  .../devicetree/bindings/gpu/samsung-g2d.txt   | 27 -------
>  .../devicetree/bindings/gpu/samsung-g2d.yaml  | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> 

Applied, thanks.

Rob
