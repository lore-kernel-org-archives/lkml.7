Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5A120856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554210512;
	bh=kTK9LDKA6L+4LUBjBB797NsZoAPE3Qiv05ajKj6nbyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DW6NWItfAd+zDs5hl/qujwfoKEl468SNUVKIY5dQbCf12jnQA8M8YpClKMIpULv6M
	 PLeg6B4zsKgHmnL2982Ytmk2fNKhrliQ/Xqp1Vhyw8I7ZTJTJFflrAdzQC+NGliBvs
	 O1m0MK8Ovqc4uFOJEdFIMda6XuQaokBa8qDCrvWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfDBNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbfDBNIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:08:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7185620856;
        Tue,  2 Apr 2019 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554210509;
        bh=kTK9LDKA6L+4LUBjBB797NsZoAPE3Qiv05ajKj6nbyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LndGWgSgjQKezUFMubWG43O2Yv/Py4sahL4swVuudeFFPW2mWc2KqIZUZnnC6YqHH
         GDqsfazCQLJ9i1zMF+bCIJsow+qvD6ugU4Ms9wwLsoPU0OCZ9pQjBpY/Jb0ozZm1/M
         ZEq8pPxDe4ckmTpUoyKFiuhPDZ6AKBlb2gyb8WIo=
Date:   Tue, 2 Apr 2019 15:08:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     trivial@kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: kernfs: Corrected spelling mistake
Message-ID: <20190402130827.GA32338@kroah.com>
References: <20190402120059.GA24119@kroah.com>
 <20190402122706.27548-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402122706.27548-1-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:27:06PM +0200, Christina Quast wrote:
> flies => files
> 
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> ---
>  include/linux/kernfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from v1?

That always goes below the --- line.

Remember, kernel maintainers have the short term memory of a squirrel :)

thanks,

greg k-h
