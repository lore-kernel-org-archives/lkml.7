Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04173C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBEA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uYjSH6lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436996AbfFKW6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:58:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:33770 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436989AbfFKW6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:58:10 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2624C248C17;
        Tue, 11 Jun 2019 18:58:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7MckqP27dmwG; Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 98C48248C11;
        Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 98C48248C11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560293888;
        bh=3OC5iHPCJ00JK7oieTv9lmtz3NXUtGybEMHDPwCq9eA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uYjSH6luj8MJvD8BbM2dw0whi7mQ3nbjSWwI5rXZ6ZO31o82AFe5ld1qQTvCbuHXK
         gg7cDMlDGn+SoVkMmG9ThIqkljrd0F83hjWqgKfeHtSDpAjBMiz+ypcDikBo/bw1Gh
         J/hri6EGxz9J4FpfybZ6nV+y6Y/Tb9AKH8kp6Xtv3xdrakexp7s8vaZUtwrEjf9x4z
         Gkl1wjkE7aKY7gD1Vo78Kz3Il36cCBIIp2knTB84mc7k4DYeNyuo+C5E0ac+5exWBr
         4zGpkmYhD9DlrY7U0N8hHzdt4mgIx6KLAjHxkdptzXGNgMN74GaybX0IVLk/h9zWyF
         DHYlVHFvWuskA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id zqxzE7XjuH7w; Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 8140B248C01;
        Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
Date:   Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        diamon-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1011523982.42412.1560293888405.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.13, 2.10.10, 2.11.0-rc5 (Linux kernel
 tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Index: ucjo3Un89dq+7t4oILtoFWA+3KhRtA==
Thread-Topic: LTTng-modules 2.9.13, 2.10.10, 2.11.0-rc5 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These releases to the LTTng 2.9 and 2.10 stable branches, as well
as the release candidate for the LTTng 2.11 branch, contain a
series of bugfixes, and adds support for the 5.1 and 5.2-rc Linux
kernels.

One user-impacting fix is the following:

"Fix: don't access packet header for stream_id and stream_instance_id getters"

which can cause the consumer daemon to get an erroneous value of
stream ID and stream instance ID (0) when a live timer is fired at
the beginning of the buffer lifetime. This affects users of the live
streaming mode.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.11.0-rc5
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * Introduce callstack stackwalk implementation header
        * Prepare callstack common code for stackwalk
        * Introduce callstack legacy implementation header
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.10.10
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Cleanup: bitfield.h: move to kernel style SPDX license identifiers
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.9.13
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Cleanup: bitfield.h: move to kernel style SPDX license identifiers
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
