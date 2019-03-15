Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A235C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACAA2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552692910;
	bh=FyflPVGzpmoQw7FIx5ePXizn4R3zt2Y8metDZZvt9Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E1wPCPReAIBh6pAo/gzFFu9NT32M3OimqTnW2wG5ibQAznrrGP9kpkVNITV9tS2zU
	 g2TMaNcf845QGO4cS7T7bRzk5fKPiUGgaBTtJZwnVFwE4HmYYpTXXOT1JUeMAiggrs
	 GpHUd9Pt30gZ8T4uiNp4l08GwR3twfOr1jAcpxSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCOXfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:35:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46373 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:35:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18so9811075otl.13;
        Fri, 15 Mar 2019 16:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fvECPpM4C3X/zcVRT9zreyBbAMsS8nhKh90KW9wPAM=;
        b=LEqsDUA7iRcCQa+QhL6+PNXp82fW4sfv1XAGy7iYljxA8gK7WUZPWyNubFR9HC4WQx
         sf0XRFFQlqNi5hls2BrvPiY91ggfDfU2rz5tsY898muUWfHEhjegJkPU80tBIHra4Sdp
         btoBfDMDyfvbdbjRygPDZSFn18qHn/VRoSmtP1BvIpwhqvldQnlT2xlhWTeeSrI8XpK3
         Ycar+ZPlAqhib/4AeCwitMQTPjtbAoQC/7r+TAJ733PEVIATxd/PBH1Ak7EKaguM2Wii
         Sbj6B7aAg1izQucu2g8ofmZ0AOCIL7afg4I5VYSnr6yT9wBnbv9XhjGHodJPO2nThSjD
         ZfTA==
X-Gm-Message-State: APjAAAXoAJj2tv8a6uB6CCGkaHZb468ZNi7MrbN1bzbuDkHXJhy9Cm7o
        WQYQYhKBh5qx3WvJPzWF2d1fXso=
X-Google-Smtp-Source: APXvYqw3eNxr5l7dUhZXMR6T6wbC+poaKxwYKiMi9a2CSH1RVENN2phtoWEkpXmAQQlERWtCrk2JHA==
X-Received: by 2002:a9d:6548:: with SMTP id q8mr3545062otl.366.1552692907098;
        Fri, 15 Mar 2019 16:35:07 -0700 (PDT)
Received: from localhost (ip-108-119-106-197.ftwttx.spcsdns.net. [108.119.106.197])
        by smtp.gmail.com with ESMTPSA id p7sm1245525otl.64.2019.03.15.16.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:35:06 -0700 (PDT)
Date:   Fri, 15 Mar 2019 18:35:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, tony@atomide.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu
 doc
Message-ID: <20190315233501.GA26767@bogus>
References: <20190313123249.17258-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313123249.17258-1-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:32:46AM -0500, Dan Murphy wrote:
> Add the lm3532 device tree documentation.
> Remove lm3532 device tree reference from the ti_lmu devicetree
> documentation.
> 
> With the addition of the dedicated lm3532 documentation the device
> can be removed from the ti_lmu.txt.
> 
> The reason for this is that the lm3532 dt documentation now defines
> the ability to control LED output strings against different control
> banks or groups multiple strings to be controlled by a single control
> bank.
> 
> Another addition was for ALS lighting control and configuration.  The
> LM3532 has a feature that can take in the ALS reading from 2 separate
> ALS devices and adjust the brightness on the strings that are configured
> to support this feature.
> 
> Finally the device specific properties were moved to the parent node as these
> properties are not control bank configurable.  These include the runtime ramp
> and the ALS configuration.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v4 - Appended "ti," to TI specific properties, add enable gpio documentation,
> removed an example, moved ramp to optional parent properties - https://lore.kernel.org/patchwork/patch/1050122/
> 
> v3 - No changes - https://lore.kernel.org/patchwork/patch/1049026/
> v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
> added ranges for variable properties, I did not change the label - https://lore.kernel.org/patchwork/patch/1048805/
> 
> 
>  .../devicetree/bindings/leds/leds-lm3532.txt  | 101 ++++++++++++++++++
>  .../devicetree/bindings/mfd/ti-lmu.txt        |  20 ----
>  2 files changed, 101 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3532.txt b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
> new file mode 100644
> index 000000000000..ba793ef9b3b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
> @@ -0,0 +1,101 @@
> +* Texas Instruments - lm3532 White LED driver with ambient light sensing
> +capability.
> +
> +The LM3532 provides the 3 high-voltage, low-side current sinks. The device is
> +programmable over an I2C-compatible interface and has independent
> +current control for all three channels. The adaptive current regulation
> +method allows for different LED currents in each current sink thus allowing
> +for a wide variety of backlight and keypad applications.
> +
> +The main features of the LM3532 include dual ambient light sensor inputs
> +each with 32 internal voltage setting resistors, 8-bit logarithmic and linear
> +brightness control, dual external PWM brightness control inputs, and up to
> +1000:1 dimming ratio with programmable fade in and fade out settings.
> +
> +Required properties:
> +	- compatible : "ti,lm3532"
> +	- reg : I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : gpio pin to enable (active high)/disable the device.
> +	Range for ramp settings: 8us - 65536us

This should be after the 2 ramp properties.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
 
> +	- ramp-up-us - The Run time ramp rates/step are from one current
> +		       set-point to another after the device has reached its
> +		       initial target set point from turn-on
> +	- ramp-down-us - The Run time ramp rates/step are from one current
> +			 set-point to another after the device has reached its
> +			 initial target set point from turn-on
