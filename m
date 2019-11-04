Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6999CCA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DB721D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572830256;
	bh=scf8hGpxuBP5bt4EZ25jeD6UOciso7RymcE5KJUwMuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HsEnXzYAIdQlpzXT6zCtfy4v13QDlHkdx+1RW3t02kwHpwU8w0RViy6rOqQ4Itzhj
	 NSNPNEhqOPT/7DLS2eMMP7nOOUrLBwKtCTA/zFdba+Xj8ADA8WONdbwltvoa3/FMMJ
	 0KAfcYUvnhZsL/nN60Iz3r8K6ukfo2r9WlklBZbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfKDBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfKDBRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:17:25 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B17A2190F;
        Mon,  4 Nov 2019 01:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572830244;
        bh=scf8hGpxuBP5bt4EZ25jeD6UOciso7RymcE5KJUwMuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZxqcesFpem7Rr+G5Ar3yrcGqocotO2RgrD7WCrz1KnojZ4p1MeeT05lHAjsVeZHS
         Wo/Rqr1ygopwkQr7OLJkG4HUZDGATxPw0McQRjfx7tMs41qdGZrhucYUX9i7FVgaq9
         jVDKmoBSnyyAPfkHLxZN6v/E5fbXCyHlORUCwxsY=
Date:   Mon, 4 Nov 2019 09:16:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] arm: dts: vf-colibri: fix typo in top-level
 module compatible
Message-ID: <20191104011657.GE24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-1-marcel@ziswiler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:03:59AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix typo in top-level module compatible.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2: New patch.
> 
>  arch/arm/boot/dts/vf500-colibri.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
> index 237b0246fa84..92255f8893ce 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -44,7 +44,7 @@
>  
>  / {
>  	model = "Toradex Colibri VF50 COM";
> -	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
> +	compatible = "toradex,vf500-colibri_vf50", "fsl,vf500";

Do we need to update bindings doc for this?

Also as a practise, we use 'ARM: ...' for arch/arm/ patches going through
IMX tree.

Shawn

>  
>  	memory@80000000 {
>  		device_type = "memory";
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
