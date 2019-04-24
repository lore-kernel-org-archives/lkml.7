Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B140AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818BE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="eryQ6v9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfDXM0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:26:52 -0400
Received: from onstation.org ([52.200.56.107]:39686 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfDXM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:26:50 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D2C723EE68;
        Wed, 24 Apr 2019 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1556108810;
        bh=5456suJdwQi3jDNmJrBR924dnZZwBJKzDwzKI7AhJo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eryQ6v9+ILAEhdX8eIG8X8klgcc5dws1UewjecnSFlIspuLzEuF7Z94RlsSoSce/s
         6R5d4esZB46pjF419IDUq89Co4OUD9359qvjnM8szo6kq5PWUiNOoZCAxAsSkbImIF
         RrTpklWqmnWehPB6K1hkqRAFI9ueJnVfzuBX0zr4=
Date:   Wed, 24 Apr 2019 08:26:48 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: tsl2772: convert bindings to
 YAML format
Message-ID: <20190424122648.GA15745@basecamp>
References: <20190424092238.6381-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424092238.6381-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:22:37AM -0400, Brian Masney wrote:
> Convert the tsl2772 device tree bindings to the new YAML format.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - Dropped description from reg and interrupts properties.
> - Dropped $ref from led-max-microamp, vdd-supply, and vddio-supply.
> - Changed 'tsl2772@39' in example to 'proximity-sensor@39'

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        proximity-sensor@39 {

I didn't think of this until after I sent out that patch, but I think
this example should be 'als-proximity-sensor@39' instead of
'proximity-sensor@39'.

Brian
