Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A599C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651532183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfDRJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:35:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40502 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388347AbfDRJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:35:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so1436638qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNcpf13ppT2a5pQCdh6ZZJFtJ6XcCAh6E8ZerQ8NWFY=;
        b=OwgT2JxoTFQ+8fMTVVAXSy+Y02aBZquL4jBHoVEn6vSSUMVxzPNbFTHnV0Ip48cliP
         6Rg52cBjxxYbmrp6Q+CVl5F6XzpFaruBSbl4KNSzh6x2/ipdcc++EuBP0LgeTagmUAFo
         dL+GAxTnAYf9S0CgA727ixHbmu2ZJetoH1MMCrPxjaDTr/LmYxJC0otwol8KcwVDR0Dq
         7Mwea6YfoQ0k7VJ9M1A2hVyfEM4kN5oKV7QrVSm5j3cPOvxWs8kYaye5XEXjTW64Dplz
         wLuRFLkDcp0jKINWYDE3sd2TyAVof9FhLBGU24DZIQni3jG2/ELWsWHmcDcB95hRGiPj
         lCmw==
X-Gm-Message-State: APjAAAVmIQn/+TVKByqbZrpIWC7dRo6owUILD8reI5DW5876/Cud6qba
        W6C6jId3rM5ZC3uvIwZNNfDyuNXBJoCMpW2H19IoZA==
X-Google-Smtp-Source: APXvYqyBonlhxve1pC2jFDHXHRjWJCI70/bMNqr9aHwmFcxDvd3fV7MNRCkstmREvTUd2CXowXman6oGNDAMdDYD0Co=
X-Received: by 2002:a0c:acf8:: with SMTP id n53mr74354547qvc.83.1555580153237;
 Thu, 18 Apr 2019 02:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com> <20190415161055.16372-1-jeffrey.l.hugo@gmail.com>
In-Reply-To: <20190415161055.16372-1-jeffrey.l.hugo@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 18 Apr 2019 11:35:42 +0200
Message-ID: <CAO-hwJJ_BRRHL44yaZ=d_K-9iq1cyONn0rR+VW3ukW1M2Ma0ug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add Elan 400 combo
 keyboard/touchpad over i2c
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Lee Jones <lee.jones@linaro.org>, bjorn.andersson@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org,
        David Brown <david.brown@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> The Elan 400 combo keyboard/touchpad over i2c device is a distinct device
> from the Elan 400 standalone touchpad device.  The combo device has been
> found in the Lenovo Miix 630 and HP Envy x2 laptops.
>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---

With my comments in 2/3, I wonder if you need this patch at all then.

Cheers,
Benjamin

>  .../devicetree/bindings/input/elan,combo400-i2c.txt   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> new file mode 100644
> index 000000000000..fb700a29148d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> @@ -0,0 +1,11 @@
> +Elantech 0400 I2C combination Keyboard/Touchpad
> +
> +This binding describes an Elan device with pid 0x0400, that is a combination
> +keyboard + touchpad device.  This binding does not cover an Elan device with
> +pid 0x0400 that is solely a standalone touchpad device.
> +
> +Required properties:
> +- compatible: should be "elan,combo400-i2c"
> +
> +This binding is compatible with the HID over I2C binding, which is specified
> +in hid-over-i2c.txt in this directory.
> --
> 2.17.1
>
