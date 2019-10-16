Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF06ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44CA2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571203321;
	bh=VHY99++RfSl8s+nSWmgOqnp+kTpexLHoSm9oMu3ZpXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KFkZRgTpURGOD2G1p+dVMfkLhkTYSit8LKEFaz5gKUuxl6+ZiMwjC0T+sAg7Xsgno
	 QdHrxcIeTmhTiknqkhEUDebyXrfSjtsZnRxDogocrc4b9CSMAHIIuF7gApjDUa2onY
	 fn0VCgfzLov0ckqmJoyKGvM5w18/F5PBWzlpPBBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfJPFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfJPFWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:22:00 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 010602067D;
        Wed, 16 Oct 2019 05:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571203319;
        bh=VHY99++RfSl8s+nSWmgOqnp+kTpexLHoSm9oMu3ZpXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+U+GAJBpSf3zYyy4+s5ylCtWl7b4N/vbVYC9S69ak3plpas/o1vq1rev+nz+9Q/d
         zZky42vCKOH3r8869/ttKoTm0/bV4I6OYWmB06RabU0FkhCrNrGsIg1idQNtxMHuN1
         xPkK31iE51C37dJF4OvP6Z6jzWybMCiIn/r1xQoY=
Date:   Wed, 16 Oct 2019 10:51:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: qcom: Add SC7180 bindings
Message-ID: <20191016052154.GB2654@vkoul-mobl>
References: <20191015103358.17550-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015103358.17550-1-rnayak@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-19, 16:03, Rajendra Nayak wrote:
> Add a SoC string 'sc7180' for the qualcomm SC7180 SoC.
> Also add a new board type 'idp'

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index e39d8f02e33c..0a60ea051541 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -36,6 +36,7 @@ description: |
>    	mdm9615
>    	ipq8074
>    	sdm845
> +  	sc7180
>  
>    The 'board' element must be one of the following strings:
>  
> @@ -46,6 +47,7 @@ description: |
>    	sbc
>    	hk01
>    	qrd
> +  	idp
>  
>    The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
>    where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

-- 
~Vinod
