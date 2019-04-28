Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D05CC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D082120881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfD1B3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfD1B3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACBBF308FC5E;
        Sun, 28 Apr 2019 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 973B01725C;
        Sun, 28 Apr 2019 01:29:05 +0000 (UTC)
Subject: Re: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted
 when SEV is active
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
References: <20190327053629.17935-1-lijiang@redhat.com>
 <20190327053629.17935-2-lijiang@redhat.com> <20190402103201.GF6826@zn.tnic>
 <c25502b9-15bc-6ca3-f0d4-c0df5498e676@redhat.com>
 <20190426130226.GE4608@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <16ca1636-5025-82a5-fe22-2b409e8e515f@redhat.com>
Date:   Sun, 28 Apr 2019 09:29:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190426130226.GE4608@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 28 Apr 2019 01:29:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年04月26日 21:02, Borislav Petkov 写道:
> On Fri, Apr 26, 2019 at 09:59:54AM +0800, lijiang wrote:
>> Hope this help. Thanks.
> 
> It does help, yes. When this explanation above is part of the commit
> message, it helps immensely!

OK, i will add them to the commit message and post again.

> 
> :-)
> 
>> So sorry for the delay, i am trying my best to explain it in detail.
> 
> I don't care about the delay as long as the commit messages properly
> explain why the change is needed.
> 
> So thanks for doing that.
> 

It's my pleasure. Thanks.

Lianbo
