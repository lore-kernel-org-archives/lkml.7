Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E56206E4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfL3MJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:09:47 -0500
Received: from correo.us.es ([193.147.175.20]:57234 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfL3MJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:09:47 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BF5751180F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 13:09:44 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B1C27DA707
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 13:09:44 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A6389DA717; Mon, 30 Dec 2019 13:09:44 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7631BDA701;
        Mon, 30 Dec 2019 13:09:42 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Dec 2019 13:09:42 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [185.124.28.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 257EB42EE38E;
        Mon, 30 Dec 2019 13:09:42 +0100 (CET)
Date:   Mon, 30 Dec 2019 13:09:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        syzbot+d7358a458d8a81aee898@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: arp_tables: init netns pointer in
 xt_tgchk_param struct
Message-ID: <20191230120940.5woilhfosyvk4krp@salvia>
References: <00000000000057fd27059aa1dfca@google.com>
 <20191227003310.16061-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227003310.16061-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 01:33:10AM +0100, Florian Westphal wrote:
[...]
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> RIP: xt_rateest_tg_checkentry+0x11d/0xb40 net/netfilter/xt_RATEEST.c:109
> [..]
>  xt_check_target+0x283/0x690 net/netfilter/x_tables.c:1019
>  check_target net/ipv4/netfilter/arp_tables.c:399 [inline]
>  find_check_entry net/ipv4/netfilter/arp_tables.c:422 [inline]
>  translate_table+0x1005/0x1d70 net/ipv4/netfilter/arp_tables.c:572
>  do_replace net/ipv4/netfilter/arp_tables.c:977 [inline]
>  do_arpt_set_ctl+0x310/0x640 net/ipv4/netfilter/arp_tables.c:1456

Applied, thanks.
