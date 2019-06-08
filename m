Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC0C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B855206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560009291;
	bh=gaBnOZ165bcaOzH+cRRG0fc68T76SxhLDkNoxdquaVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=19af9aodGFy2dWwKp4t9+Gt1LIdVTIhH9BV88vJPH8bYy5AnUcE6CGczuFqhlSGez
	 LFzyIRzdJl17mhuNrj1Y3VFT+xFtDXEf/OLbzytyp1rzW3cY05G+PNtfHdHCXZr3YX
	 rqtEGcK82TYpG0gOWYgvFqnI3kXI2XjIivdCfTqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFHPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 11:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfFHPyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 11:54:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB51B206BB;
        Sat,  8 Jun 2019 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560009289;
        bh=gaBnOZ165bcaOzH+cRRG0fc68T76SxhLDkNoxdquaVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgfgoHnu8/V5bctrfcH3eASPFogzGQSwRr5s8o02/mw/IKVURls3dx8gnKR7ck+NT
         q098IksHp/o8NT8lmCcOCHKKfHeK0SCkHWz+cGTFcyAZmWcpTHyKB8QM9GUsp1F07q
         jyLI32hpt7Hq8myc6RHRC5TnsRqWly6E9HuC5H7o=
Date:   Sat, 8 Jun 2019 17:54:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soonwoo Hong <qpseh2m7@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix coding style
Message-ID: <20190608155446.GC7974@kroah.com>
References: <20190608134728.4655-1-qpseh2m7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608134728.4655-1-qpseh2m7@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 10:47:28PM +0900, Soonwoo Hong wrote:
> Add a space before colon in ternary operator
> 
> Singed-off-by: Soonwoo Hong <qpseh2m7@gmail.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

$ ./scripts/get_maintainer.pl --file block/blk-mq.c
Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
linux-block@vger.kernel.org (open list:BLOCK LAYER)
linux-kernel@vger.kernel.org (open list)

