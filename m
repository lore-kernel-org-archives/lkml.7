Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3345C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB212087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfECPJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:09:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbfECPJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:09:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 34B2E30EF95;
        Fri,  3 May 2019 15:09:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1412278930;
        Fri,  3 May 2019 15:09:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 May 2019 17:09:50 +0200 (CEST)
Date:   Fri, 3 May 2019 17:09:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.28a 85/85] htmldocs: kernel/rcu/sync.c:74:
 warning: Function parameter or member 'rcu' not described in 'rcu_sync_func'
Message-ID: <20190503150948.GB20802@redhat.com>
References: <201905031452.Nu9N5LwE%lkp@intel.com>
 <20190503141543.GY3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503141543.GY3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 03 May 2019 15:09:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03, Paul E. McKenney wrote:
>
> > >> kernel/rcu/sync.c:74: warning: Function parameter or member 'rcu' not described in 'rcu_sync_func'
> >    kernel/rcu/sync.c:74: warning: Excess function parameter 'rhp' description in 'rcu_sync_func'
>
> Good catch!  I will be folding in the diff shown below.

I was almost ready to send the s/rhp/rcu/ oneliner, but after a thorough
review I came to conclusion your fix _might_ work too. Assuming it passes
rcutorture tests - no objection from me.

Oleg.

