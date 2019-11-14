Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48BAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E33206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573765961;
	bh=xeQdHHmujO3g/xtL57PfaYtfFAR7qTcVsCN5PdcuEtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfIWtIHpCXvf5xkVovkyjEezC0lf5BrSDZShVIXrJCoxv3NoUceqAhi5fbmtADZQn
	 aHKvblNkLn+EY4JviQN/P1/w3RSxaYTbS8heRCpLCXzrx7QtL4A3mXVbMiNvWldzOs
	 xXMyBSbmDnhHjMK/xZAGcUosB1aKVQ7KBcgNYqEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKNVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:12:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40869 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:12:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so6156150otq.7;
        Thu, 14 Nov 2019 13:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvJ3vYdB8JByuq1iptWHcxe6mCz9VbGiKAhz94z7Jjs=;
        b=WR91Ze7q3/8W15JazJLi7mKamQIUbAs28NGJQ0hfjo5YA6IiQQHayXrMe1/DovtQvv
         Hg5YPhxPnkwh1tPTXr6BryEWjdVyZH2JKIs0bm6PAnnxMfMlv439U/I/hx/BeRvjXBXo
         I7CFzvV5pWEzypZ2XFtr4w7BJyUrQn4sjvcereHCBg5wc8Zyb6KKNxvZc7+IV90s2HOe
         PpFVWt3MhUANLcwlDm63dW4wh0aU/PQeTWWLh737CUazfznlWaXGr7crWLRTuFLAvZ4b
         eSn3CfCYAe8kJzjnkdMwsoTYpL7Zef6WRj980kHs/UGA/ranFrJwN7dlkO69sTonZ+qa
         Iwlw==
X-Gm-Message-State: APjAAAW/Q7ZoVHnZ1uGnbG0YMYxfhgTQpD8oRc00YH9XEV8YcMuAyiwO
        h6oMd7KvPc1Gt8RftWmMDg==
X-Google-Smtp-Source: APXvYqz8E8q2ODWg7w9RAtKtDXpxQsWSKNIjjna819fVptPrU8ODwyU1Lli9pn6nDszkJRnxfqhL5A==
X-Received: by 2002:a9d:7e8a:: with SMTP id m10mr9243800otp.180.1573765959077;
        Thu, 14 Nov 2019 13:12:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm2171825oti.49.2019.11.14.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:12:38 -0800 (PST)
Date:   Thu, 14 Nov 2019 15:12:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm
Message-ID: <20191114211237.GA25375@bogus>
References: <b1c922b3496020f611ecd6ea27d262369646d830.1573462647.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c922b3496020f611ecd6ea27d262369646d830.1573462647.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:18:22PM +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx8qm-asrc" for imx8qm platform.
> 
> There are two asrc modules in imx8qm, the clock mapping is
> different for each other, so add new property "fsl,asrc-clk-map"
> to distinguish them.

What's the clock mapping?


> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> -none
> 
> changes in v3
> -use only one compatible string "fsl,imx8qm-asrc",
> -add new property "fsl,asrc-clk-map".
> 
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index 1d4d9f938689..02edab7cf3e0 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -8,7 +8,8 @@ three substreams within totally 10 channels.
>  
>  Required properties:
>  
> -  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible		: Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +			  "fsl,imx8qm-asrc".
>  
>    - reg			: Offset and length of the register set for the device.
>  
> @@ -35,6 +36,13 @@ Required properties:
>  
>     - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
>  
> +   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
> +			  by imx8qm/imx8qxp platform
> +			  <0> - select the map for asrc0 in imx8qm
> +			  <1> - select the map for asrc1 in imx8qm
> +			  <2> - select the map for asrc0 in imx8qxp
> +			  <3> - select the map for asrc1 in imx8qxp

Is this 4 modes of the h/w or just selecting 1 of 4 settings defined in 
the driver? How does one decide? This seems strange.

imx8qxp should perhaps be a separate compatible. Then you only need 1 of 
2 modes...

Rob
