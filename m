Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F702070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gwYPEonT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfCSReh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:34:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:37816 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:34:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 882E51CAAC9;
        Tue, 19 Mar 2019 13:34:35 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id rVUSaBWLRnDy; Tue, 19 Mar 2019 13:34:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0B37A1CAAC1;
        Tue, 19 Mar 2019 13:34:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0B37A1CAAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1553016875;
        bh=/8CBk1am8WoG2uZKCO58bIGV21nb86z8tzPqXUImc+4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gwYPEonTloILKq/XMRP/GbRGR7kjYjfYgJSI3n0UkLlnVYPf9PcDf8OM+S1K2+OvT
         ndh4nATV4ak2sMql6XZICRh2BKsHkaIhEoQdH3/J6g8dMEVH2brCYe7JXZbEYmIhGl
         622d7e1L25afLmxmXXbhP8RtHS9iK6rGQ8iyme/vteIzvWXBNTPfL70/bdtuMA+BOS
         lcYx0cKy6u6uj5+vpj4lSMt76tMkVwp+rRBpt1XjKduX3z+Gsa8BGQKEUzWFhiUK6s
         xFav/itfSZhoLQYRK5OQNsrQGN1pserm3IB/Rnvi/CeaZtDH56gdBMgGqrOOb5KTLZ
         g7crOm5XMOaIQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 23kUdoVHoyZ2; Tue, 19 Mar 2019 13:34:34 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CC7271CAAB6;
        Tue, 19 Mar 2019 13:34:34 -0400 (EDT)
Date:   Tue, 19 Mar 2019 13:34:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     diamon-discuss@lists.linuxfoundation.org,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com> <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3780)
Thread-Topic: LTTng-modules 2.9.11, 2.10.8, 2.11.0-rc2 (Linux kernel tracer)
Thread-Index: tgwNY09wEmX1ohnS9162MFfWx+mRHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Nov 1, 2018, at 7:33 PM, Joel Fernandes via diamon-discuss diamon-discuss@lists.linuxfoundation.org wrote:

> On Thu, Nov 1, 2018 at 3:56 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Hi,
>>
>> This is a set of bugfix releases of the LTTng modules kernel tracer.
>> It covers the three currently active lttng-modules branches: the
>> 2.9 and 2.10 stable branches, as well as the 2.11 branch in release
>> candidate cycle.
>>
>> Those releases add support for kernel 4.19.
>>
>> One important improvement is to prevent allocation of buffers larger
>> than the available memory, which can cause the OOM killer to trigger.
>> Even if the OOM killer end up having to trigger, the current OOM kill
>> target is set to the current thread while allocating buffers.
> 
> This is interesting. Me and Steve were looking at exactly this issue
> with the ftrace ring buffer a few months ago. Turns out that even
> setting the OOM kill target may not be enough to prevent all OOMs. I
> don't remember the reason why not, I'll have to dig out those threads
> but that's what the -mm folks said at the time. I did remember vaguely
> that I tested it and the kill target doesn't always get killed.. its
> possible that something *other* parallel allocation can be victimized
> AFAIR, even though the culprit is the kill target.
> 

Hi Joel,

Sorry for the late reply. Thanks for your input!

Here is a description of the solution we implemented:

"   Get an estimate of the number of available pages and return ENOMEM if
    there are not enough pages to cover the needs of the caller. Also, mark
    the calling user thread as the first target for the OOM killer in case
    the estimate of available pages was wrong.
    
    This greatly reduces the attack surface of this issue as well as reducing
    its potential impact.
    
    This approach is inspired by the one taken by the Linux kernel
    trace ring buffer[1]."

This is implemented in commit 1f0ab1eb040 "Prevent allocation of buffers if exceeding available memory"
within lttng-modules.

Are you aware of another way to achieve this that would prevent the incorrect
OOM victimization scenario you describe above ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
