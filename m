Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EBB2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551758984;
	bh=g1cNorGJabFVsSeAyDTK+eDDvAvnxK6TyAwK3GHPYlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OZq3kqGmCjNwc8mCTTr8KTHxXHwNv1h4Wlm3BxMRjqONOmdXCPRduOfJSAqCovOEJ
	 2f4poUeacChewvCWceU8KlPE5/jn0Co4CL2pLT5ByZHXgVwjbFqF9NMC4qmvx09eag
	 fwO74fACIdxSiOi3bFLfgBsRkGVifZ0ICMjlptZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfCEEJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:09:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfCEEJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:09:42 -0500
Received: from localhost (unknown [27.5.25.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B043206DD;
        Tue,  5 Mar 2019 04:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551758982;
        bh=g1cNorGJabFVsSeAyDTK+eDDvAvnxK6TyAwK3GHPYlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FU2WRhVQ29AvRMeH0NFUig8k05CybVv6vIrsJrJNOq0czV1kdmXBtLAP4JyDc1W8V
         0jttsR61qx70MZWzvmZNykO2utdQqOqz950PZqSxgxQc/YCY9Hpas54JxXuojvsRC5
         i4+o3JOZT8EowPLzJOnsX/UD4Uw7PVk7rYPLnfpo=
Date:   Tue, 5 Mar 2019 09:39:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Fix regulator supply names
Message-ID: <20190305040937.GC2598@vkoul-mobl>
References: <20181213183200.3204-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213183200.3204-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 10:32, Bjorn Andersson wrote:
> The regulator definition got their supply names cleaned up during
> upstreaming, so they no longer match the driver defined names. Update
> the supply names.
> 
> Also fill out the missing voltage of SMPS 5.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

we need to also fix sdm845 dts as well as patch up the binding doc
-- 
~Vinod
