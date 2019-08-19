Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DEBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA8622CED
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566236274;
	bh=dEDXfAnfcoMcmJDku9plh5mE9JXFAcNBcVLQ8PO00jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OeVyQxDW3Sc1ArQSQAktgMsHFnbEn9jHfC6KFBWx2GXP02uw+heBK3L9A5vhXXvfq
	 WawDvpo0OLFGrwA8JKD0TlTc36vAUWoNGcXzSvPX85R0MF7t6cPOhKFJyErEsZ6cAT
	 q8NJfhj+JpCQK/wzmj0e6AHE6LQ4EpeLppLZ60FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfHSRhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfHSRhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:37:52 -0400
Received: from localhost (unknown [122.182.221.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C716122CE9;
        Mon, 19 Aug 2019 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566236271;
        bh=dEDXfAnfcoMcmJDku9plh5mE9JXFAcNBcVLQ8PO00jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aN0RAX94mpGJDCPfJ4MAGUGDGXjIDzHiWSeuSd/Qklejqrm/lG35/yZY3ScIMG2yq
         KhRefx/hElkvk+RmYMbkX+5NS047BhWqmTNt7pNPA2V2f2AgvzuAsYh1qbNcHKgZJL
         cN0qzjzAp1PCgpNbFYRBh8/Vpo2hdGm6QFmXVzv0=
Date:   Mon, 19 Aug 2019 23:06:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] arm64: dts: qcom: sm8150: Add reserved-memory
 regions
Message-ID: <20190819173635.GL12733@vkoul-mobl.Dlink>
References: <20190814125012.8700-1-vkoul@kernel.org>
 <20190814125012.8700-19-vkoul@kernel.org>
 <20190814171320.2F7162063F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814171320.2F7162063F@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-08-19, 10:13, Stephen Boyd wrote:
> Quoting Vinod Koul (2019-08-14 05:50:08)
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index 5258b79676f6..7111e1f092f4 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -153,6 +153,117 @@
> >                 method = "smc";
> >         };
> >  
> > +       reserved_memory: reserved-memory {
> 
> Does this need a label?

will remove

> 
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               hyp_mem: memory@85700000 {
> > +                       reg = <0x0 0x85700000 0x0 0x600000>;
> > +                       no-map;

-- 
~Vinod
