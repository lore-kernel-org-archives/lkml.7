Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9DCC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A5F24649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 08:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578127623;
	bh=5X3tciQat5bVeLfUv5zgi3ggJJ8ZS4+ZpZ10ftQnejs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QdHFs4dNRQBbFL4FOVcydlaLFLshdboORknijN46dDt9GO8JGjcCKldB+znLJXZTg
	 oHO6AnMCB7v71nnzJk8alrF7tmT7HUyQujTcobMG9W5lA0XPpjCFnkLCCuI6cH0o33
	 ++joCPZZh2Vu9VDnm0FFd9PxJedQLS+opwG+ZSxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgADIrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 03:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgADIq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 03:46:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A277A222C4;
        Sat,  4 Jan 2020 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578127619;
        bh=5X3tciQat5bVeLfUv5zgi3ggJJ8ZS4+ZpZ10ftQnejs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVeBZfszLtbL1SrGl0FqryXGdOc3YWzreiQVMv0fK0jvETNtyLAhukYpYQTl09C7n
         a6qGEfuOQqblLEjoFLdDSLGJkX6HRcEvzxxYIG89uqCFFUxgrOEA1MsjSBYPS/kEbP
         kZzwNNV7E34FKIrsOo9pp8UnhBtVKgEomq+MiD14=
Date:   Sat, 4 Jan 2020 09:46:55 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: Fw: usbcore missing parentheses in USE_NEW_SCHEME
Message-ID: <20200104084655.GA1248326@kroah.com>
References: <Pine.LNX.4.44L0.2001021018330.1546-100000@iolanthe.rowland.org>
 <SHQhnDsmKIpzyLJUY7lJlcdb9DLUPl8gGALB1h82ePlEPUQN9l5cHWxUWyqCcUaMRMGoq6dXRZA3e2gTvG4-HkJDxH994zTiHdeuaKJ6m-c=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHQhnDsmKIpzyLJUY7lJlcdb9DLUPl8gGALB1h82ePlEPUQN9l5cHWxUWyqCcUaMRMGoq6dXRZA3e2gTvG4-HkJDxH994zTiHdeuaKJ6m-c=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 03:24:04AM +0000, atmgnd wrote:
> Greg Kroah-Hartman:
> here is the new patch:
> 
> 
> >From 85f01b89d050a988f4d9fc78232de47e793c6a7c Mon Sep 17 00:00:00 2001
> From: Qi.Zhou <atmgnd@outlook.com>
> Date: Wed, 1 Jan 2020 21:27:13 +0800
> Subject: [PATCH] usb: hub: missing parentheses in USE_NEW_SCHEME

Please send this as a stand-alone patch, the header here should not be
in the body of the email.

Also, I doubt your name has a "." in it, right?  :)

See the many many examples of patches on the mailing list for examples
of how this all should look, as well as read
Documentation/SubmittingPatches.

thanks,

greg k-h
