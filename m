Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD4C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DB120842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573405188;
	bh=8dVT8BgeHXIXHuCYidGlWKtrVnbHRYVwt7D/0lF4UqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FQFYAQE99aF34fWD9Ve6qVQcN2BAZbVuWOV+4brxFypJMw/y4gU9Zzslr3Y5ydgrV
	 tPR9Ei1aftv7lRNSZ8uIuxTp1atZd2T82vLscKdaU3y/Hy1M4Fw3qhJAxNnPawvWO2
	 xXi0jlvHaVXj+WBpz6HWvcqt0oJi9E+tckOUKi9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKJQ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKJQ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 11:59:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219EC2080F;
        Sun, 10 Nov 2019 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573405185;
        bh=8dVT8BgeHXIXHuCYidGlWKtrVnbHRYVwt7D/0lF4UqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cAZB9iDmmdLS89j9z//pZ9Z8hMZk1r84WbUMT1qH9+F74bsmXo09l6eyVAFtol2bA
         BDc92NAtFU5YlZXYELx9VsUxcfFPyCv+DU2cmUoGNj17kGfEMwNdNk2uuW53qgvsZR
         oly/jhLhS489GJFLLcHRnxkB47UHD/JLawiajj1s=
Date:   Sun, 10 Nov 2019 16:59:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: add parallax ping sensors
Message-ID: <20191110165938.2f680803@archlinux>
In-Reply-To: <20191107130027.k2uo547xrfiuxgb7@arbad>
References: <20191107130027.k2uo547xrfiuxgb7@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 14:00:29 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add dt-bindings for parallax PING))) and LaserPING iio sensors, which
> are used for measuring distances.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/parallax-ping.yaml      | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> new file mode 100644
> index 000000000000..ab8dbdf4f04a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

Rob has been asking people if they mind adding a BSD-2-CLAUSE as an
and additional license on new bindings they have the copyright on.

Otherwise seems fine to me.

Thanks,

Jonathan

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/parallax-ping.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Parallax PING))) and LaserPING range finder
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Bit-banging driver using one GPIO:
> +  - ping-gpio is raised by the driver to start measurement
> +  - direction of ping-gpio is then switched into input with an interrupt
> +    for receiving distance value as PWM signal
> +
> +  Specifications about the devices can be found at:
> +  http://parallax.com/sites/default/files/downloads/28041-LaserPING-2m-Rangefinder-Guide.pdf
> +  http://parallax.com/sites/default/files/downloads/28015-PING-Documentation-v1.6.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - parallax,ping
> +      - parallax,laserping
> +
> +  ping-gpios:
> +    description:
> +      Definition of the GPIO for the triggering and echo (output and input)
> +      This GPIO is set for about 5 us by the driver to tell the device it
> +      should initiate the measurement cycle. Afterwards the GPIO is switched
> +      to input direction with an interrupt. The device sets it and the
> +      length of the input signal corresponds to the measured distance.
> +      It needs to be an GPIO which is able to deliver an interrupt because
> +      the time between two interrupts is measured in the driver.
> +      See Documentation/devicetree/bindings/gpio/gpio.txt for information
> +      on how to specify a consumer gpio.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - ping-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    proximity {
> +        compatible = "parallax,laserping";
> +        ping-gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +    };

