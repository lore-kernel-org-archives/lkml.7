Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871712086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbfFKFsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbfFKFsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:48:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 449E63084021;
        Tue, 11 Jun 2019 05:48:00 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 402675DD74;
        Tue, 11 Jun 2019 05:47:57 +0000 (UTC)
Date:   Tue, 11 Jun 2019 13:47:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com
Subject: Re: [PATCH v5 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20190611054754.GD26148@MiWiFi-R3L-srv>
References: <20190524073810.24298-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524073810.24298-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 11 Jun 2019 05:48:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/24/19 at 03:38pm, Baoquan He wrote:
> 

Ping.

Can anyone help do further reviewing on this patchset? Or consider
merging since people have ack-ed?

Thanks
Baoquan

> The v4 cover letter tells the background about this adding, paste the
> link here for reference:
> http://lkml.kernel.org/r/20190509013644.1246-1-bhe@redhat.com
> 
> Changelog:
> v4->v5:
>   Tune code and log per Dave's comments, no functional change.
>   - In patch 2, change the printed erorr message; 
>   - In patch 3, add macro SZ_64T and use it in code, and remove the
>     obsolete code comment.
> v3->v4:
>   No functional change.
>   - Rewrite log of patch 1/3 tell who the newly added bits are gonna be
>     used.
>   - Rewrite log of patch 2/3 per tglx's words.
>   - Add Kirill's Acked-by.
> 
> v2->v3:
>   Change the constant to match the notation for the rest of defines as
>   Kirill suggested;
> v1->v2:
>   Correct the subject of patch 1 according to tglx's comment;
>   Add more information to cover-letter to address reviewers' concerns;
> 
> Baoquan He (3):
>   x86/boot: Add xloadflags bits for 5-level kernel checking
>   x86/kexec/64: Error out if try to jump to old 4-level kernel from
>     5-level kernel
>   x86/kdump/64: Change the upper limit of crashkernel reservation
> 
>  arch/x86/boot/header.S                | 12 +++++++++++-
>  arch/x86/include/uapi/asm/bootparam.h |  2 ++
>  arch/x86/kernel/kexec-bzimage64.c     |  5 +++++
>  arch/x86/kernel/setup.c               | 15 ++++++++++++---
>  include/linux/sizes.h                 |  1 +
>  5 files changed, 31 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.2
> 
