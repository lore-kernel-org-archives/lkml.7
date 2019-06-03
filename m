Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557EE27FD8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559567083;
	bh=5o50LdHm3nR94Xxp/EevvTYgj831Yo8VmYlaVsbg47w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIm56DT1uftfNqk3U3U+PUuwHh6kb02Ls6DNcefLYds1pPw+DUuxbtnVqfoKC1Ugh
	 8TKaA15Dp5iu3mlXvrZkPwOThP/JnCwcUHE5OeNfrrZRUSPhyxaxpfxwTYmBFrf8SP
	 p7NPIsLPX+lKXjxhZFAqehQcYTayJs+jf3dZ7Ejo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfFCNEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfFCNEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:04:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B23327FCE;
        Mon,  3 Jun 2019 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559567081;
        bh=5o50LdHm3nR94Xxp/EevvTYgj831Yo8VmYlaVsbg47w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHYsLOa1+niQjcFrjsnZT8EygUoVc8Nsv4c4oqFFgYUZ2SUlcmxk2Sy1puqQfMkK0
         1Kanun8sHE3WY9gFz6g4Y5WfpgyHvipjQK2OmuCLPi7sLiKZWyr1RBrAregltfBzt8
         SblmkUHUu+NKoTX1nlF8yo2OJB9LXko+1NFDY9Jo=
Date:   Mon, 3 Jun 2019 15:04:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?M=FCller?= <muellerch-privat@web.de>
Cc:     devel@driverdev.osuosl.org, felix.trommer@hotmail.de,
        linux-kernel@i4.cs.fau.de, linux-kernel@vger.kernel.org,
        johnfwhitmore@gmail.com
Subject: Re: [PATCH 1/3] drivers/staging/rtl8192u: Reformat comments
Message-ID: <20190603130437.GA30732@kroah.com>
References: <20190603122104.2564-1-muellerch-privat@web.de>
 <20190603122104.2564-2-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603122104.2564-2-muellerch-privat@web.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:21:02PM +0200, Christian Müller wrote:
> From: Felix Trommer <felix.trommer@hotmail.de>
> 
> Replace C99-Style comments with C89-Style comments.

What does that mean?

>  		if (MaxChnlNum >= pTriple->first_channel) {
> -			/* It is not in a monotonically increasing order, so
> +			/*
> +			 * It is not in a monotonically increasing order, so
>  			 * stop processing.
>  			 */

Those are both /* */ style comments.  Where in the C99 or C89 spec does
it say anything about this type of change?

Are you sure you are not getting confused about // for a comment marker
in C99 which is not in C89?

thanks,

greg k-h
