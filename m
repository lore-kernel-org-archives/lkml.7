Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B95C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC7520843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562317474;
	bh=VQbkOn7IFuvTzmG2wEcraG9t0ivU+flYsDDf5txco0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c/W6T1p39syZ1XggLq82QUdMKVr13aVxpjP15HJKS0Qlee6JvrgkL49l1CBtCgY8P
	 97gWN+UlXHTRU0EsktuMJHNH8PJ9/5xXJ1qSmEJqMXidFMXA/0ueGOx2I+xb/Oq0R+
	 FeZq1H+PZ5pqPgC3tVienjDGUtf6iAVQdx8V1PWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGEJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfGEJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:04:33 -0400
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E51218C5;
        Fri,  5 Jul 2019 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562317472;
        bh=VQbkOn7IFuvTzmG2wEcraG9t0ivU+flYsDDf5txco0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2vgdcD1xE0NEdTC7ImGhLkeVwGZbKhLqdMC7aUXUuQfEo3J/FmSq5/zy8TWO4m6h
         l2TSf59Mjzs9RjEcClaIIp0nxtR3PGx5E6sQJTvOTh4T0pUjsSoT5fHdYuilQQYpZw
         wtyBLhlESTIZ31TlrG0p0718GYWegFB/f4MfOePE=
Date:   Fri, 5 Jul 2019 11:04:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190705090422.GA32289@kroah.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705083349.44047-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 4 deletions(-)

What changed from the previous versions?

Always put that below the --- line.

Please fix up and send a v4 with that information.

thanks,

greg k-h
