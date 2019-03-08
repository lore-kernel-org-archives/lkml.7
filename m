Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A4520684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCHMHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:07:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34599 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfCHMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:07:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id a16so16233224edn.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 04:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//WICpYL2sIU8xG0IGhIJRsEKn5vd6H7DZAjSt6+vEw=;
        b=FZTNUfCSe0yVyRK2Rf5SxMjyw2gM8REIvZFIx1nPGB18OJwNy8GNyDdxoWzSkMsRx/
         C6vF2kHHRfujl2SZq+1RtMaCh1T4Cn5qqsg+bmNjQcGX/8TiUrRW+MqBiLjamcj1RuQZ
         rb3BVFqcz4oZESumejrGBscYLTK80hn7nurZwwiPB9Tudhs22ABXt5AHWxP3UcmNJ9fm
         2OFVFIpfZ2TaM8VU5NIxt7D0XlNlVCtJ5YFFvYiGPNyiHdbvPQbSIII1gzsJ3lmKtfLv
         50aS6iBJ2xBYLs4nVXAlQtgeLcXoa7wOF3heeW/h1WmYzThIptEhlG9Eaz8NQ3Psa+rd
         ILVQ==
X-Gm-Message-State: APjAAAW3O/976paDb6XAf5F8Vqf4NDvE7AJITNqRcoGCt1LOrt080jo3
        gKEscGJ2xKwV+JkHMST2yk1nTg==
X-Google-Smtp-Source: APXvYqz2Bey2O5sZtOvfrAkNpkMvFQFIQ6mYIruzgkJXIEeL4Rnm2HxsdcGy74unbr9mO41E+WOEmw==
X-Received: by 2002:a50:9fe9:: with SMTP id c96mr33245420edf.0.1552046860040;
        Fri, 08 Mar 2019 04:07:40 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x21sm1397221ejf.65.2019.03.08.04.07.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 04:07:39 -0800 (PST)
Subject: Re: [PATCH 1/5] dt-bindings: connector: add optional properties for
 Type-B
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1552025622-15582-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <693b11e7-fa9e-ab1f-561a-beb758b1872f@redhat.com>
Date:   Fri, 8 Mar 2019 13:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552025622-15582-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08-03-19 07:13, Chunfeng Yun wrote:
> Add id-gpios, vbus-gpios, vbus-supply and pinctrl properties for
> usb-b-connector
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   .../devicetree/bindings/connector/usb-connector.txt    | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> index a9a2f2fc44f2..7a07b0f4f973 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -17,6 +17,16 @@ Optional properties:
>   - self-powered: Set this property if the usb device that has its own power
>     source.
>   
> +Optional properties for usb-b-connector:
> +- id-gpios: gpio for USB ID pin.

What about boards where the ID pin is *not* connected to a GPIO,
but e.g. to a special pin on the PMIC which can also detect
an ACA adapter ? Currently this case is handled by extcon
drivers, but we have no way to set e.g. vbus-supply for the
connector. Maybe in this case the usb-connector node should
be a child of the PMIC node ?

And in many cases there also is a mux to switch the datalines
between the host and device(gadget) controllers, how should
that be described in this model?  See the new usb-role-switch
code under drivers/usb/roles

In some cases the mux is controlled through a gpio, so we
may want to add a "mux-gpios" here in which case we also
need to define what 0/1 means.

> +- vbus-gpios: gpio for USB VBUS pin.
> +  see gpio/gpio.txt.
> +- vbus-supply: reference to the VBUS regulator, needed when supports
> +  dual-role mode.

I think this needs some text that there can be either a vbus-gpio or
a vbus-supply. Oh wait reading:

https://patchwork.kernel.org/patch/10819377/

I see that this GPIO is for detecting vbus presence, not for driving/enabling
5v to Vbus from the board, that needs to be described more clearly.

> +- pinctrl-names : a pinctrl state named "default" is optional
> +- pinctrl-0 : pin control group
> +  see pinctrl/pinctrl-bindings.txt
> +
>   Optional properties for usb-c-connector:
>   - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
>     connector has power support.
> 


Regards,

Hans
