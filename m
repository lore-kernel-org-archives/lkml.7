Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EE9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2A520815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfJHNdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbfJHNdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:33:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522E320673;
        Tue,  8 Oct 2019 13:33:41 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008093339.7092313b@gandalf.local.home>
In-Reply-To: <1570541032.5576.297.camel@lca.pw>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
        <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
        <1570460350.5576.290.camel@lca.pw>
        <20191007151237.GP2381@dhcp22.suse.cz>
        <1570462407.5576.292.camel@lca.pw>
        <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
        <20191008091349.6195830d@gandalf.local.home>
        <1570541032.5576.297.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019 09:23:52 -0400
Qian Cai <cai@lca.pw> wrote:

> I feel like that is what I trying to do, but there seems a lot of resistances
> with that approach where pragmatism met with perfectionism.

It's the way it came across. It sounded as if you were proposing
"the solution". I'm coming out and explicitly saying that this may be a
"temporary solution", as having "printk_deferred()" we can easily
remove them when that becomes the default operation.

-- Steve

