Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F967C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02322072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dep9kfbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:52:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726524AbgAFQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578329531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05g1/1UzKsFaPL970JRtOkGOtlRptq1yeCOiOVojPRc=;
        b=Dep9kfbS31Vx3hp2lMFH2EZ2dGkmAZxM04RMZQ4/B44LTypjz4+kbGDh0YKSCOrU3O+qI1
        qFQvQ+P3CpTgQRnH4EuN5BRWQLDBQygD59IVREnLaq6Lv2aQNb/1vnc5UAj6v85O1AuT9Q
        iMfcZuhJH3nzZ57BUrGJ7ffua+R9phA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-up8nbOpUNGyz70glY3rg9w-1; Mon, 06 Jan 2020 11:52:10 -0500
X-MC-Unique: up8nbOpUNGyz70glY3rg9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B01E2F62;
        Mon,  6 Jan 2020 16:52:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2BA760F82;
        Mon,  6 Jan 2020 16:52:08 +0000 (UTC)
Subject: Re: [PATCH v2 0/6] locking/lockdep: Reuse zapped chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <dfcfc267-1a2f-8070-c08b-662e9fe4798c@redhat.com>
 <20200106165001.GO2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8a2f02c2-8e09-a898-5279-bf424acc545b@redhat.com>
Date:   Mon, 6 Jan 2020 11:52:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200106165001.GO2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/20 11:50 AM, Peter Zijlstra wrote:
> On Mon, Jan 06, 2020 at 10:54:24AM -0500, Waiman Long wrote:
>
>> Ping! Any comments or suggestion for further improvement?
> You got stuck in the xmas pile -- I haven't looked at email in 2 weeks.
> I'll try and get to it soon-ish :-)
>
Thanks!
Longman

