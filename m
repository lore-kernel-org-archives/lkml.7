Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930B320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkR3urYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCGF1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:27:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfCGF1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f/8FXFE1OV6hPwHcCYhV8onI7uU0i7MJyIjwHVPXjCw=; b=QkR3urYwdkuomM3XmzPxm+ww+
        6bfA3SFN7p1PCOmDQng82vBiehcGnO6nEcYjtFunlo6NCyg6cyiNjFMfjqtwcmw0KnilnhBfgG8XD
        8ekb+1YVNMNT1Cy/NDNkVxe6kvqErdXWKkHuMzF0YJboKGuDL7ixHbE6Fj3mXT7AqzXY4iFczunVk
        efQnDWI5T3Xs3LRMw/h9/wrNF8ypiPfDSbQuY3+8nWYGdXmr0DbH+taKivCHImsBB12AqdI0kszEU
        L76Knpq8/u1Nks9/DivWRHcwY3uXMfmjCkpMAfMq0SZsIz54L5cDYcWzaLaNCciiq2QAnMebhAH/s
        YBpNh9V3g==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1lYc-00081T-NZ; Thu, 07 Mar 2019 05:27:02 +0000
Date:   Wed, 6 Mar 2019 21:27:01 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Shych <michaelsh@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the
 watchdog tree
Message-ID: <20190307052701.GC44339@wrath>
References: <20190304143735.308edd1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304143735.308edd1e@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 02:37:35PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drivers-x86 tree got a conflict in:
> 
>   include/linux/platform_data/mlxreg.h
> 
> between commit:
> 
>   9f03161a1bd8 ("platform_data/mlxreg: additions for Mellanox watchdog driver.")
> 
> from the watchdog tree and commit:
> 
>   9b28aa1d0eae ("platform_data/mlxreg: Document fixes for core platform data")
> 
> from the drivers-x86 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen.

I suspect this will be a rare occurence. That said - Vadim - could you please
ensure that all the mellanox driver changes Cc the platform driver x86 mailing
list by adding it to MAINTAINERS?

-- 
Darren Hart
VMware Open Source Technology Center
