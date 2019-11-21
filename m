Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD842C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDF020658
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUUTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:19:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:52866 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:19:02 -0500
Received: by mail-il1-f198.google.com with SMTP id t23so3948031ila.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Y1SOgO1vbqsOUPBquz7MWoLGB9Vn/Lm+PXrguH65k6c=;
        b=ZJmM0uzoFVJzsx4JvxluJD+qHSB8Flgp2oAoxAnp7c4tJTZq90i5hn8M5bcV+Px1UH
         c0iwqQNibgTsuAYnw7kn/J5LmprN/cSlXtI6zwAFeYtaBvehlvzQLHncgS/KHdc1KOMp
         fhv5BCWxORletdOg3ck3rtF9OQiwPk5q2XMlIgpo7T6/gUXtAKO8aiq7gIOKJLsOd/ax
         vQGP0bfACWFy2jfWE1ulGhDojAx3AEzwQqJVmee4djZ4gpJtYd1Ai91Ko5tIysDi3mEw
         aEDO0hSiuUpUvv0mu3VH19JB2WobfZWa3JZ7EWMvyFUCE051Ozm019MLAhOOPe5tu99D
         wlWA==
X-Gm-Message-State: APjAAAU6FIzaJ64klml1fbPTC8Z4eyDdEwIZoiTbo/GlB9TyCZMuVbjI
        gr5J5ykVSh+pJ30SdOfO3sc0RMslHCyxcmSiUO2G4GGH36FH
X-Google-Smtp-Source: APXvYqwaEMl0Hp+7ruHPeLd8tBXlYivqUgbaT2MhzmNKW7nTuJ4raKuMZPqcGTl21/zLVSq9bhVj0KrakFYEQwXk0EWcQfBgJHfB
MIME-Version: 1.0
X-Received: by 2002:a92:c6d0:: with SMTP id v16mr12024641ilm.274.1574367541228;
 Thu, 21 Nov 2019 12:19:01 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:19:01 -0800
In-Reply-To: <201911210931.DB5346C8@keescook>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a7dfc0597e10206@google.com>
Subject: Re: general protection fault in tss_update_io_bitmap
From:   syzbot <syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, ak@linux.intel.com, bigeasy@linutronix.de,
        bp@alien8.de, fenghua.yu@intel.com, frederic@kernel.org,
        hpa@zytor.com, keescook@chromium.org, kernelfans@gmail.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, riel@surriel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, tonywwang-oc@zhaoxin.com,
        wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+81e6ff9d4cdb05fd4f5e@syzkaller.appspotmail.com

Tested on:

commit:         e3cb0c71 x86/ioperm: Fix use of deprecated config option
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=1fc51b2845bfe6fc
dashboard link: https://syzkaller.appspot.com/bug?extid=81e6ff9d4cdb05fd4f5e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
