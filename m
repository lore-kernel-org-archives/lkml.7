Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CCBC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E528D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564816303;
	bh=D50s0wbiA78nR+2fSDyPs92LMsY/aXJHUMkfLqFQ84o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=no+KTB8rvrLrtTIpy4VMdOf+aDnqDa3rQgjS0DTYOi5Mfg79i8lrqK3Gtvfzyvsx/
	 T3G0cTlgfyRYeWvzFE7Ha4ifXWY+WaaJTLCC2P7objxWQjgXaYMKesbW5Xoc9OetL9
	 BcPn/2ks08lNjHpr8508DHZIf2tEUBEbrDW0nfhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfHCHLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfHCHLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:11:41 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB4F2087C;
        Sat,  3 Aug 2019 07:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564816300;
        bh=D50s0wbiA78nR+2fSDyPs92LMsY/aXJHUMkfLqFQ84o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi7AZOxjIC1A95Dmgpb1uzgAmEX9akl3RFWbkAdKtvG9+6e72Tr74QWj+3ViffjUz
         zaxc+fn4eUXSEQKuzrOeYvOPq0TTgSjONr9RaEyV7KgpyeJhzg0J0VFTlz/Q0x/W9M
         6fUhyeiRrF628+oyCX1BccnAGvKv1WfEp5JEzhss=
Date:   Sat, 3 Aug 2019 09:11:34 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: ls1088a: Revise gpio registers to
 little-endian
Message-ID: <20190803071132.GA5797@X250>
References: <20190529083254.39581-1-chuanhua.han@nxp.com>
 <20190529083254.39581-3-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529083254.39581-3-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:32:54PM +0800, Chuanhua Han wrote:
> Since fsl-ls1088a Soc GPIO registers are used as little endian,
> the patch adds the little-endian attribute to each gpio node.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

Applied, thanks.
