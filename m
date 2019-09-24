Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79019C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F515207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409736AbfIXOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:52:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIXOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:52:44 -0400
Received: from localhost (231-157-167-83.reverse.alphalink.fr [83.167.157.231])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8436F152804B3;
        Tue, 24 Sep 2019 07:52:42 -0700 (PDT)
Date:   Tue, 24 Sep 2019 16:52:40 +0200 (CEST)
Message-Id: <20190924.165240.1617972512581218831.davem@davemloft.net>
To:     esyr@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ubraun@linux.ibm.com, kgraul@linux.ibm.com
Subject: Re: [PATCH net v2 0/3] net/smc: move some definitions to UAPI
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1568993930.git.esyr@redhat.com>
References: <cover.1568993930.git.esyr@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 24 Sep 2019 07:52:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Fri, 20 Sep 2019 17:41:47 +0200

> As of now, it's a bit difficult to use SMC protocol, as significant part
> of definitions related to it are defined in private headers and are not
> part of UAPI. The following commits move some definitions to UAPI,
> making them readily available to the user space.
> 
> Changes since v1[1]:
>  * Patch "provide fallback diagnostic codes in UAPI" is updated
>    in accordance with the updated set of diagnostic codes.
> 
> [1] https://lkml.org/lkml/2018/10/7/177

Isn't it way too late for this?

These definitions will now be duplicates for userland code that
defines the values on their own.
