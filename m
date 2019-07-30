Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCA206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nKd3eAgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfG3MbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:31:20 -0400
Received: from mout.web.de ([217.72.192.78]:55545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfG3MbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564489859;
        bh=f/2pwlRqhUiVGsaMkeRb1AlrqvbiiI6KPkCJUIors2g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nKd3eAgpUjavAsvLf8Tg3yVxtYpefAlahC1Ea/UYQdppldn4DdsCUYb2g6xv7zmf7
         ddQdUkWNureTBhLvcxYhxsr6i6nJmEgFzYuLb5a+Jcnb3QdvsduOBJRXrenDuP00Qf
         zfFFNmELuW9sb+G0ehnW2Tdu1W7ESM38KCDApdlc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.24.141]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OYl-1iIkZR3VhH-00zTQo; Tue, 30
 Jul 2019 14:30:59 +0200
Subject: Re: [PATCH v5 1/3] driver core: platform: Add an error message to
 platform_get_irq*()
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-2-swboyd@chromium.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3197785f-91df-21d3-72f4-97ca73681bc8@web.de>
Date:   Tue, 30 Jul 2019 14:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730053845.126834-2-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JC8Rm8G2wNrcuNzKLcK5Ve0lv9MtywAnAaY4CWdveNooUr9Q5s2
 XvyNuGqwwqXVmVMJ4RL46GhcppT+y7ht+Xj+fL4v2MlCk0DnEhD4r9MsoOJl1YkMtWWlPOK
 vQsXUX569TWGzSlN3h/Sn1IjnKQYHyY05PpdyegyNbQW/xnn+nE8nxqNXTOswrQ/YZ05/xO
 0GJ5W4JkeT1uLGvZ9AwXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MgPID9UBP0U=:Kw9ObdYbzNeuD4aKS52TOV
 2wO9Y7zUhamQD3O+iGgMuQYyXZkdceu6R8D5e3E5k0/1B6vrrYgiIZHR34zBS6HVSP8oxkHpR
 hpWln6bHW/69x8zo9ZKyKar0WlE+PERyWih6SDhmTLQBGVrx2UlTAJB/1CgtPSFWUvcVM47T6
 xbQ20SBN84MnufHhQzeupfBzZr90b+g8ACHYGJJrNDBJsVh0D+xHpOvlNepVfTlv8LWCkZl2L
 y4i+MmspOEQCyrW68tTrbWBB+Ib/Dk31Iv2/8OuTft069laZaod53cxPFqe8tkS8rLl3ayNOL
 PWRG9OARKUTJMe3R0+LWIAEeLcPbinr/Bm51bBhKuk6hZADUTYkWqrF0LO3waVtJbx0cUZpOl
 VIQJV8t7ldWHeWt1lwWUnXJONyj+nLX18UMU6LbonReIM4llpO6FrnPjTeXmXhIiUh5lr2HAu
 L9lx1xjg+7GhrGfEmnSFIEX0rytRWX3+0ZYpdVJ51yy13x59Epck3jE1uQizS7u79Q3Sv36BT
 rkN0uiMXF/Jt0f5yVaTzy0Ih1ELvMtsc8O71v0Ars/hE5qlP1qFdDZCq0cpVQc3jyZs0+57Nv
 vVlL/Gqxj4RUNxTc9Y0G/OZk/F5CpKdp3rl+1PcaPovJO+xHeiKe+xVecUuPHOGOTrysgHsly
 ubSSjgHs+/VX4ZXMVU71HKQ/HqreojHuGH1IthyqIqlwgmj5evfVBoiwttsZvYFK5y8NO24jp
 LAUAeV7SljikRL1HKjYUy+3twVJgCtdXloycPqhEwt1DgtxY/I9DU2dBydEJJin79UNl6IgIF
 yo1BDD9nDTK8Uts2knVKvOaW4Lg/QyxIlzbEHdIddyvikIEm9w53uqH1QDUvJbITH6LG9sScG
 o6uo5wJ0rq1okdO6mq99teVLEkNw7a3MrIn/UncAA4oNNoEZx923OoTmAozA3jIXjML0s94ML
 DDvWCl//qk/4lGr2CVssVIiv6srwZN4bmjOxtaZVq4IheITSijNnjOJ+AxWMd0+soyyJPLcyI
 2RDNH5I4JJc7pO0wmXYQ/PpFCCwZ0YgDp7piSgl3IR0AJHmlpUWq0sBi8FY1VMcSl1bJ029Pv
 GJnF8BIBBCsAw8liA/5keUZUvsd2G0JeG8w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/base/platform.c
=E2=80=A6
> @@ -163,6 +158,33 @@ int platform_get_irq(struct platform_device *dev, u=
nsigned int num)
>  	return -ENXIO;
>  #endif
>  }
> +
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + *
> + * Gets an IRQ for a platform device and prints an error message if fin=
ding the
> + * IRQ fails. Device drivers should check the return value for errors s=
o as to
> + * not pass a negative integer value to the request_irq() APIs.
> + *
> + * Example:
> + *		int irq =3D platform_get_irq(pdev, 0);
> + *		if (irq < 0)
> + *			return irq;
> + *
> + * Return: IRQ number on success, negative error number on failure.
> + */
=E2=80=A6

Thanks for your extension of the description for this programming interfac=
e.

I imagine that adjustments for this software documentation format can make=
 it
safer to extract desired API properties.
Would you like to improve provided information any further?

Regards,
Markus
