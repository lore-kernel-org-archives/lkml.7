Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84071C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A059218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562165268;
	bh=OaP66Y8meIjVyoMTlK4IL7zpCxYdHt7BS8CN+dX8T/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7l8qN3mba7XGvbVh3CSf0GAbLooB6sSTs+kQLRxsyIB+xTchRAYDdZJfH1a8vg0G
	 jZjiNqGAY1ovJc6fIonbx/5hUgssYo0PY2JzIJ0yDV1E3I+FRG4U6kDLFiG3+UnU0d
	 z8NzXiYjR7mK4MtHr0L2RCMbJ9Mjy/5Gu2TA8DIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGCOrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:47:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C254D21871;
        Wed,  3 Jul 2019 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562165266;
        bh=OaP66Y8meIjVyoMTlK4IL7zpCxYdHt7BS8CN+dX8T/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjPtjxGQrs+VWxS/K1tF0Yec7uh0YVNYVfQY3/bcecKX/X4qa6WgF/X6ZzQxOgWuk
         fOvsyqF2JNWWFvrAHAv2Ae0uDDhGgE9mOR6JJXlhHYLAhxWHqfR8aPYNGl4B0LusE9
         681BP1CJKciS1c97HjiBucouxJTYixfFO4s4YUAs=
Date:   Wed, 3 Jul 2019 16:47:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190703144744.GB24961@kroah.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:27:11PM +0200, Enrico Weigelt, metux IT consult wrote:
> >  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
> Can we have that renaming as a separate patch, to ease review ?
> 
> And what about introducing a config sym for the new device specific
> stuff ? These devices seem to be pretty rare - never seen them in
> embeded world, where we do need to care of kernel size.

No, that's not the way this driver works, sorry.

greg k-h
