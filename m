Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322FC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA5D216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561594190;
	bh=ioBuFqxpeUQlfT3g2vZqjrx7gAuxCKeuHhhrm2EnJOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fnj74oUbjUXKMOi75RJE1LljYxGvGIc8CBT/AK7cTWX5QCi9tPqkFqhKzYxTmSgRT
	 yCX3AkCIau5g5bHhjYU3/iRnsxteqeQYB+q4twzXDkCmUYysPjo9jsb5BtwEIYfBvo
	 TyYFRDRWjVN2cTiKsqJDSfK8abIlUBvoh+dX0h4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfF0AJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF0AJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:09:49 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA24D216C8;
        Thu, 27 Jun 2019 00:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561594188;
        bh=ioBuFqxpeUQlfT3g2vZqjrx7gAuxCKeuHhhrm2EnJOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jubfDBaA96j06IAIky6Aq21kLrXu5B9l3kJR3hyBUAopqtRSzq4ZZxz9Pnn4jE0fG
         EqDBBx7QuP0P377511UggMSYt7GpOWV6BSYXIL/9IWiUnNWGaW1fOdQ9gUChi689u6
         TltIvgk0mP24JiXizNhIDSfX2X+dOO7DQ+L1PakU=
Date:   Thu, 27 Jun 2019 08:09:35 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: mpsc: Remove obsolete MPSC driver
Message-ID: <20190627000935.GC527@kroah.com>
References: <20190626160553.28518-1-mgreer@animalcreek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626160553.28518-1-mgreer@animalcreek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:05:53AM -0700, Mark Greer wrote:
> Support for the Marvell MV64x60 line of bridge chips that contained
> MPSC controllers has been removed and there are no other components
> that have that controller so remove its driver.
> 
> Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> ---
>  Documentation/admin-guide/devices.txt |    4 +-
>  drivers/tty/serial/Kconfig            |   14 -
>  drivers/tty/serial/Makefile           |    1 -
>  drivers/tty/serial/mpsc.c             | 2138 -------------------------
>  include/linux/mv643xx.h               |   46 -
>  include/uapi/linux/serial_core.h      |    2 +-
>  6 files changed, 3 insertions(+), 2202 deletions(-)
>  delete mode 100644 drivers/tty/serial/mpsc.c

I like patches that delete code, thanks for doing this!

greg k-h
