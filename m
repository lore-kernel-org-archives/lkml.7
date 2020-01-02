Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54841C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267A2217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577963780;
	bh=VbXY3qciAWXla757PU4VUF9Vb8tPuOTZaUsueB87sq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDgYhan2c2vv2DNd2+R6aObfl6HKX5WlJAwHng1fz2sMt4bX633UJ+c1s5yNkTikS
	 3uCB7IejwN27ovU0GMIMpiGBEcUYJoY8c/uwrWfdKYXh63DWeg+ZhMwA1eS1e9aL2k
	 Cnnqn7Eu7Ty9URrVYvz6ZIO14oPfNaoAT65j6zlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgABLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgABLQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:16:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AD4217F4;
        Thu,  2 Jan 2020 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577963778;
        bh=VbXY3qciAWXla757PU4VUF9Vb8tPuOTZaUsueB87sq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxCgx9BasLnhNWy2cLieg3itEyZ78R6nd4nR8J4VlSRjOGh1MBAi6stdvsbFHJxOj
         PFD/Nr0S92r1om0zDbsrxW2kTdexdPiZUadPsrDMmWN/VasxTJP1+9HOraaUq/ywvj
         f6KX9HR/gE/ExOhqsjMkABI1ZY2AYfR9kLUb+2/Q=
Date:   Thu, 2 Jan 2020 12:16:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrita Patole <longlivelinux@yahoo.com>
Cc:     madhumithabiw@gmail.com, bhanusreemahesh@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed coding style with minor changes. Signed-off-by:
 Amrita Patole <amritapatole@gmail.com>
Message-ID: <20200102111616.GA3961630@kroah.com>
References: <20200102105718.5669-1-longlivelinux.ref@yahoo.com>
 <20200102105718.5669-1-longlivelinux@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102105718.5669-1-longlivelinux@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:27:18PM +0530, Amrita Patole wrote:
> ---
>  drivers/staging/fwserial/fwserial.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Something went wrong with your subject line :(

