Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E825C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F0121848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558713576;
	bh=4+rchS067k+etnZl+afwYNLkDhPgxJ39VqZ3BVzy4O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PDXZs3IbeCJssU/Hwkb20hyTHpLqZyKwQowx9Q1//0fH9iTV4HisgMoV4xAB2NSlb
	 70N6HPGu+DLp1za+rUuJLLVzNtEzdtxeOg8DVfNEe3+pkE8ofWMNMe45CSlOyx0uqe
	 sddUw0a58+EZncxcOAl//IqT6403mJvhsUp8cfio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390404AbfEXP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389079AbfEXP7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:59:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80D8217D7;
        Fri, 24 May 2019 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558713574;
        bh=4+rchS067k+etnZl+afwYNLkDhPgxJ39VqZ3BVzy4O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSfPGbwLqyhe/N9Idd75C4ptW6jS6o+WpY64OZ6Y6bHR3u5+LT5n+jBUcTn6GeG8X
         6iEJBw7BahotV0mjYyYdrSq3Z4hg7eGRM2uh8LfrvpM/N1JRgipYhFCc8Z12/jHYlC
         0l4KrrrjgM8cwFT1dxdxsfuxMGatCvCekuPsaBDE=
Date:   Fri, 24 May 2019 17:59:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sdasari@fb.com
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: Correct return values
Message-ID: <20190524155932.GB7516@kroah.com>
References: <20190503181336.579877-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503181336.579877-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 11:13:36AM -0700, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings and reported
> relevant messages as debug information.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

File is no longer here :(
