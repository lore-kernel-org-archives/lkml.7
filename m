Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C1C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138621835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfLGERQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 23:17:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35912 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGERQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 23:17:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9814315363EF6;
        Fri,  6 Dec 2019 20:17:15 -0800 (PST)
Date:   Fri, 06 Dec 2019 20:17:12 -0800 (PST)
Message-Id: <20191206.201712.796721034498266453.davem@davemloft.net>
To:     vvidic@valentin-vidic.from.hr
Cc:     jakub.kicinski@netronome.com, willemdebruijn.kernel@gmail.com,
        borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/tls: Fix return values to avoid ENOTSUPP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191205064118.8299-1-vvidic@valentin-vidic.from.hr>
References: <20191204.165528.1483577978366613524.davem@davemloft.net>
        <20191205064118.8299-1-vvidic@valentin-vidic.from.hr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 06 Dec 2019 20:17:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Date: Thu,  5 Dec 2019 07:41:18 +0100

> ENOTSUPP is not available in userspace, for example:
> 
>   setsockopt failed, 524, Unknown error 524
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

Applied and queued up for -stable, thanks.
