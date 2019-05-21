Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B07B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558447807;
	bh=gzdEhfVedqKQ0FCIkuxWhCCMI89FNeLAbYZkE8ccCFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZmZwyIKX/C1HiKJmo3CDddm/nfjdgc3beG+TlgQWENJXHQaZxuZC9iA7H774eEpj6
	 4xBrqYfxCuqgoDrevOjqhpQTJ5Bbr6CuNl7l4Pr9INifSuFGtSZP27D2yMtRB263MX
	 qr0/hvn+VlKdx7CVFEu9cgxr+pAIGiMPHoXLBFBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfEUOKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfEUOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE742173C;
        Tue, 21 May 2019 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447806;
        bh=gzdEhfVedqKQ0FCIkuxWhCCMI89FNeLAbYZkE8ccCFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZU/hID3dDaMhUGiAt62g1blSGcVOUmx3jcJAuYLw1kB4wEv0vuQpTbpQd4FyDVpw
         CKvGyYJ9BdY8RETE+S+21a1zdOXkuOoeLd19Vpxfl7AUIA8SYPT3rgxtxnX94NK9ky
         Z75+exQf1N35Z6mSQybM15tz1Okx68z52QkC43Uc=
Date:   Tue, 21 May 2019 16:10:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianzheng Li <ltz0302@gmail.com>
Cc:     rspringer@google.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, benchan@chromium.org,
        toddpoynor@google.com, linux-kernel@i4.cs.fau.de,
        zhangjie.cnde@gmail.com
Subject: Re: [PATCH] staging/gasket: Fix string split
Message-ID: <20190521141003.GA24684@kroah.com>
References: <20190521135012.24887-1-ltz0302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521135012.24887-1-ltz0302@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:50:12PM +0200, Tianzheng Li wrote:
> This patch removes unnecessary quoted string splits.
> Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
> Signed-off-by: Jie Zhang <zhangjie.cnde@gmail.com>

We need a blank line before the signed-off-by line.

Care to fix this up and resend?

thanks,

greg k-h
