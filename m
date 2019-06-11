Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A89C0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69132183E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbfFKS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388630AbfFKS7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C78430872EC;
        Tue, 11 Jun 2019 18:59:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-114.brq.redhat.com [10.40.204.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id B9B596064B;
        Tue, 11 Jun 2019 18:59:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 11 Jun 2019 20:59:05 +0200 (CEST)
Date:   Tue, 11 Jun 2019 20:58:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de, stable@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 0/5]: Removing saved_sigmask
Message-ID: <20190611185857.GB31214@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <20190606140814.GA13440@redhat.com>
 <87k1dxaxcl.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 11 Jun 2019 18:59:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07, Eric W. Biederman wrote:
>
> Eric W. Biederman (5):
>       signal: Teach sigsuspend to use set_user_sigmask
>       signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
>       signal: Always keep real_blocked in sync with blocked
>       signal: Remove saved_sigmask
>       signal: Remove the unnecessary restore_sigmask flag

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



I guess this should be routed via -mm tree? This depends on
signal-simplify-set_user_sigmask-restore_user_sigmask.patch

Oleg.

