Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E5421882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573139319;
	bh=Rg+L5QcGbhilOqtTrRHcmJjwXMDVD7G6rIoeZ7YcNos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=liD70r1DINyaQCrPDchLCrBWKzg0RxBzPIVdSGcuzA8YQ28VKY+v9OCviOCx6qr0N
	 5s7XF4nvFzEM3NInNH42CkN3z+R07JNXTJKDwwP6fmzsia+UwfT3sJ0uNgptV9Vyni
	 wjL6J9zwxeUpi35NRWT4VpiqgmSjo8gWUzrmii0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbfKGPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388901AbfKGPIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:08:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09D4207FA;
        Thu,  7 Nov 2019 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139317;
        bh=Rg+L5QcGbhilOqtTrRHcmJjwXMDVD7G6rIoeZ7YcNos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPHJT2BPRUtpterdm6jMAmBN/mUxCMbR4LwutLeeE0PfHH7F55sGGAgPGuKpvpipo
         IYBYoInqAG0VDczz6t7FgwTe6Cnu4Umr0cuMNgcTCkDx8NP7C5rpeo4PJtO0x8lRUz
         WvcqsbcW4AU9Tra/dgaA0msYNSElDC+BxSVpRFS0=
Date:   Thu, 7 Nov 2019 16:08:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: gasket_ioctl: Remove unnecessary
 line-breaks in funtion signature
Message-ID: <20191107150834.GA154681@kroah.com>
References: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 06:08:21PM +0000, Valery Ivanov wrote:
> 	This patch fix the function signature for trace_gasket_ioctl_page_table_data
> 	to avoid the checkpatch.pl warning:
> 
> 		CHECK: Lines should not end with a '('

Why the huge indentation?

THat's not ok, please fix up.

thanks,

greg k-h
