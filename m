Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C319C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E651D208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556371804;
	bh=+g6CfnpPU8txgLacJbXkxyvrBdWI7sguoPHV5FU2LqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YEKgDLzyDNjfP9jQ/hpm9dXwrnGKN8aw35Hno4BMBVmb9d43rZ2K6FOy9aYwU2J+7
	 W6Wyv0n8nT9v7MpUUt6lnOPqmNEusV56qpw01JIxnvsVSONT69gpSdZt70kCxmUd8m
	 sj80AmITtxqYBf1edYwOlaRtxj5YzQENNSUzMw6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfD0NaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfD0NaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:30:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A25D2087F;
        Sat, 27 Apr 2019 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556371801;
        bh=+g6CfnpPU8txgLacJbXkxyvrBdWI7sguoPHV5FU2LqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaI8fF6LWNoF2RUAMfD2xTVes2lpnrqtexXdwKOQ4J/TtOnW8+q8XvOQfRyzm91E+
         CUp5y8r6QnfzxXPow71SMWCG8DUBieutEtEuss3todm9AFQ1630ulSxDqhrkSApObS
         cGJZCqr4D9r58uGvUKd8AHfM8GHMsJU4v29U0tPI=
Date:   Sat, 27 Apr 2019 15:29:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 01/41] drivers: tty: serial: dz: use dev_err() instead of
 printk()
Message-ID: <20190427132959.GA11368@kroah.com>
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556369542-13247-2-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:51:42PM +0200, Enrico Weigelt, metux IT consult wrote:
> Using dev_err() instead of printk() for more consistent output.
> (prints device name, etc).
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>

Your "From:" line does not match the signed-off-by line, so I can't take
any of these if I wanted to :(

Please fix up.

thanks,

greg k-h
