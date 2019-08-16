Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF65DC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 04:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565929556;
	bh=/MYMccNm5AOcDF4fcw2T3SZ4z2RQifqv523alxazfQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LxOlTvgRGQFQj/2ikaoBD8SoYj2mz2YRG4S7osD8yrvFujN6qvOSqQZiGlui9dMyL
	 jQwwkp5sKUDSAMZRC7BGrG03XJY+lnLox1f4bfTPUv0fV6Kxw72zXf+pFZbi+Lxd5Z
	 UHwg9GWbtvavt1JrrZIxS7oPusUaOCjkD2O5VOWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfHPEZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 00:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfHPEZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 00:25:55 -0400
Received: from localhost (unknown [106.51.111.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88682064A;
        Fri, 16 Aug 2019 04:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565929554;
        bh=/MYMccNm5AOcDF4fcw2T3SZ4z2RQifqv523alxazfQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgdHzz5cVViScm6CVd/sGvDJDZN9V9Yxrp4xBeM/K4D2NXS+avIzggzH7E/R2OSRt
         gLFeIkk0mD+fQDIs9iiXMW6/tKYTEwedspAQT4r1nPbIjgX2Q+0wLDB39jelaf2fXu
         EWoWlWA3zFtLGpKDIbYCz7pLctSLJtU0C+duU8Hs=
Date:   Fri, 16 Aug 2019 09:54:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: clk-rpmh: Add support for SM8150
Message-ID: <20190816042440.GY12733@vkoul-mobl.Dlink>
References: <20190814122958.4981-1-vkoul@kernel.org>
 <20190814122958.4981-2-vkoul@kernel.org>
 <20190814171946.E9E8D20665@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814171946.E9E8D20665@mail.kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-08-19, 10:19, Stephen Boyd wrote:
> Quoting Vinod Koul (2019-08-14 05:29:58)
> > Add support for rpmh clocks found in SM8150
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Patch looks OK, but can you convert this driver to use the new parent
> style and then update the binding to handle it? We can fix the other
> platforms and dts files that use this driver in parallel, but sm8150
> will be forward looking.

Yes but that would also impact sdm845 as it uses this driver, so I
wanted to get this one done so that we have support for rpm clock and
then do the conversion.

Would that be okay with you to get this in and then I convert this?

Thanks
-- 
~Vinod
