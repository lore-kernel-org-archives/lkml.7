Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133C0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EF620878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556223533;
	bh=E8vBqRpLwSmO3GEAn7jrqECCCGSIou55IZ0xZZZH8wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWIqopgctHN8egqM5jxH375aaG9XHefbJ1an478m+7ibrlU/rkByLHKoBTr/Sr484
	 ExMe1pK8bYS7ayT85uRuVlOc5pj04Jgrgj4IMLfM6NKXi6AewTzFllqV56cLP8gl9Z
	 VjgEWxGedfJMdM5U9Nh5r+2ZyvSPb/suP0lNzMhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfDYUSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfDYUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:18:51 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3507620717;
        Thu, 25 Apr 2019 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556223530;
        bh=E8vBqRpLwSmO3GEAn7jrqECCCGSIou55IZ0xZZZH8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W83yaG8+I1FIkrgDmz7/EQhnrrFJRRrsYiACL28OPxpe4iiaU8gk1pCE200g/UGWh
         XF9mFxrV6JaJeHcNq7AmHaqd3bPDSGP2+1ZrjWl+Aw0QSe4L1qzWCUWfJT5sW48s/I
         3o5fOc7G6R32uuPdeoH2KDk8klftvzhfMtVd4VfQ=
Date:   Thu, 25 Apr 2019 22:18:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 11/12] misc: atmel_tclib: do not probe already used TCBs
Message-ID: <20190425201848.GA14659@kroah.com>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-12-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403141120.32754-12-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:11:19PM +0200, Alexandre Belloni wrote:
> The TCBs that have children are using the new (proper) DT bindings and
> don't need to be handled by tclib.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/misc/atmel_tclib.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
