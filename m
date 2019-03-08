Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48FD20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8b1f9Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCHDgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:36:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHDgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hEIOs61BtfWHOjyOIdRs5JpXBjP0ZWSuSdwwQrlCROQ=; b=K8b1f9IxhP1JdKqEi1CPkLUtb
        ey6S/k6nAovrTU/zfPj0y10ZpZjdZYX1HTUf/YbdJbheIVgsSOzGB3KLXicuklm8sy3++DrTd7gLJ
        kqo49ncD7l9WDS/bFIVdtDkLCfydTFLTf8qZHaZhTezcEVds4ULJyxtx/i9VbjKqOubZKeE6vTjey
        gkDLjENmbPoQ8TNAwFt4YyVQSmzGa4AuPtG3nkf467kPVXlH3CZqOy+4sngwLGnIPw1cMF+xLv1qB
        bDGpXuNiJHKxd/VuwiefxyTG9VjIQPUbBjUHbxzUK6EIEattMMUyaksNQGnuJVvP5M4TrotAbAXK1
        SZ1nGPu2w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h26J1-0004cn-Jw; Fri, 08 Mar 2019 03:36:20 +0000
Subject: Re: [PATCH 5/9] docs: Replace backtick with apostrophe.
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-6-tobin@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7aa62b55-00ce-7722-2f87-bcd7f95a0a5c@infradead.org>
Date:   Thu, 7 Mar 2019 19:35:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307211153.28400-6-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/19 1:11 PM, Tobin C. Harding wrote:
> Sphinx emits:
> 
> 	WARNING: Inline interpreted text or phrase reference
> 	start-string without end-string.
> 
> This is caused by a spurious backtick.
> 
> Replace backtick with apostrophe.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  include/linux/kernel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 8f0e68e250a7..59c16c763086 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -134,7 +134,7 @@
>   * Rounds @x up to next multiple of @y. If @y will always be a power
>   * of 2, consider using the faster round_up().
>   *
> - * The `const' here prevents gcc-3.3 from calling __divdi3
> + * The 'const' here prevents gcc-3.3 from calling __divdi3
>   */
>  #define roundup(x, y) (					\
>  {							\
> 

That line is being removed completely since gcc 3.3 is no longer supported.


-- 
~Randy
