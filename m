Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916D5CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684BF21D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572830779;
	bh=H5b8DNtZ4v0LGBUCSSgXUhNmiD+cxi0RklBJpzPb+C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UqtNbuDUQxZS1LM4ZlCpPHlnnKOfpSBop3hTDrDO2//07uSuhNSBH7Tot2rFRvgpA
	 22DQW/kWQiMaMf5b5vS2dO8hk/FWvRhZPfHjKgiMjrkR+i1twcMnrYx0G5p9NNHrcT
	 EputcCvZC1WWD5AROqglqexGalAJZrUwDgQetn+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfKDB0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfKDB0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:26:18 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2BD2190F;
        Mon,  4 Nov 2019 01:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572830777;
        bh=H5b8DNtZ4v0LGBUCSSgXUhNmiD+cxi0RklBJpzPb+C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK39a/nlPsnsiKDhW53T+IFhnpsK6NVQ1bn2O5AguqBCM+oelWDor6P8uYZbQlom0
         xczE6ClvfP3gtJllNvhhUFA3w9OnHdZQuzau0Cr7D/iggoCR+T7Cvwromnbxj8j1D9
         yJV0DHXxTyd+OyEZuA6FR6DK+qTvKyX8LsRfWN3E=
Date:   Mon, 4 Nov 2019 09:25:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Aisheng Dong <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-imx@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add nxp based toradex
 apalis/colibri binding docu
Message-ID: <20191104012550.GG24620@dragon>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-2-marcel@ziswiler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:04:00AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Document the following NXP SoC based Toradex Apalis and Colibri module
> and carrier board devicetree bindings already supported:
> - toradex,apalis_imx6q            # Apalis iMX6 Module
> - toradex,apalis_imx6q-eval       # Apalis iMX6 Module on Apalisi
> 				    Evaluation Board
> - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
> - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
> 
> - toradex,colibri_imx6dl          # Colibri iMX6 Module
> - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri
> 				    Evaluation Board V3
> 
> - toradex,colibri-imx6ull-eval            # Colibri iMX6ULL Module on
> 					    Colibri Evaluation Board
> - toradex,colibri-imx6ull-wifi-eval       # Colibri iMX6ULL Wi-Fi /
> 					    Bluetooth Module on Colibri
> 					    Evaluation Board
> 
> - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
> - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on
> 				    Colibri Evaluation Board V3
> 
> - toradex,colibri-imx7d                   # Colibri iMX7 Dual Module
> - toradex,colibri-imx7d-emmc              # Colibri iMX7 Dual 1GB (eMMC)
> 					    Module
> - toradex,colibri-imx7d-emmc-eval-v3      # Colibri iMX7 Dual 1GB (eMMC)
>                                             Module on Colibri Evaluation
> 					    Board V3
> - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on
> 					    Colibri Evaluation Board V3
> - toradex,vf500-colibri_vf50              # Colibri VF50 Module
> - toradex,vf500-colibri_vf50-on-eval      # Colibri VF50 Module on
> 					    Colibri Evaluation Board
> - toradex,vf610-colibri_vf61              # Colibri VF61 Module
> - toradex,vf610-colibri_vf61-on-eval      # Colibri VF61 Module on
> 					    Colibri Evaluation Board
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

I changed the subject a little bit as below.

  dt-bindings: arm: fsl: add nxp based toradex apalis/colibri bindings

Shawn
