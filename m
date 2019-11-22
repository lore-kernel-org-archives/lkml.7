Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_SHORTNER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C37C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF1D2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ez59MEtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKVJa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:30:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43104 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfKVJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:30:57 -0500
Received: from zn.tnic (p200300EC2F0E97008857C615A913C712.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:8857:c615:a913:c712])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5691D1EC0CFF;
        Fri, 22 Nov 2019 10:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574415052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g+SkIdB7L+dnoy0J2++qhaiKq/+ZrlCp9XkRj4w/250=;
        b=ez59MEtY6Y1ABT1YQKLtBFM2B9E5MYhFWIycMjwn+RiNa2MHJfYC5zJTA8GwxxSR+2kxaH
        ZHZJtMKJu+ORrs1Y2dWRZxQFPgTdzLgrfidtAT8MwgyQwx9oPdD8nJTkv+JS3d3adtZlWP
        dg6+mYdw73F6oz31Y+yWq+92Wpa+R6g=
Date:   Fri, 22 Nov 2019 10:30:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, ak@linux.intel.com, bigeasy@linutronix.de,
        fenghua.yu@intel.com, frederic@kernel.org, hpa@zytor.com,
        kernelfans@gmail.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, longman@redhat.com, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        riel@surriel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tim.c.chen@linux.intel.com,
        tonywwang-oc@zhaoxin.com, wang.yi59@zte.com.cn, x86@kernel.org
Subject: Re: general protection fault in tss_update_io_bitmap
Message-ID: <20191122093049.GF6289@zn.tnic>
References: <0000000000004dccce0597d1967b@google.com>
 <20191121110115.GC6540@zn.tnic>
 <201911210931.DB5346C8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201911210931.DB5346C8@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:36:14AM -0800, Kees Cook wrote:
> Rewording so syzbot can see it (https://goo.gl/tpsmEJ#testing-patches) ...

Thanks, /me bookmarks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
