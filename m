Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37265CA9ED0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E05D217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572933741;
	bh=KFgNvjhV8z50ebg2IkgbDo6jid0Piy8S1PxthxlNKiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YTGFb8/U/p7VSW+9Y5TymjhstqsIdjLdeb4HJBoSF3J0aZdGDI+dO4B6kH2QjYKAs
	 1HI63CqxR5I2eSQkTBhv1EPWJrGhGIwBGf2hx2SOPy2EPhk2jgMa/yr/Av1hqx98US
	 yXaiE8qTLmF0DQiw6MkjrQv8XfHPz4GQbJ69cJVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfKEGCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKEGCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:02:19 -0500
Received: from localhost (unknown [106.201.60.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9287B20818;
        Tue,  5 Nov 2019 06:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572933738;
        bh=KFgNvjhV8z50ebg2IkgbDo6jid0Piy8S1PxthxlNKiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osliMbfsNrr8XUkOvULQ1RjjJHqKhSa5XEy9LlMknMMTxauzajAPo7WCPeh6hR8wG
         cySsl6Ut7FQvRz3EF9h4LabN78s2FmYa5ZcTs4YUwZ4pjcJiJUDye8G+Ekl1sEs0Uw
         jCZRgJqfMjapfWl90Lxnnwoet7WHHGDDZULBwpYI=
Date:   Tue, 5 Nov 2019 11:32:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: ufs: Add sm8150 compatible string
Message-ID: <20191105060212.GW2695@vkoul-mobl.Dlink>
References: <20191024074802.26526-1-vkoul@kernel.org>
 <20191024074802.26526-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024074802.26526-2-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-10-19, 13:18, Vinod Koul wrote:
> Document "qcom,sm8150-ufshc" compatible string for UFS HC found on
> SM8150.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

Martin,

Would you mind picking this up, Rob has acked this

> ---
>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index d78ef63935f9..415ccdd7442d 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -13,6 +13,7 @@ Required properties:
>  			    "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  			    "qcom,msm8998-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  			    "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +			    "qcom,sm8150-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
>  - interrupts        : <interrupt mapping for UFS host controller IRQ>
>  - reg               : <registers mapping>
>  
> -- 
> 2.20.1

-- 
~Vinod
