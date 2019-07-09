Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7ECC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5998C21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562690940;
	bh=PmAJmMi5FGRKR1mzuNnrelHuWNb+T2ufuADpo+YG/JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eur+yY70fn+ioQ1vD/8YLpBQ2Dpo85oV/XSHMaaXGvmDBXhI2rDNSukiveCDl4ucV
	 u12UXb+v6vUSN0nbFKXC5VL6FN/3+cEM7PIG6ek+Gc3+x/qfwYFW5eswN2w3lzUSV3
	 5XieQwYVgUPhrePgaU+Al9OXxndcdc7g8fF1HO7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfGIQs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:48:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44243 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:48:59 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so44580494iob.11;
        Tue, 09 Jul 2019 09:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESKJeEeoJzLVR91LKYyNOrMjULzonrpUIn2jkHjT9Ik=;
        b=hdo64374Jao6nX/whV27UoGXoifhZlbMJNUnwib8mUcHHD0RpVrjA5WwUfWeD8JE05
         NltErY7HX0g0eg1lnERqOF588wTGBtpp7itC6TCX6FbrMaWpw0uatzARYosZzK0x1iHu
         5sv9LrtQJq4VlVLC/cmdgxdIt2D8Xz0vr9I/w/+sn8r+UCIrq3AdhzUaxbs8JQcxf8x1
         5F3f0UkejIkiWgEE2RNaSO3s6t6DCuUsfvU7sEdqAHX4XDh6jrBhFZ6XdF6BruBZZHLb
         hyd0koSALK8WuQuX6r0dHzjPRvAm2zCWPBAIq4u8Z6OhS+dvSqISte3fA00U7reAM2hW
         MM9Q==
X-Gm-Message-State: APjAAAUdY7avyg33Jl4PAUAYp8rDvtvh6GUcIvBq+n7Ed7l1c4KRbnrZ
        KElr91d2ko43LaQj7iaJGA==
X-Google-Smtp-Source: APXvYqxVFx8EkHYgaV6sqf8Wuw95y1uJHSeEapnNL43LR2cbfvdytbyuH5a+A9mZGjAAW0FSXTu0/g==
X-Received: by 2002:a02:cb96:: with SMTP id u22mr10075827jap.118.1562690938107;
        Tue, 09 Jul 2019 09:48:58 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w23sm36826933ioa.51.2019.07.09.09.48.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:48:57 -0700 (PDT)
Date:   Tue, 9 Jul 2019 10:48:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, afaerber@suse.de,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add Actions Semi ATC260x PMIC
 binding
Message-ID: <20190709164855.GA21383@bogus>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617155011.15376-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 21:20:08 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Actions Semi ATC260x PMICs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/mfd/atc260x.txt       | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atc260x.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
