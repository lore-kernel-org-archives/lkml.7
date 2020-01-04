Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0DEC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A621D7D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 02:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="nvcVHR4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgADCYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 21:24:32 -0500
Received: from onstation.org ([52.200.56.107]:34482 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgADCYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 21:24:31 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D70EC3E9DC;
        Sat,  4 Jan 2020 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1578104670;
        bh=vUL65dK+rI23ua4USwkr3fCkFuBR+pAumYuI8D0+iOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvcVHR4E8udj0m3pL3qVOL1fR70zZ7OD7OFDmD2pT+JSxoSSlcbNoOJ7VO7aHBrYH
         gGZTnem6ao1/OexDmoKMQQFkWE43dRqZQTGBWT2JPdNDGvHhTm0lRqLZZc3vVbVNHQ
         ne5kUhNtVkr9elrX2ai/8gD8GDqJMTPNOgK9si4w=
Date:   Fri, 3 Jan 2020 21:24:30 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: add 32 bit iommu page table support
Message-ID: <20200104022430.GC30866@onstation.org>
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

I agree to drop what I proposed here and go with that series instead.
It's a big improvement over what's upstream now. I left a Tested-by on
that cover letter.

Brian
