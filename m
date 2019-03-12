Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97302083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552408441;
	bh=GqdDKNpEMC7ZGX2TjZhDg/zDiWLmBZbuF+UvItYepls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pIAZG3nQNkLhaSkDGlyKYkKHeqTdyc9DsnC+jmMI0uUkI0xa8iH5AQhVJzLa2erzP
	 YYtshjQsXXGkCiG7qwZ4lBhpcIc2yq/PEVwFwub9bd/thQ9dDZgDzcRXRIUA7j8AUa
	 33z/+ZmIrK+NCFjE7fB4tK4LyKQL51aT6liHI5ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCLQd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfCLQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:33:57 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D47C2083D;
        Tue, 12 Mar 2019 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552408437;
        bh=GqdDKNpEMC7ZGX2TjZhDg/zDiWLmBZbuF+UvItYepls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6fSv8X0awczH4yFRyEhy6/8wxKi7AB0HsOEvh+Es2lNTy06RfqWkDr9lm5tn4O6B
         VPB1iY6MB8ymLNGRqZ8u2iRltl4l8Uh4HjXjX0dZyE2+6fr/2h/5pgqac4hN1A9SvF
         ryL0zO8zRLcsrHFsF+Q7X/KDXzudZvT5CCDYE3a8=
Date:   Tue, 12 Mar 2019 09:33:56 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Message-ID: <20190312163356.GB13549@kroah.com>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552402660-31730-2-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> ---
>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

No changelog or signed-off-by, sorry, please fix up the series and
resend.

thanks,

greg k-h
