Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109F2C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16C72084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfFSGtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:49:19 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56527 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:49:19 -0400
X-Originating-IP: 90.88.23.150
Received: from bootlin.com (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 08665240017;
        Wed, 19 Jun 2019 06:49:12 +0000 (UTC)
Date:   Wed, 19 Jun 2019 08:49:21 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] net: mvpp2: cls: Add pmap to fs dump
Message-ID: <20190619084921.7e1310e0@bootlin.com>
In-Reply-To: <20190618160910.62922-1-nhuck@google.com>
References: <20190618083900.78eb88bd@bootlin.com>
        <20190618160910.62922-1-nhuck@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On Tue, 18 Jun 2019 09:09:10 -0700
Nathan Huckleberry <nhuck@google.com> wrote:

>There was an unused variable 'mvpp2_dbgfs_prs_pmap_fops'
>Added a usage consistent with other fops to dump pmap
>to userspace.

Thanks for sending a fix. Besides the typo preventing your patch from
compiling, you should also prefix the patch by "net: mvpp2: debugfs:"
rather than "cls", which is used for classifier patches.

Thanks,

Maxime
