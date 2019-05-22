Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C92C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82112184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558529400;
	bh=5ZGoJi7NkwXVR/OD6kRE/4231NNk5lVLqumccNmisaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=axhHUiEUHaXQx0DccNYaoIUnBAs9GTQEYuGJQWEqA7FZuCI9Gvn1SZD1HgKJTyNAh
	 vYI/g3xWY5m88d19I3MfH2VfUrwSJtmmJx8ojID60AFQ17oqNOzsQoQjXf/Gv0PYlN
	 3Y5YoHXU83zHFw+gJLzyLHLTZYK+Mf7BR/pHz5uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfEVMt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfEVMt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:49:58 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1EC2184E;
        Wed, 22 May 2019 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558529397;
        bh=5ZGoJi7NkwXVR/OD6kRE/4231NNk5lVLqumccNmisaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P/Xi9UJqmeYRdPazqEcKP9IuQTWCddd6kst1SKQ3qjtCiUCMbvuOEEDFicZv/pk63
         NeV63sW+AFY9dTKnLz1Lreb0QxFX4AC9RFKcvXTXt1ZrMWRDQBPXZKLqEvEDUM4vwH
         QT+r59SQPi1NU1B28D+wbB9ZjFloODaKSgvs63xA=
Received: by mail-qt1-f176.google.com with SMTP id l3so2117819qtj.5;
        Wed, 22 May 2019 05:49:57 -0700 (PDT)
X-Gm-Message-State: APjAAAWgIyM8BMsyZnX/4MYJ8PqkHZq5xjOzjYEdpm1Io3t19gHUAHMF
        UcE59Zt4y1/JJ/VW0C0ExMivMPm8k9Kup2H2tQ==
X-Google-Smtp-Source: APXvYqxJyh8gPJdSllFYvlfTjnDcRfyrin0i7k2617dS8CfKNsSi0ccmNnsl8crgC8wL+I59VDGEoYxEPmonj9M9fPU=
X-Received: by 2002:ac8:3884:: with SMTP id f4mr75987199qtc.300.1558529396825;
 Wed, 22 May 2019 05:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190521212325.16639-1-robh@kernel.org> <20190522104226.nwcvx33akt6q576m@flea>
In-Reply-To: <20190522104226.nwcvx33akt6q576m@flea>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 May 2019 07:49:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+JimAYW9GiPz6_hNJfnA+8bnN=kPDOEJFPyt+57bwriw@mail.gmail.com>
Message-ID: <CAL_Jsq+JimAYW9GiPz6_hNJfnA+8bnN=kPDOEJFPyt+57bwriw@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 5:42 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Tue, May 21, 2019 at 04:23:24PM -0500, Rob Herring wrote:
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
>
> You're using a different construct on the spi-gpio binding you just
> sent (/schemas/spi/spi-controller.yaml).
>
> Is that on purpose?

No. This one is correct (though both work).

Rob
