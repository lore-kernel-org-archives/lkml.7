Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49597C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B09D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558680536;
	bh=rGu1zL2OOAibfcGGS01P8GCFm4TPZAiv4uyTHXxYtsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hLFESn1obrwywo67tnBqURKUM1FHdGLUJ05CVzvYmFfGk67yMDoJRTbxhZSSNwfTT
	 FvA/yQEyb3V6hCFt6ss+HRn/qhENymMDcAEXmAc5OILbbl15119kvBGB+4aqLRIvpI
	 jiihrYjbW54lZ9MK8JnMUEcmpGKzRDQ8HIGzHC9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfEXGsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388359AbfEXGsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:48:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E9620868;
        Fri, 24 May 2019 06:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558680533;
        bh=rGu1zL2OOAibfcGGS01P8GCFm4TPZAiv4uyTHXxYtsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0Yc6OCwovtmmEytsYn+nZpJn6AxGHpV/k1tPA6B3mmNkhBfSrV9S0U69osm9wOM+
         526Q6ced/liTKDb48Lr2fKjBm3vsdHw5JXa59oalD4BezP3tm2kdO83pW08kHKUhWH
         pI19g4HXutJkUwea2Tf2Iw4KDGZ4zW12toJvQ5CE=
Date:   Fri, 24 May 2019 08:48:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianzheng Li <ltz0302@gmail.com>
Cc:     rspringer@google.com, devel@driverdev.osuosl.org,
        zhangjie.cnde@gmail.com, linux-kernel@i4.cs.fau.de,
        linux-kernel@vger.kernel.org, toddpoynor@google.com
Subject: Re: [PATCH] staging/gasket: Fix string split
Message-ID: <20190524064851.GA3194@kroah.com>
References: <20190523154639.42662-1-ltz0302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523154639.42662-1-ltz0302@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 05:46:39PM +0200, Tianzheng Li wrote:
> This patch removes unnecessary quoted string splits.
> 
> Reported-by: Jie Zhang <zhangjie.cnde@gmail.com>
> Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
> ---
>  drivers/staging/gasket/gasket_core.c       |  6 ++----
>  drivers/staging/gasket/gasket_ioctl.c      |  3 +--
>  drivers/staging/gasket/gasket_page_table.c | 14 ++++++--------
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 

When you resend a patch, you need to version it and put underneath the
--- line what you changed in this version from the last.  The
documentation says how to do this, and there are lots of examples on the
mailing lists of how this looks.

Please do that here, and resend as a v2.

thanks,

greg k-h
