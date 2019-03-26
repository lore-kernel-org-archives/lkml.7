Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1269CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED320811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553577162;
	bh=kxvZNI2/p8l0UeDFVYbYGrOC5qSXHkD2rUy0HVuGhek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=djHbizdIVCRg89c0M/OLn7PX6BMYPuIdI7X5qBpB7ecBmn4nUxB7S535DODZso90O
	 u5pEz6+8oviKZIg4Us7fOtP+/mRwIOOkJ645xIfT0+jPWOkx3Bn+zJno7WUBOWxBla
	 Dm9ESSYURaoJ9Uz6MfaS0xYtP0XS/BhAdMO+tyb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfCZFMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfCZFMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:12:41 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C2020811;
        Tue, 26 Mar 2019 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553577160;
        bh=kxvZNI2/p8l0UeDFVYbYGrOC5qSXHkD2rUy0HVuGhek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxaoaWYj8N4ifAopQ3nM8WtytWPU9nRCu+HO0bQztFSlmidbqk0gfGtv5gpIi/zIt
         M9v0U8eES6FvR9CDxIsaQXAmoFHDmPW9GFmMdvZGZKi7/3eVh4X+BQALT20JDWLyjX
         MU0cPziSw8GRgDazBDFzyig4SMhRZohg7pwM/ZXs=
Date:   Tue, 26 Mar 2019 10:42:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: Bad file pattern in MAINTAINERS section 'QUALCOMM ETHQOS
 ETHERNET DRIVER'
Message-ID: <20190326051234.GU5348@vkoul-mobl>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212742.27394-1-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325212742.27394-1-joe@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-19, 14:27, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.

Thanks Joe for the report, sending the fix.

> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	12864	QUALCOMM ETHQOS ETHERNET DRIVER
> 	12865	M:	Vinod Koul <vkoul@kernel.org>
> 	12866	M:	Niklas Cassel <niklas.cassel@linaro.org>
> 	12867	L:	netdev@vger.kernel.org
> 	12868	S:	Maintained
> 	12869	F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> -->	12870	F:	Documentation/devicetree/bindings/net/qcom,dwmac.txt
> 
> 2: ---------------------------------------------------------------------------
> 
> The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/net/qcom,dwmac.txt':
> 
> commit 83c177aea4c37d1a2ef1e2488b25838f70cf6571
> Author: Vinod Koul <vkoul@kernel.org>
> Date:   Mon Jan 21 14:43:16 2019 +0530
> 
>     MAINTAINER: Add entry for Qualcomm ETHQOS ethernet driver
>     
>     Add myself and Niklas as maintainers for this driver
>     
>     Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 3: ---------------------------------------------------------------------------
> 
> No commit with file pattern 'Documentation/devicetree/bindings/net/qcom,dwmac.txt' was found

-- 
~Vinod
