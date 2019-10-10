Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C8120659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfJJRfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:35:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:60806 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJJRfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:35:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB00C5A0;
        Thu, 10 Oct 2019 17:35:12 +0000 (UTC)
Date:   Thu, 10 Oct 2019 11:35:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Quentin Perret <qperret@qperret.net>
Subject: Re: [PATCH] docs: admin-guide: fix printk_ratelimit explanation
Message-ID: <20191010113511.141902cc@lwn.net>
In-Reply-To: <20191002114610.5773-1-oleksandr@redhat.com>
References: <20191002114610.5773-1-oleksandr@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 13:46:10 +0200
Oleksandr Natalenko <oleksandr@redhat.com> wrote:

> The printk_ratelimit value accepts seconds, not jiffies (though it is
> converted into jiffies internally). Update documentation to reflect
> this.
> 
> Also, remove the statement about allowing 1 message in 5 seconds since
> bursts up to 10 messages are allowed by default.
> 
> Finally, while we are here, mention default value for
> printk_ratelimit_burst too.
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>

This seems good.  Applied, thanks.

jon
