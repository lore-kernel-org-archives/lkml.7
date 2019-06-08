Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F9FC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCE212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zf3VIHa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFHPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 11:24:34 -0400
Received: from mout.web.de ([212.227.17.11]:57465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfFHPYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 11:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560007456;
        bh=uuPJ0ujuQTjvJZkom8g+7THyutf2GoG7/RLzUnqlV+k=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=Zf3VIHa02a+HfnwUmlGFhRdejpKwDTHmGOWSzL9DdhjK6oowmUlMxk7Zll/VOAvjp
         rov4n/a3HIXg/CxThj/ujVBQxeS05Xf089HSx0OrqZ4Q+l7fPdfs0LXXxXI8bWyNLL
         drObWXv9OBkSrrTXVqMyV9Z9K2r03kM3xfWwhgAw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.243.189.212]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYS2-1h5KmH3KY2-00WVab; Sat, 08
 Jun 2019 17:24:15 +0200
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
Date:   Sat, 8 Jun 2019 17:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190406061112.31620-1-himanshujha199640@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:R+dZh0ZrYW7IwTsGMXlNogSTN4+5a6bIPidak4Zptr3tIKn9zod
 5lEuxtyaNQNbBhftm/hoZKPhRVyPKHCF49mCo82X3f4GJBQg9UtDKdfy85KESml9ikzkQNs
 Iq1cbpkOsZUbvSl6T+ilpzpEmVTeB0cCBkrJB5sVC48JncNqIF+OKOxMyhcmFhJGPAFgpR9
 bjiRFxYmYLwclIhOrBIJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2SfiyUGPfAY=:YHnIuWI9eVhjI9kkhfvHxb
 52oVaeM8fPNZ+TKLLumFKa48f/YAa+lop9ffpLU6PEfMAyzeKd08QeIrK48v4TBw+aSFM8dPF
 9LedwEvoxy7+B8c+YRt/FnnPwKzGABsHQ3OLR+HakhFOwrgrjY9iA9qvDA8LiT77+Pa9W1iss
 s37ENLTDSWgDutuxtvBV4F/z6M3SwzzHsTwvrDDLZc1c8gcB2TVWW/vK1kICNmBiB5yFBnpUX
 3ggvl4GaTDaFv2D5wlcmJTrOGMoblk1XZC1e71BFHx02y5p4mEIr0DXgxbbrK8MdLBmr+6TG4
 bOVIi3UQNofXCaEWQXySsNOPaidvC5G5bG0k88dzmU3swPv56MDzSCgJ5Cr+sKBTQLC2yMOHo
 thfbX4ZJ3rEgBZm9v48u+MCqDZAYdEEJFb5lI9vWx90g8xPrUmAKWjIbdbmJbUvTvIZ+l7z/V
 INlu+G6IkdbVAeotTSiUhtCiZado/PYGpByWuLFMJ2JhyG4a+ljlC3yC8Vb8QiVmCOxOAkVsE
 s1hJsv0+mAGMrHeUTNzLEadXgQlKwslASQ4YYEDv67kvUGab5RDekohgtNGSsRy1eC0TcfzaX
 jgi+9XCrqGcNkYwaFd2VI5+8MIAodyPPOwLc1EQPvCC7N7j6v+OnpIePbwCJYdhWqIrE++f52
 UtJ4uJl1zBG3FpvHzmC+SH0queSde9b1kLidAR3+Wcw9vJmclbP1WahgR2JcQbYVW3R5YCFrk
 N0WSbhuBJb55afbz9i121iGcfk6NowrH+p4hF8RF8k9N7ORYevGPnC4pRWbnIXYxXV+RMal+5
 eQOO6/EPajyeCkRrC886Uv1kShNTkuqAwqa+KiZaX8/5FKpt5/CBufxU6AxD5Rny9z9aw4NzL
 nGt2SyBZjPyXY3rlxjHk6YudPSJY8b/l2wiAZNJUupLgLpFrDBuPsawvv+RbKah6TSe6nBsYW
 b8xTVSsg6zaTiaYUG9NhRF72OvxVww/4pjdhhEHOROeOoqCvWGiei
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +- e1 = devm_ioremap_resource(arg4, id);
> ++ e1 = devm_platform_ioremap_resource(arg1, arg3);

Can the following specification variant matter for the shown SmPL
change approach?

+ e1 =
+-     devm_ioremap_resource(arg4, id
++     devm_platform_ioremap_resource(arg1, arg3
+                           );


Regards,
Markus
