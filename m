Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE556C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02EE20645
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfCOLot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfCOLot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:44:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D21E792CC;
        Fri, 15 Mar 2019 11:44:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F3E85D6A6;
        Fri, 15 Mar 2019 11:44:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190315074307.GA31430@light.dominikbrodowski.net>
References: <20190315074307.GA31430@light.dominikbrodowski.net>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fs_context-related oops in mainline
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3475.1552650285.1@warthog.procyon.org.uk>
Date:   Fri, 15 Mar 2019 11:44:45 +0000
Message-ID: <3476.1552650285@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 15 Mar 2019 11:44:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> [    0.839322] RIP: 0010:sysfs_init_fs_context+0x82/0xd0

Could you load your kernel into gdb and then do:

	i li *sysfs_init_fs_context+0x82

David
