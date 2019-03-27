Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90758C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F74020700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715803;
	bh=ktDEUne7z5JdXMaooLEMhmnvEROR4b+vJz7Rb4IfjbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lh+HTUyhlC0uKtXRyPCXW57bWBxYZvBS1K7xUxUGQRjd5BLBjGQeQdoDt4badz/9G
	 z9e8xtW/SCz7DMsniJFqkb4dsosNUDdb7Shsn36OepBS3aLybEjT+fxawFd1CsKc01
	 L8EeHRs+g/kwOmAg4LPRpHSYJIjiICtj6L4Eag+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfC0TnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:43:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46198 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbfC0TnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:43:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so6575855otk.13;
        Wed, 27 Mar 2019 12:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7pi9ofBkYi3bzenLZmSeRBGl8/MABGuZwMrXN/vYfQ=;
        b=ZVPs/xUazD+5sR2l/VLefvagYJ0z2te7Nuu9ni8c0swjBwUn52NzJ7VH7Sov5LQ3nf
         adHuCxIt4Z+hfSHtXbHZS7F4hAQcfBRDc4Vimlylj/aUxgn9ZFM2UlrcWhLeEPRfoZnu
         LpetqsNOBdhHudfuKlhS0UI9dRrZn4tn2FYue1/bUTn44sT30Wxjem4ok2GhUDT1grqj
         Q85vvUfw6m4taGR0hKaOxRkdTz5VZJUUGQUzpSKxGX9BRPfzakj4cOj1cC+BNfXxEk2P
         TUxzZcdVhscSuooLE0WLcJWbPRKcy2pX3jfH7C7feElMDsw1PzAdGhoxiKXah2/zEH0p
         s13w==
X-Gm-Message-State: APjAAAUPR0ckGaqjiOFn4Zy8s7iZDZjtBdfNOm5fK+I/AjRRDB/i8T3v
        FbwQPK6wTBP12bS/8ScRGw==
X-Google-Smtp-Source: APXvYqzNitN2x53nCHSxb5tJIobX6UkUQrzaOyyfrBHSBIsBkh9vBpRKKufT5/wAqx/w77664nQozA==
X-Received: by 2002:a9d:7309:: with SMTP id e9mr23047073otk.93.1553715800704;
        Wed, 27 Mar 2019 12:43:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f90sm5150541otb.54.2019.03.27.12.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:43:20 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:43:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: add GPIO controllable vibrator
Message-ID: <20190327194319.GA20142@bogus>
References: <20190302141132.21160-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302141132.21160-1-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 03:11:30PM +0100, Luca Weiss wrote:
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../devicetree/bindings/input/gpio-vibrator.txt  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> new file mode 100644
> index 000000000000..9e2e9acf497b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> @@ -0,0 +1,16 @@
> +* GPIO vibrator device tree bindings
> +
> +Registers a GPIO device as vibrator, where the vibration motor just has the capability to turn on or off. If the device is connected to a pwm, you should use the pwm-vibrator driver instead.

Need to wrap line.

> +
> +Required properties:
> +- compatible: should contain "gpio-vibrator"
> +- enable-gpios: Should contain a GPIO handle
> +- vcc-supply: Phandle for the regulator supplying power

This should probably be optional. There may not be a s/w controllable 
supply.

> +
> +Example from Fairphone 2:
> +
> +vibrator {
> +	compatible = "gpio-vibrator";
> +	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +	vcc-supply = <&pm8941_l18>;
> +};
> -- 
> 2.21.0
> 
