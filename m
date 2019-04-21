Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF2C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5011520821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfDUSZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:25:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDUSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:25:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 617EE146EDF87;
        Sun, 21 Apr 2019 11:25:29 -0700 (PDT)
Date:   Sun, 21 Apr 2019 11:25:29 -0700 (PDT)
Message-Id: <20190421.112529.876668648990643427.davem@davemloft.net>
To:     clabbe@baylibre.com
Cc:     corbet@lwn.net, tgraf@suug.ch,
        linux-decnet-user@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Documentation: decnet: remove reference to
 CONFIG_DECNET_ROUTE_FWMARK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555778581-21468-1-git-send-email-clabbe@baylibre.com>
References: <1555778581-21468-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Apr 2019 11:25:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Sat, 20 Apr 2019 16:43:01 +0000

> CONFIG_DECNET_ROUTE_FWMARK was removed in commit 47dcf0cb1005 ("[NET]: Rethink mark field in struct flowi")
> Since nothing replace it (and nothindg need to replace it, simply remove
> it from documentation.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.
