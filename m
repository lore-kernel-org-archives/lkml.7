Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD7C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A7820866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="qZiZ4j9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgABIuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:50:21 -0500
Received: from onstation.org ([52.200.56.107]:55870 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgABIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:50:21 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7FA203E9DC;
        Thu,  2 Jan 2020 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1577955020;
        bh=Zg1Ytjh1mZrl/A2B9wds0R8NQEs0Mryuxu9+rk+Zo2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZiZ4j9LMO1n21GkAHVTENN41A/sRat6/qDvYtnPv6c1tR1FrKqkQOGmVlyJgBB4s
         uMAj25A9y+cIRhu3KsIfwpsjmDYzAmhYYjJTMhXMquqGo+fFoI/+epsRodF6aMZ3CZ
         RnAjlyiQcfKq2qfrGp67wdT7UCMCqta+ew3HBbUQ=
Date:   Thu, 2 Jan 2020 03:50:20 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: add 32 bit iommu page table support
Message-ID: <20200102085020.GA14173@onstation.org>
References: <20200101033704.32264-1-masneyb@onstation.org>
 <20200102073607.GS549437@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102073607.GS549437@yoga>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Jan 01, 2020 at 11:36:07PM -0800, Bjorn Andersson wrote:
> On Tue 31 Dec 19:37 PST 2019, Brian Masney wrote:
> 
> > Add 32 bit implmentations of the functions
> > __qcom_scm_iommu_secure_ptbl_size() and
> > __qcom_scm_iommu_secure_ptbl_init() that are required by the qcom_iommu
> > driver.
> > 
> 
> Hi Brian,
> 
> This looks good, but I was hoping to  hoping to reach a conclusion and
> merge [1] - which in patch 16 squashes the argument filling boiler plate
> code of the 32 and 64-bit version of scm and hence implements the same.
> 
> If you have time to take a peek at this series I would greatly
> appreciate it (not a lot of people testing 32-bit these days...)
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=215943

I'll look at that series this weekend and test it on arm32.

Brian
