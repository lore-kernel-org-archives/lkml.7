Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4667B207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y4IVm24q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKHPBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:01:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKHPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G/5u+UhCP50amHPzLKGnv0BTAm+tmQfKhJaUJerqEy0=; b=Y4IVm24qdC7mLkCpXM8IjvNr1
        2Xs+e1a893wg5n8QF6uT2S7l/x2uHVBDxIPRdSKsQOzfQmXlVn+M9tmU08fI2JXgaFdKT27JPAyy+
        CVgEZgjPptvYXa4GttTmv2C7ui4KJ+i3dFPVnDuSad7g7lCRylEb09J4DQbCa1qXAz8jUyJO+2e48
        NIxU03XaWVfTJ3Y1RPnEIqkmZuf50UyqtodEv5Ln1gcaxZfZu3distsGY4hg9j2iUeGfovDe1uQOX
        eBmtw6GZwWs4FwNixbnLNkkpYnwvKB5zNB+xZxfpo0vdbTC0ncY9ZdSMNTywL18YyPjfxNCJ29THB
        ffh0h1TMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT5ld-0002zi-HC; Fri, 08 Nov 2019 15:01:41 +0000
Date:   Fri, 8 Nov 2019 07:01:41 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Valery Ivanov <ivalery111@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, wambui.karugax@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: fix missing a blank line after
 declaration
Message-ID: <20191108150141.GG11823@bombadil.infradead.org>
References: <20191108142329.GA3192@hwsrv-485799.hostwindsdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108142329.GA3192@hwsrv-485799.hostwindsdns.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to reiterate my opinion that this checkpatch warning is
bullshit.  For large functions, sure.  For this kind of function, it's
a waste of space.

On Fri, Nov 08, 2019 at 02:23:29PM +0000, Valery Ivanov wrote:
> This patch fixes "WARNING: Missing a blank line after declarations"
> Issue found by checkpatch.pl
> 
> Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
> ---
> Changes in v2:
>   - fix huge indentation in commit message
> ---
>  drivers/staging/octeon/octeon-stubs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index d53bd801f440..ed9d44ff148b 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -1375,6 +1375,7 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
>  	int port)
>  {
>  	union cvmx_gmxx_rxx_rx_inbnd r;
> +
>  	r.u64 = 0;
>  	return r;
>  }
> -- 
> 2.17.1
> 
