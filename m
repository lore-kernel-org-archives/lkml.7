Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8AC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F765214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573019875;
	bh=N5o6peU//PMnucYwpKTzl5eOldbEpdCTD+gxenP5XhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0wRPs5NeEuUcwEAPc2HOJpc07n7nzWWIytozFz1Si8tg7Jn3/iVkfQ6rUigKftBZ
	 u8+ZtZWRf/g1Layqvhr3d5yOj9UotlyHsteg6Gq7JDS20hRxRuwXlam2NosVVkuiB5
	 O9pNIwPApkToE1onbQCRP6ly7oWssJjeLQtvIAx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKFF5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 00:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfKFF5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 00:57:54 -0500
Received: from localhost (unknown [223.226.46.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09372075C;
        Wed,  6 Nov 2019 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573019873;
        bh=N5o6peU//PMnucYwpKTzl5eOldbEpdCTD+gxenP5XhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dn+xsot+H/yGLg+PgZ8A2MOcl35y9FI53m8jE3cDAhNaVsy79TYpqnD+lWGRbCJ/Q
         mn562CmBzhd/gQJLDmOPZZZjrTfj4AuHggkZfhlvfvJ9A7jT2Tzebvu6hPOgxzgJaG
         eOavqH9CFePaoGWpIgeGoXK3V3vXR76QZo5PiG7A=
Date:   Wed, 6 Nov 2019 11:27:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy
 compatible string
Message-ID: <20191106055748.GI952516@vkoul-mobl>
References: <20191024074802.26526-1-vkoul@kernel.org>
 <20191024074802.26526-3-vkoul@kernel.org>
 <20191105060249.GX2695@vkoul-mobl.Dlink>
 <733450bb-640a-c680-7e36-3f0192a9b996@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733450bb-640a-c680-7e36-3f0192a9b996@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 10:56, Kishon Vijay Abraham I wrote:
> Vinod,
> 
> On 05/11/19 11:32 AM, Vinod Koul wrote:
> > On 24-10-19, 13:18, Vinod Koul wrote:
> >> Document "qcom,sdm845-qmp-ufs-phy" compatible string for QMP UFS PHY
> >> found on SM8150.
> >>
> >> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Kishon,
> > 
> > Can you pick this and 3rd patch please
> 
> This is already in phy -next. Will be sending a PR to Greg today.

Thanks, I never got the auto notification so was thinking that these are
not applied.
-- 
~Vinod
