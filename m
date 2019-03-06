Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8181C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853772063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfCFSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:47:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39118 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCFSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:47:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 01582144FEC08;
        Wed,  6 Mar 2019 10:47:21 -0800 (PST)
Date:   Wed, 06 Mar 2019 10:47:20 -0800 (PST)
Message-Id: <20190306.104720.1297054371201854807.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] appletalk: Add atalk.h header files to MAINTAINERS
 file
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306105249.2165038-2-arnd@arndb.de>
References: <20190306105249.2165038-1-arnd@arndb.de>
        <20190306105249.2165038-2-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 10:47:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  6 Mar 2019 11:52:37 +0100

> Add the path names here so that git-send-email can pick up the
> netdev@vger.kernel.org Cc line automatically for a patch that
> only touches the headers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
