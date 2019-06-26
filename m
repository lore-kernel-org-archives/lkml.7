Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD27C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E47E2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZJim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZJil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:38:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55AA1AEFD;
        Wed, 26 Jun 2019 09:38:40 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] x86: Add nopv parameter to disable PV extensions
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        peterz@infradead.org, srinivas.eeda@oracle.com,
        Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        xen-devel@lists.xenproject.org
References: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561377779-28036-4-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <23b5bdee-f6b8-609b-2a52-d0b8c10a8ff8@suse.com>
Date:   Wed, 26 Jun 2019 11:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561377779-28036-4-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.19 14:02, Zhenzhong Duan wrote:
> In virtualization environment, PV extensions (drivers, interrupts,
> timers, etc) are enabled in the majority of use cases which is the
> best option.
> 
> However, in some cases (kexec not fully working, benchmarking)
> we want to disable PV extensions. As such introduce the
> 'nopv' parameter that will do it.
> 
> There are guest types which just won't work without PV extensions,
> like Xen PV, Xen PVH and jailhouse. add a "ignore_nopv" member to
> struct hypervisor_x86 set to true for those guest types and call
> the detect functions only if nopv is false or ignore_nopv is true.
> 
> There is already 'xen_nopv' parameter for XEN platform but not for
> others. 'xen_nopv' can then be removed with this change.
> 
> Suggested-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
