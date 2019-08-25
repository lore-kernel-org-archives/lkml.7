Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0422C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815B22CED
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566722756;
	bh=WhC5/28ETdw1zHu/U8GXGLVf86Y7kQ1/vFDlTzHznVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5MkxnK5pkvUbc4VbJcPXQZulWa36We7U3RKIYLeq0m3x/xboXRUd8h89PnfKfnVn
	 FDuavv9V2a+o90h0pju1EkxZAUwM0xL25lXZO6oJAErfF5CUaaaagG7tiDb/N01W1i
	 CUvm2TkXMMcmgAnWie9JD80rqrfsQvEDvUHnthtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfHYIpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 04:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfHYIpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 04:45:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19DF20674;
        Sun, 25 Aug 2019 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566722754;
        bh=WhC5/28ETdw1zHu/U8GXGLVf86Y7kQ1/vFDlTzHznVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngTDXY/R4lbOrcL6Ki1KaMIXH+eIptR8DJMC4ix4ea3kQ+SHBJxRRLWNDXgyeDf/J
         SiH5HiP+nGy+mh1oWVWzbyDJH+Yo5M2xfL+lnZ7tq/urwABjn2vAEYO9+vqP0fkE4N
         CCRFuoXGH5/rkwfnZMzsdyxo5IqnMxDAUFVubFpE=
Date:   Sun, 25 Aug 2019 10:45:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-serial@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial: atmel: remove unneeded
 atmel_get_lines_status function
Message-ID: <20190825084551.GA6458@kroah.com>
References: <20190823134109.12402-1-richard.genoud@gmail.com>
 <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823143241.zixdsnwrtzhgkig7@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 04:32:41PM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 23, 2019 at 03:41:09PM +0200, Richard Genoud wrote:
> > Since commit ce59e48fdbad ("serial: mctrl_gpio: implement interrupt
> > handling"), the GPIOs interrupts are handled by mctrl_gpio_irq_handle().
> 
> Well no, since ce59e48fdbad the mctrl_gpio helper can do all that
> interrupt stuff. You want to reference
> 18dfef9c7f87b75bbb0fb66a634f7c13a45b9f8d here.

Richard, can you resend with this changed?

thanks

greg k-h
