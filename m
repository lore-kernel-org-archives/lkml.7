Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059EEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53FC222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570205909;
	bh=UoQ1ww8PIJpk0xmOR9f8QWpU6QAti8ZQPMjess4Wl04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U1CyGMF75mR8Gl0XpzVThqzBZ9ffUntA/rLc9Cs4owUi5oax+6uQQThlbZ6YPWCOy
	 /gW5CFtkFD309Hks9ZaZ4i5KlZ+oHgZCPBdXAAaBV8CocN7rJKnIxlj4pYJWpSRGe9
	 wuA+hVnrN+RJZuoGekwATLhprXG0wTPKxUc3U31k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfJDQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDQS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:18:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7750F20873;
        Fri,  4 Oct 2019 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570205908;
        bh=UoQ1ww8PIJpk0xmOR9f8QWpU6QAti8ZQPMjess4Wl04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QaLBSHhvmvJGsM2YN9Cx0Fsm/UWt0/IlVRYTSAHH0ckuw4hC2hL+yvN8dy5YiMdl8
         COwQFOSU86fbSoauwCNrl+B2y/4/mfnbEKX77EvbusMCRHvLFEDLXIAPs16YU7ChzR
         kzDPLndVv6cfzSbINKCVAfJlXAHOIac46GOLjhgA=
Date:   Fri, 4 Oct 2019 18:18:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: firmware: Add bindings for Versal
 firmware
Message-ID: <20191004161825.GB854302@kroah.com>
References: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
 <1569613206-20189-2-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569613206-20189-2-git-send-email-jolly.shah@xilinx.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:40:05PM -0700, Jolly Shah wrote:
> ZynqMP firmware driver can be used for versal also.
> Add versal compatible string to zynqmp firmware driver
> doc.
> 
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index a4fe136..18c3aea 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -11,7 +11,9 @@ power management service, FPGA service and other platform management
>  services.
>  
>  Required properties:
> - - compatible:	Must contain:	"xlnx,zynqmp-firmware"
> + - compatible:	Must contain any of below:
> +		"xlnx,zynqmp-firmware" for Zynq Ultrascale+ MPSoC
> +		"xlnx,versal-firmware" for Versal
>   - method:	The method of calling the PM-API firmware layer.
>  		Permitted values are:
>  		  - "smc" : SMC #0, following the SMCCC
> @@ -21,6 +23,8 @@ Required properties:
>  Example
>  -------
>  
> +Zynq Ultrascale+ MPSoC
> +----------------------
>  firmware {
>  	zynqmp_firmware: zynqmp-firmware {
>  		compatible = "xlnx,zynqmp-firmware";
> @@ -28,3 +32,13 @@ firmware {
>  		...
>  	};
>  };
> +
> +Versal
> +------
> +firmware {
> +	versal_firmware: versal-firmware {
> +		compatible = "xlnx,versal-firmware";
> +		method = "smc";
> +		...
> +	};
> +};
> -- 
> 2.7.4
> 


For new dt bindings, don't you have to cc: the dt maintainers and
mailing list?  I can't take the patch until I get an ack from them.

thanks,

greg k-h
