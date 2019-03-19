Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:48:56 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:35788 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCSNs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:48:56 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2JDmrlU021565;
        Tue, 19 Mar 2019 13:48:54 GMT
Date:   Tue, 19 Mar 2019 13:48:53 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: r8169 only works in promisc mode
Message-ID: <20190319134853.05751ead@alans-desktop>
In-Reply-To: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
References: <1552097324.u2rpi5lxaz.astroid@alex-desktop.none>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Mar 2019 21:16:20 -0500
"Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:

> After suspending, my r8169 (not actually 8169, just that driver) only 
> receives packets when in promiscuous mode. I have tried disabling all 
> offload features except highdma [fixed], and it doesn't fix the issue.

When it dies instead of trying promiscuous mode set the mac address with
ifconfig to the value it is supposed to already have and see what that
does.

Also check what address packets go out on before and after (tcpdump on
another box)

Alan
