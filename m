Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B42133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfJCT3a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:29:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbfJCT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:29:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B55AD146D1ABB;
        Thu,  3 Oct 2019 12:29:29 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:29:29 -0700 (PDT)
Message-Id: <20191003.122929.5827330149147558.davem@davemloft.net>
To:     j.neuschaefer@gmx.net
Cc:     netdev@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: networking: devlink-trap: Fix reference to other
 document
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191003190536.32463-1-j.neuschaefer@gmx.net>
References: <20191003190536.32463-1-j.neuschaefer@gmx.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 03 Oct 2019 12:29:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Thu,  3 Oct 2019 21:05:36 +0200

> This fixes the following Sphinx warning:
> 
> Documentation/networking/devlink-trap.rst:175: WARNING: unknown document: /devlink-trap-netdevsim
> 
> Fixes: 9e0874570488 ("Documentation: Add description of netdevsim traps")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Acked-by: David S. Miller <davem@davemloft.net>
