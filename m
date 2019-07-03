Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC27C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0612189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562176255;
	bh=LhdcBhsnrhraeLgizT0jLEoW9JPQnXumK31uO9etz2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u3IWkteR3DbYxf4upLjgQKJk7gcMd4Ve3T2HN38fJ08XOzZhcTzATn7hduVzqr9MT
	 nICXpm0lxa7qEVvU0TWoI27Fxe4gkCbdIJENWWqF0zWcG6UbFGa6ixCC2w4UmbTYrP
	 +3ce/0YgSLTNNKuNHxD3xzrPsFyi3DfYBH9BGXDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGCRux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGCRux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:50:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFCB21881;
        Wed,  3 Jul 2019 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176252;
        bh=LhdcBhsnrhraeLgizT0jLEoW9JPQnXumK31uO9etz2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPsSfCEuB2yof7PvwE2sRSg8fdm206cTwyGUd4Pnto3QAqzL8T7Mgk4fDOdXBOlLL
         VW0187SOa7Ukt81KdD3vDld1JyT1X9Qc9F/T2SzDLgOh2a7+OIUA7eSF96dclar4R5
         xhsiy6PPUeezDFQSJ2ACKxXVxKO3ez2LVpp29HV8=
Date:   Wed, 3 Jul 2019 19:50:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v3 3/5] DT nodes for AST2500 DMA UART driver
Message-ID: <20190703175050.GC12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-4-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561459476-14268-4-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:34PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> DT node for DMA controller(ast_uart_sdma) doesn't bind to any DMA controller driver.
> This is because Software for DMA controller is not based on DMA framework,but is dedicated
> and serves only UARTs in AST2500. ast_uart_sdma node is searched by compatible string in the 
> driver software.basic use of this node is to provide register base address of DMA controller and DMA irq number(<50>).
> IRQ of DMA controller is of crucial importance, which does RX and TX of UART data. 

Properly line-wrap your changelog.

thanks,

greg k-h
