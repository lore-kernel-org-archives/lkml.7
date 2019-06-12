Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD2C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbfFLBfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405839AbfFLBfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 102C0308218D;
        Wed, 12 Jun 2019 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87B5F6404F;
        Wed, 12 Jun 2019 01:34:31 +0000 (UTC)
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
To:     Boris Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
References: <20190430074421.7852-1-lijiang@redhat.com>
 <20190430074421.7852-3-lijiang@redhat.com> <20190515133006.GG24212@zn.tnic>
 <4707fb2d-b7d3-34e3-a488-8aa9bdca05f1@redhat.com>
 <0650D79F-2B12-4A80-A37A-F318B5C9ECBC@alien8.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <065dfaab-089b-2329-905a-e1dfbd2f3b3f@redhat.com>
Date:   Wed, 12 Jun 2019 09:34:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0650D79F-2B12-4A80-A37A-F318B5C9ECBC@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 01:35:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年05月16日 16:15, Boris Petkov 写道:
> On May 16, 2019 3:12:26 AM GMT+02:00, lijiang <lijiang@redhat.com> wrote:
>> OK, i will modify it according to your suggestion and post again.
> 
> No need - i fixed it up already. 
> 

Hi, until now, i haven't seen the upstream branch pick up this patch series,
any updates?

Thanks.
Lianbo
