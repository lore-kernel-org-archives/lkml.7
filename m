Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EDCC2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D562466B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfLEAzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:55:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38358 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:55:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 777EA14F2F78D;
        Wed,  4 Dec 2019 16:55:29 -0800 (PST)
Date:   Wed, 04 Dec 2019 16:55:28 -0800 (PST)
Message-Id: <20191204.165528.1483577978366613524.davem@davemloft.net>
To:     jakub.kicinski@netronome.com
Cc:     willemdebruijn.kernel@gmail.com, vvidic@valentin-vidic.from.hr,
        borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191204150136.2f001242@cakuba.netronome.com>
References: <CA+FuTSdhtGZtTnuncpYaoOROF7L=coGawCPSLv7jzos2Q+Tb=Q@mail.gmail.com>
        <20191204.125135.750458923752225025.davem@davemloft.net>
        <20191204150136.2f001242@cakuba.netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 04 Dec 2019 16:55:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Wed, 4 Dec 2019 15:01:36 -0800

> Valentin, what's the strategy you're using for this fix? There's a
> bunch of ENOTSUPP in net/tls/tls_sw.c as well, could you convert those,
> too?

Yes I see those as well, let's get them all in one patch ok?
