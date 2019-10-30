Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8E9CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572444225;
	bh=A04nh4aYz+/r7x4zYtrJJM+MuinQXq+nJ9ET4ejFiiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4xHgTpXRAQz17Xmh6L6soOXfXBaNwRuLxl4BrXZTXi4cs9ifGukNk+W5mQ2CNVKV
	 xMajU032Rf6t1HJJD85BhdAFscz5f71PPCxIimDlsRVgKS9CYNg5aTyJDjDIlzQh/9
	 bMFJh2KgxWzxkLjHDu8ov5OTsaLu0ViUd4X1d0jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJ3ODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:03:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44420 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3ODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:03:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id s71so2021735oih.11;
        Wed, 30 Oct 2019 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AN38U5I1SnZ6V3pOgMZBIelT58p7AWURa3xEDYsxfVA=;
        b=KcrMKnjNB5UmkaQ3T+NrCOoziWg2PtX9p5AFPhD8EnwZl/r8AN36/vjb+EX7NvysDP
         YaKHNW4wSFnNrj6ZfWTTxiBmnmPkFgzJeHaJICPsjb6CezVonNVTv2C87rcUSZ2pMOmM
         cPrtEuMxNm8SOnBmM6+F6ENhXNJvgyZLSVOoA66TjBjhNcnP6Vml1otelkYDit7r/sXf
         vn1I4fMLkZRL1eMsEbz100ehPMov/H9BIg4bZUHoXTc9ZmuqsExxv/RPtpkEYeoQljqJ
         uh5bv7RlgYRKD6i/r+b1uxRitcJEGGzrZ+OQbbtVQiOpdUump9t3QjRAzL3nyNUQGkap
         fMUQ==
X-Gm-Message-State: APjAAAXUThnqzUb5tYbErBVpse1hJBQZVN74mn4iwGi1i4Q7YDlhVhaG
        /kHxwBMRXMgRofSKklDLmA==
X-Google-Smtp-Source: APXvYqzs4gCzKu5UGALSc99D70kO0H/Pi31X2AVwN/sFMphkC6DpupG1IrIm13xoTHG9lPhj3tKQMQ==
X-Received: by 2002:a54:4601:: with SMTP id p1mr9082779oip.113.1572444222698;
        Wed, 30 Oct 2019 07:03:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o22sm55953otk.47.2019.10.30.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:03:41 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:03:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Aisheng Dong <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: fsl: add nxp based toradex
  apalis/colibri binding docu
Message-ID: <20191030140340.GA3368@bogus>
References: <20191026090403.3057-1-marcel@ziswiler.com>
 <20191026090403.3057-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026090403.3057-2-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2019 11:04:00 +0200, Marcel Ziswiler wrote:
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
> 
> ---
> 
> Changes in v2: New patch.
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
