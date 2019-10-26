Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFDCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A3320863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572118228;
	bh=1vWJNlJ9nmxdq2/TYTJ8H4g9od0RudmBwjhdidF/U3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j+ErPMNv3zrDVXyoseM2o7OZMpW7zkEQ3EmXGezobsbDoh6EBDl1jmwwStIXvQ/0G
	 pf5sYeqOY3SSfSIah+lj/48KeeYeqBptOsk1m74HtcLj7StGpJXiKdhD6G5GkC1lLy
	 EeyowPgFmpDDm6Ra795j5GVEtRmByin4U5APGMME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJZTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfJZTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:30:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9081D20863;
        Sat, 26 Oct 2019 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572118221;
        bh=1vWJNlJ9nmxdq2/TYTJ8H4g9od0RudmBwjhdidF/U3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hi2r2tM6TywiRAJPIiqblSIrVQlGBlYTNlHn/wq31sE5yhsBzHjW7cjrmAnMCq5AX
         amDA7DsHIXtCXm0xWGwyuIDNV/ta6Tivu3T9wVbhYe7ou371SsYBOGPq0tR7qgzHM6
         paQ0mVgIjrcv6ecZPQNeoZaEYDzKQRQIoq55wABA=
Date:   Sat, 26 Oct 2019 21:30:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20191026193018.GA812200@kroah.com>
References: <20191026192359.27687-1-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026192359.27687-1-frank-w@public-files.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 09:23:59PM +0200, Frank Wunderlich wrote:
> Date: Sat, 26 Oct 2019 20:53:28 +0200
> Subject: [PATCH] serial: 8250-mtk: Ask for IRQ-count before request one

Odd email with no subject line :(

Plaese fix up and resend.

thanks,

greg k-h-
