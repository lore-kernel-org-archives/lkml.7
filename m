Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE7BC00F44
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D08121A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qtLxBwHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438610AbfJQW3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:29:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:42204 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbfJQW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:29:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9CEA8345336;
        Thu, 17 Oct 2019 18:29:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id c3erq6gp7EXj; Thu, 17 Oct 2019 18:29:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1830C345332;
        Thu, 17 Oct 2019 18:29:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1830C345332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1571351344;
        bh=BIRtIJH7Iz5ti/i1w6z9AbmJOgUNTEXaierPzXMCZmg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qtLxBwHx4NzdDQHA9I5OY16MKLiNSwkAVNksIXjStpHAu0/ou3EfyG+6DNISIYr4J
         kCFJ2LHKkH8kO1NN7sX5HpiRNGHAXpjgTIeqCLUicIX04dEnuKaH9yX8k4XmTyScLB
         PKDI+BeZWwdE8qpKuYDE799uBTReXn8A6YhZFZJBlRfBANdXbNQtrbSh9/7adKzTdd
         3zeo7DVjPioPjXM8rzIt5Z1FgxTKaykxs9CNseITU7ZPDM/vVErnsWx2ILoRNHtwDI
         OSnP1900mRKE8DuWBUoRh/xwHmFUqKNR4dutdHSE0m+JQDZLGoIQjKdxQr6iRRC5oD
         zqK4mmUXHvgFw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1O36dU-0Thc3; Thu, 17 Oct 2019 18:29:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 026C3345324;
        Thu, 17 Oct 2019 18:29:04 -0400 (EDT)
Date:   Thu, 17 Oct 2019 18:29:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org
Cc:     Jeremie Galarneau <jgalar@efficios.com>,
        linux-trace-users@vger.kernel.org, lwn@lwn.net,
        diamon-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2030873454.13028.1571351343905.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng 2.11.0 - Lafontaine (Linux kernel and user-space
 tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3869 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3869)
Thread-Index: vC98spfOsJsC5mUOmwZj50RkqprWGg==
Thread-Topic: LTTng 2.11.0 - Lafontaine (Linux kernel and user-space tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a combined release announcement for the 2.11.0 - "Lafontaine"
release of the LTTng Tools, LTTng UST, and LTTng modules projects.

This release is named after a modern Saison beer from Montr=C3=A9al's Oshla=
g
microbrewery. It is a refreshing, zesty, rice beer with hints of fruit
and spices. Some even say it makes for a great Somaek when mixed with
Chamisul Soju, not that we've tried!

Lafontaine is also a tongue-in-cheek reference to a water leak that
affected EfficiOS's offices during the development of this release.

The most notable features of this new release are:

  - Session rotation,
  - Dynamic tracing of user-space (LTTng-modules),
  - Support for arrays and bitwise binary operators in filters,
  - User and kernel space call stack capture from the LTTng-modules
    kernel tracer (LTTng-modules),
  - Improved networking performance of the relay daemon,
  - Take NUMA configuration into account for UST buffer allocation
    (LTTng-UST),
  - Support unloading of probe providers (dlclose) (LTTng-UST).

Important point: since we needed to change the layout of the
LTTng-UST shared buffers in this release, we had to bump the ABI
major version between LTTng-UST and lttng-sessiond from 7 to 8.
Therefore, if incompatible lttng-ust and lttng-sessiond attempt
to interact, lttng-ust will not perform any tracing. Make sure
you upgrade both lttng-tools and lttng-ust.

This release has been brewing for two years. Indeed, LTTng 2.10.0
was released in August 2017, a little more than two years ago.
This means we even had the chance to publish talks and material
presenting the features introduced in this release already.
[1, 2, 3, 4, 5]

Read on for a short description of each of these features.


-- Session rotation --

The biggest feature of this release is the long-awaited session
rotation support. Session rotations now allow you to rotate an
ongoing tracing session much in the same way as you would rotate
logs.

The 'lttng rotate' command rotates the current trace chunk of
the current tracing session. Once a rotation is completed, LTTng does
not manage the trace chunk archive anymore: you can read it, modify it,
move it, or remove it.

Because a rotation causes the tracing session=E2=80=99s current sub-buffers
to be flushed, trace chunk archives are never redundant, that is, they
do not overlap over time, unlike snapshots.

Once a rotation is complete, offline analyses can be performed on
the resulting trace, much like in 'normal' mode. However, the big
advantage is that this can be done without interrupting tracing, and
without being limited to tools which implement the "live" protocol.

Moreover, session rotations can be scheduled on a time or size
basis. The following commands give an idea of how this functionality
can be used:

$ lttng enable-rotation --timer 30s

A rotation schedule is set so that an automatic rotation occurs at
least every 30 seconds.

$ lttng enable-rotation --size 100M

A the rotation schedule is set so that an automatic rotation occurs
every time the total size of the flushed part of the current trace
chunk is at least 100 MiB.

Conversely, session rotation schedules can be deactivated using the
'lttng disable-rotation' command.

Finally, it is also possible to use the Notification API to notify
external tools when a rotation has been completed. This allows
arbitrary actions to be taken on a trace chunk archive when a scheduled
rotation is completed. Such actions can include compressing, analyzing,
or transferring a trace chunk, for example.


-- Dynamic tracing of user-space --

This release also marks the introduction of another feature we
have been eager to introduce for a long time: dynamic tracing.

As of this release, it is possible to dynamically instrument
function entries of applications and shared libraries, as well as
DTrace-style SDT probes.

The feature relies on the Linux kernel's uprobe facilities. As such,
the kernel tracer is needed to benefit from this functionality.

Here is an example instrumenting the libc's 'malloc' function
which will produce an event named 'libc_malloc' on every
invocation of malloc() by any application linked on libc:

$ lttng enable-event --kernel \
                     --userspace-probe /usr/lib/libc-2.28.so:malloc \
                     libc_malloc

SDT probes are tracepoints distributed in multiple libraries and
applications. This implementation supports tracing of SDT probes that
are NOT guarded by a semaphore.

The syntax to enable an SDT tracepoint userspace probe follows:

$ lttng enable-event --kernel \
                     --userspace-probe=3Dsdt:/path/to/executable:provider:p=
robe

Note that, for the time being, no payload is extracted (function
arguments or SDT probe parameters).


-- User and kernel space call stack capture from the LTTng-modules kernel t=
racer --

Two new contexts have been introduced for kernel channels:
callstack-kernel and callstack-user.

This allows the sampling of both the kernel and user space call stacks
when a kernel event occurs.

For example, it is now possible to capture both user and kernel call
stacks whenever a process issues a 'read()' system call using the
following commands:

$ lttng create my_session
$ lttng enable-event --kernel --syscall read
$ lttng add-context --kernel --type callstack-kernel \
                             --type callstack-user
$ lttng start

Note that it is not always possible for the tracer to reliably sample
the user space call stack. For instance, it is not possible to sample
the call stack of user space code compiled with -fomit-frame-pointer.
In such a case, the tracing is not affected, but the sampled user
space call stack may only contain the top-most address of the user space
call stack.


-- Support for arrays and bitwise binary operators in filters --

The filtering expression language and interpreter have been extended
to support new features:
  - Bracket and dot notations to get nested fields
  - New bitwise operators (>>, <<, &, ^, and |)

These improvements make it possible to filter on the content of
structures, arrays and sequences. The objective behind this work was
to make it easier to filter events which contain binary payloads
such as network headers.

As such, it is now possible to use filter expressions of the form:
"payload[2] & 0xff7 =3D=3D 0x240"

Also, the documentation of filter expressions has been expanded in the
lttng-enable-event(1) man page to include more examples, a table of
operator precedence and type promotion rules.


-- Improved networking performance of the relay daemon --

While not a feature per se, a substantial amount of work went into
mitigating performance degradations which were reported when a large
number of targets streaming to a given relay daemon were suddenly
experiencing connectivity issues.

In those scenarios, the relay daemon could timeout on a number of
network operations, making it unresponsive and unable to process
incoming traffic for a long moment.

In order to make it more resilient in those situations, the relay's
communication with consumer daemons (i.e. traced targets) has been
made entirely asynchronous, thus mitigating issues caused by
misbehaving consumers. This is the first of many improvements to the
relay daemon's networking code.

Links
---

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

[1] FOSDEM 2019 - Fine-grained Distributed Application Monitoring Using LTT=
ng
    https://www.efficios.com/blog/2019/03/01/fosdem19-distributed-monitorin=
g/

[2] The new dynamic user space tracing feature in LTTng
    https://lttng.org/blog/2019/10/15/new-dynamic-user-space-tracing-in-ltt=
ng/

[3] LTTng session rotation: the practical way to do continuous tracing
    https://lttng.org/blog/2019/10/15/lttng-session-rotation/

[4] Open Source Summit Europe 2018 - Fine-grained Distributed Application M=
onitoring Using LTTng
    https://osseu18.sched.com/event/FxXw/fine-grained-distributed-applicati=
on-monitoring-using-lttng-jeremie-galarneau-efficios

[5] FOSDEM 2018 - The LTTng approaches to solving complex problems
    https://www.efficios.com/blog/2018/02/03/fosdem18-lttng-approaches/

On behalf of the EfficiOS team,

Mathieu and J=C3=A9r=C3=A9mie

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
