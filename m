Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F78C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42803207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578382116;
	bh=BVHo00NklGMrI82+E8WLgTOJ1z15QHxTgAO8Fq717sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRkJMkrtIR4kSPqS7xKWZVg7yDUwjQ+TSKwLOsec7UwH4Q61N0XrqAo7ZRpzVbWG6
	 0bRsklw6qMV/vCdPiUAqt0pOLSGv39BRlfLsy1YL5p4oTDA8WGxihqsft+v0gZtI7H
	 Ap7W530AkaNGaEaFyiTuITxhMZtakUoACjPOWWqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgAGH2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgAGH2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:28:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9892075A;
        Tue,  7 Jan 2020 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578382114;
        bh=BVHo00NklGMrI82+E8WLgTOJ1z15QHxTgAO8Fq717sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrxKsb6LMgTMxCisihf0knznX31hWsxuWd0MVXC5grjJoJUSqRDGAgHh7ooQTMJYH
         KBobJ1+QA81K2CWQz8KHY3FUPaUM8owjIIUF19hEmp/PMzzxi4KRdsG35RZ8+UGsZm
         sDz+iosUV/Amkv7OgASYfuvhsQeDHSX6cKC4hA34=
Date:   Tue, 7 Jan 2020 08:28:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Sistik <sistik@3ksolutions.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
Message-ID: <20200107072831.GB1014453@kroah.com>
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106235203.27256-1-sistik@3ksolutions.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:52:03AM +0100, Ivan Sistik wrote:
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -14,6 +14,9 @@
>   * not have an RI input, nor do they have DTR or RTS outputs.  If
>   * required, these have to be supplied via some other means (eg, GPIO)
>   * and hooked into this driver.
> + *
> + * Added software RS485 support, 05/jan/2020, Ivan Sistik
> + *     sistik@3ksolutions.sk

No need for this, that is what git changelogs are for :)

thanks,

greg k-h
