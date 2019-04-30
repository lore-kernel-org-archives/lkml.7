Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A46205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556626578;
	bh=H4/4dT9BDXgmTLrM3JhAKhMqwOU404G2VfdlNa7qgMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hHw/ol46APaXoDTjWTxT9H0MCqQgiLd+6ELO62/cFHxGxTv/7fSf17wh+F7WX0k0Y
	 rAnJxB4nhi8JAhYcv7NhiRM16+pYhcdHRxz/zR16lw2+JmTiFWnqCQqlaKy8NKkbA7
	 PI3XMEjQtTx4v12tN1SnGHq0ov0Dli20xZxalhBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfD3MQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfD3MQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:16:16 -0400
Received: from linux-8ccs (p5B164EF0.dip0.t-ipconnect.de [91.22.78.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05575205ED;
        Tue, 30 Apr 2019 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556626576;
        bh=H4/4dT9BDXgmTLrM3JhAKhMqwOU404G2VfdlNa7qgMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqWiNKJ7KoJAip0wlu4QLyfLHyp7plR4731w4+lsTQnR4TTWkDySwGLqU9Xt37xkU
         ZlaBOi61KqfcBVBxvO19pFa8zNBqnDWaVOOcErmKr252MgY4rHMNpfFA9pKGNx7aoM
         AV130XZMq8j8J1ZMC64B7iz5o3nTWZqS+FGOXTk8=
Date:   Tue, 30 Apr 2019 14:16:11 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Reschedule while waiting for modules to
 finish loading
Message-ID: <20190430121611.GA29488@linux-8ccs>
References: <20190429151751.15424-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190429151751.15424-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [29/04/19 11:17 -0400]:
>Heiko, do you want a Signed-off-by or a Reported-by?  Either one works
>for me.
>
>P.
>
>----8<----
>
>On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>loading the s390_trng.ko module.
>
>Add a reschedule point to the loop that waits for modules to complete
>loading.
>
>Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>

Thanks for the fix! Applied to modules-next.

Jessica

