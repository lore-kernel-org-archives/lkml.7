Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B63206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y6GQXjD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCLQf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:35:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:37810 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:35:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4952E13343C;
        Tue, 12 Mar 2019 12:35:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id MxQZgR8N07Mc; Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BE318133439;
        Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BE318133439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1552408556;
        bh=rXamu+KIfX7FDVjBVXweJ8TgYtj6TGa6TXOr9mbg6vM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Y6GQXjD00l30VeM1Ql4Zdkeqm5BEnfEbmLN0twIZAjhQ+ZvtfZYKC5KrNjSJYwZsl
         moMZkJ77YB+ULLN/g5dS6O+BYxW4Tw8fkBx2G0X1u6J3AOi6HAtgIqE8HxPaX/6JhX
         0fIhtVdgekZVmUpNKYAqU/aDZAuzpfzwUPPRXGiydFBmOanDnig9wisIVJJGRfWghX
         9kB8wWTgjEHoGAHy4klXEh1sPFMbsFQjH1mvuCS09myq+Y7HODEyPV0u6VNxf4nhVU
         0U6mQCVECxNlOQuq5Gg5/PG/ysEvh7v8jBL+xVUOQ+1D+dIhBA7sukW670wD4N5PxU
         BRRu7YpRdWQfA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id eOZRxtuYGcbA; Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A3E3D13342F;
        Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
Date:   Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc:     lwn <lwn@lwn.net>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <804725660.4775.1552408556592.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.12, 2.10.9, 2.11.0-rc4 (Linux kernel
 tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3780)
Thread-Index: x2JJH0+HxyOGlub7Z6D8d5+8AggN0g==
Thread-Topic: LTTng-modules 2.9.12, 2.10.9, 2.11.0-rc4 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LTTng-modules tracer 2.9.12, 2.10.9, 2.11.0-rc4 releases add support for Linux
kernel v4.20 and v5.0, as well as support for the RHEL 7.6 Linux kernel.

I realized that 2.11.0-rc3 was missing a RHEL 7.6 build fix, so I released
a 2.11.0-rc4 immediately after this "Doh!" moment, appropriately celebrating
Homer Simpson's birthday.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2019-03-12 (Homer Simpson Birthday) LTTng modules 2.9.12
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Fix: timer instrumentation for RHEL 7.6
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.10.9
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Fix: timer instrumentation for RHEL 7.6
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.11.0-rc4
        * Fix: timer instrumentation for RHEL 7.6

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.11.0-rc3
        * Move timekeeping blacklisting to a header file
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Add missing SPDX license identifiers to uprobes
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
