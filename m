Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A375FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B1220869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573087565;
	bh=1KOmyKGo87SrzodW3OLbAx00WBNi0y7bVelDGT8Yc3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DOSb4M1AjpP++82YBIAbm3Sl9mqGUqUr/D0ifNHWydhmqcubN0eJU7soeg1cJkSJb
	 P76YApLbU9VcOJ5BXLm4nxyE/e8OBjQTw5yQkEt/JljcsYCqVAOqT5BAJL7LuMYycn
	 g+ky7mS9sF8z9t19xRXYzEgpSfftN1cBel/nc5YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbfKGAqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:46:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36416 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:46:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id j7so453370oib.3;
        Wed, 06 Nov 2019 16:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gKYU75NcpNmTXMd0sfcN/iIV3zAqEzJPBb9kI5/Kto=;
        b=U6KFf38etIn2RzALWalyNC6tsudhVMx8CLAQDsqckEWwMHEpiGOR9MGeemjg0UOZQ1
         zPwzfh9r8CduhWB9C6RF9jnQHxOV0gTTu1Edzr2Ae7LgpmESXrqPUTm33OPSw68TRWZe
         3FvQiZfKKhZpzt117mcOJQwyKWel13BDd/Nk2yBUxBP9W1DiNmUI35mo9rWHpnYtG//4
         bQ20Q4/IHMAGwhpuFdF7N9gY+1exhN6yGc3/c+mMzuyZ60xdmELNyrLOWRBVuY/NjzXS
         Egsd0f1LFyyuYPViYtBZeUtw5WpZNs0cl7Q0kxk1y3RX1uqdVqLj1Csbwzlr2N8LCIz8
         BUuA==
X-Gm-Message-State: APjAAAX5DwXwiqf+1Wm064mpRhnFdA57FlOAtXlFHvzonDxzXonaimqh
        4VNBVst4PhvyHKbJK1Pf9w==
X-Google-Smtp-Source: APXvYqyxC5qijCgvXTCtz8C5GVHYmbX7saK5/A84LdWm0eTBTY1n3iy3Ah56R4wGDPUz5rGkF2RNeg==
X-Received: by 2002:aca:b757:: with SMTP id h84mr750743oif.175.1573087562633;
        Wed, 06 Nov 2019 16:46:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o11sm137500oif.34.2019.11.06.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:46:02 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:46:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/4] dt-bindings: net: bluetooth: update
 broadcom-bluetooth
Message-ID: <20191107004601.GA14629@bogus>
References: <20191106002923.109344-1-abhishekpandit@chromium.org>
 <20191106002923.109344-5-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106002923.109344-5-abhishekpandit@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:29:23PM -0800, Abhishek Pandit-Subedi wrote:
> Add documentation for pcm-parameters.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> ---
> 
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> index c749dc297624..ae60277b5569 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -29,6 +29,9 @@ Optional properties:
>     - "lpo": external low power 32.768 kHz clock
>   - vbat-supply: phandle to regulator supply for VBAT
>   - vddio-supply: phandle to regulator supply for VDDIO
> + - pcm-parameters: When set, will configure PCM parameters on the device. The
> +   contents should be a 10-byte array corresponding to the pcm params (see
> +   btbcm.h for more information).

Needs a vendor prefix.

>  
>  
>  Example:
> @@ -40,5 +43,6 @@ Example:
>         bluetooth {
>                 compatible = "brcm,bcm43438-bt";
>                 max-speed = <921600>;
> +               pcm-parameters = [1 2 0 1 1 0 0 0 0 0];
>         };
>  };
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
