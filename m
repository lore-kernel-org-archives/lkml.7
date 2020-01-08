Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A2C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5233A206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgAHV4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:56:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:56:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipJJ6-004TJ9-Rn; Wed, 08 Jan 2020 21:56:05 +0000
Date:   Wed, 8 Jan 2020 21:56:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jens Axboe <axboe@kernel.dk>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Pedro Tammela <pctammela@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] [v2] socket: fix unused-function warning
Message-ID: <20200108215604.GI8904@ZenIV.linux.org.uk>
References: <20200108214454.3950090-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108214454.3950090-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 10:44:43PM +0100, Arnd Bergmann wrote:
> When procfs is disabled, the fdinfo code causes a harmless
> warning:
> 
> net/socket.c:1000:13: error: 'sock_show_fdinfo' defined but not used [-Werror=unused-function]
>  static void sock_show_fdinfo(struct seq_file *m, struct file *f)
> 
> Move the function definition up so we can use a single #ifdef
> around it.

Looks sane...
