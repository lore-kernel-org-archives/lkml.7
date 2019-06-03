Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFEBC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C252A23A5C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="otHK+Dp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFCVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:50:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:36418 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:50:18 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4EF181E9743;
        Mon,  3 Jun 2019 17:32:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iW9oEad8S2sy; Mon,  3 Jun 2019 17:32:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1BD5D1E973F;
        Mon,  3 Jun 2019 17:32:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1BD5D1E973F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559597561;
        bh=nfyfj63ozJ3ZHO2GDnfJlIrHT8/X+g8nEVUfeEufS0E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=otHK+Dp5OVJMd0mX0rbfivDErrWmYljmuqreMoJKrsEYYo4qW388sSFRdx9KhrNX2
         DVjb4tg3AOPMQEnf1ZOJF/PqaUKOqsniOJirxx9RnVq30/djWOfioV8bdRyegqkpDu
         3RRRaTU/j/q08678zbIoYAPBUF5WIhQlKN6NqKX7cXBxd0tgUdIr8Sq6zxVWual1pr
         6klJJRNwieVYf7RMBx39HCn/fQoIKeHawu6zdN4/d2LjZytsiQUTmdhLvfvWYx7HB8
         MUgHGhaZk4ekVwWf1l57wjjdEOQdGOpBJ+Mg8BPmzVjuC6WW54VOe58xqHVPbz7d6S
         AO6qv2Qev1s5w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZN0JoOtfhMII; Mon,  3 Jun 2019 17:32:41 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id F20BF1E9735;
        Mon,  3 Jun 2019 17:32:40 -0400 (EDT)
Date:   Mon, 3 Jun 2019 17:32:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>
Message-ID: <1807476901.26032.1559597560952.JavaMail.zimbra@efficios.com>
In-Reply-To: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
References: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
Subject: Re: [lttng-dev] [RELEASE] Userspace RCU 0.11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: Userspace RCU 0.11
Thread-Index: 2Iev/flw77z+21I02ATmbGCqmUpBFOfMPHS/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 6, 2019, at 4:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> This is a 0.11 release of the Userspace RCU project.

FYI, I just released a 0.11.1 tag of Userspace RCU which does a
mandatory soname bump. Distributions wishing to package it should
grab 0.11.1. The prior release 0.11.0 changed the soname from 6.0.0 down
to 5.1.0, which was not intended. This release bumps it to 6.1.0 as
originally intended.

Changes:

2019-06-03 Userspace RCU 0.11.1
        * Fix: SONAME bump to 6.1.0
        * Fix: urcu/futex.h: users of struct timespec should include time.h

Thanks,

Mathieu


> 
> liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
> data synchronization library provides read-side access which scales
> linearly with the number of cores. It does so by allowing multiple
> copies of a given data structure to live at the same time, and by
> monitoring the data structure accesses to detect grace periods after
> which memory reclamation is possible.
> 
> liburcu-cds provides efficient data structures based on RCU and
> lock-free algorithms. Those structures include hash tables, queues,
> stacks, and doubly-linked lists.
> 
> Here is the high-level view of the changes introduced in this release:
> 
> * Allow combining many urcu flavors within the same
>  compile unit. Prefix public APIs with urcu_<flavor>_ prefix. Keep old
>  symbols as aliases for backward compatibility.
> 
> * liburcu flavors public headers are moved, including them from previous
>  headers for backward compatibility:
> 
>  urcu-bp.h -> urcu/urcu-bp.h
>  urcu-qsbr.h -> urcu/urcu-qsbr.h
>  urcu.h -> urcu/urcu-memb.h
>  urcu.h (after #define RCU_MEMBARRIER) -> urcu/urcu-memb.h
>  urcu.h (after #define RCU_MB) -> urcu/urcu-mb.h
>  urcu.h (after #define RCU_SIGNAL) -> urcu/urcu-mb.h
> 
> * The library liburcu is renamed to liburcu-memb, keeping the old
>  library name as alias for backward compatibility.
> 
> * RCU lock-free hash table debugging:
> 
>  --enable-cds-lfht-iter-debug is introduced.
> 
>  Building liburcu with --enable-cds-lfht-iter-debug and rebuilding
>  application to match the ABI change allows finding cases where the hash
>  table iterator is re-purposed to be used on a different hash table
>  while still being used to iterate on a hash table.
> 
>  This option alters the rculfhash ABI. Make sure to compile both library
>  and application with matching configuration.
> 
> * Added support for RISC-V architecture.
> 
> * Use membarrier PRIVATE_EXPEDITED when available from liburcu-bp and
>  liburcu-memb flavors.
> 
> The backward compatibility header files, library shared objects, and
> symbols will be kept for a few liburcu versions before being removed, at
> which point a major soname bump will happen.
> 
> As always, feedback is welcome!
> 
> Thanks,
> 
> Mathieu
> 
> Changelog:
> 
> 2019-05-06 Userspace RCU 0.11.0
>        * Bump library version to 6:0:1
>        * Cleanup: update code layout to fix old gcc warning
>        * Fix: typo CPPLAGS in examples Makefile
>        * Harmonize pprint macro across projects
>        * Check for TLS support after CC detection
>        * Update macros from the autotools archive
>        * tap-driver.sh: flush stdout after each test result
>        * Update dead link in lgpl-relicensing.txt
>        * Add multiflavor compat identifiers
>        * Cleanup: missing sign compare fixes
>        * Cleanup: enable signed/unsigned compare compiler warning
>        * Cleanup: compiler warning on 32-bit architectures
>        * config.h.in: rename CONFIG_RCU_MULTIFLAVOR to CONFIG_RCU_HAVE_MULTIFLAVOR
>        * rculfhash: implement iterator debugging config option
>        * Fix: examples silent rules on Solaris
>        * Add missing fall through annotations
>        * Fix: symbol aliases with TLS compat
>        * Port: no symbols aliases on MacOS
>        * Add -Wextra to CFLAGS
>        * Add silent mode to examples Makefiles
>        * doc: update examples to API changes
>        * test multiflavor single compile unit
>        * Update README following API changes
>        * Use new header locations for includes from urcu code
>        * Update call-rcu.h and defer.h comments and include guards
>        * rculfqueue.h: do not include urcu-call-rcu.h
>        * rculfhash: support use with multiple flavors per compile unit
>        * rculfhash: do not include urcu-call-rcu.h from public API
>        * Refactor liburcu to support many flavors per compile unit
>        * Fix: only wait if work queue is empty in real-time mode
>        * Fix: don't wait after completion of a work queue job batch
>        * Fix: don't wait after completion of job batch if work queue is empty
>        * Fix: workqueue: struct urcu_work vs rcu_head mixup
>        * Cleanup: workqueue: update comments referring to call-rcu
>        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
>        * test_rwlock: Add per-thread count to verbose output
>        * Add *.exe to gitignore for Cygwin
>        * Fix: pthread_rwlock initialization on Cygwin
>        * Fix: compat_futex_noasync on Cygwin
>        * wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP to override `poll'
>        * Update documentation for call_rcu before/after fork
>        * Add support for the RISC-V architecture
>        * Tests: Add tap-driver.sh for automake < 1.12
>        * Tests: Replace prove by autotools tap runner
>        * liburcu-bp: Use membarrier private expedited when available
>        * liburcu: Use membarrier private expedited when available
>        * rculfhash: improve error handling of mmap backend
>        * Fix: don't use overlapping mmap mappings on Cygwin
>        * Tests fix: errors in shell scripts
>        * Revert "Use initial-exec tls model"
>        * Use initial-exec tls model
>        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
>        * Tests fix: add missing Cygwin thread id
>        * Fix: assignment from incompatible pointer type warnings
>        * Tests fix: unused variable warnings
>        * Fix: add missing m68k headers to dist
>        * Bump version to 0.11-pre
> 
> 
> Project website: http://liburcu.org
> Git repository: git://git.liburcu.org/urcu.git
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
