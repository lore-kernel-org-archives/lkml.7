Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88557C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E3208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfDZP3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:29:15 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37610 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDZP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:29:14 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B52BB145E49C8;
        Fri, 26 Apr 2019 08:29:13 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:29:11 -0400 (EDT)
Message-Id: <20190426.112911.295562414103597921.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: socket: Fix missing break in switch
 statement
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190424153124.GA9475@embeddedor>
References: <20190424153124.GA9475@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Apr 2019 08:29:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 24 Apr 2019 10:31:24 -0500

> Add missing break statement in order to prevent the code from falling
> through to cases SIOCGSTAMP_NEW and SIOCGSTAMPNS_NEW.
> 
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
