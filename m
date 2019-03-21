Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340621874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfCURjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:39:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40111 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfCURjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:39:01 -0400
Received: by mail-io1-f71.google.com with SMTP id e72so5656850iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oijE3p+ie8YT543KYzOcM5xZnN5dvvGGpYICWPTcQEE=;
        b=FbOin/PSllPBA9/77DOmtR6UUlWk5yJStsYtGJ2DTEypf1fPdgPGbq0QhHS5Cuh1ZZ
         bQEXZQSE0dl6H5gVt8yiQvnesi9SWuPoQGEFvMpuA4Z+Vh7aEjcPz0eAnBvsclPP8TCz
         FEDe9TVOfUI/j/tmgoSpQJ1dqERQTI7VTVcr942g9PwevrBoFRsUogHo5puXlwNgv7kB
         X3O9/RpdGR9CU1k1idi65VD48k9rPvsqfLRWhbXKAAqGCnqdKSbgwWCketxbL5/zrgnP
         GdZy5qvDZigx9qRhR02Lr8H1G7DaRhHUHu/ptEv9mtwGKSm7pYHhoSfdNA4mi9aZt0JV
         NNow==
X-Gm-Message-State: APjAAAUXFCLaRSCNM/HnT/Otlsvd+4VD89XTZs9UiyHFwLcuT007K8yV
        W+C9c11U3n+JknfpTWkYmd12U+defirKO/WQFkBVw4dBU4xB
X-Google-Smtp-Source: APXvYqwsZMVVk36ny1gnguJL/MCjmXBqqrO5h9JuEXFTtR4hkrlGBY6AxixxaGP0u1CiDl+mE1lihnT5R9UbUgdDj+ei+aIMUNMw
MIME-Version: 1.0
X-Received: by 2002:a02:5541:: with SMTP id e62mr3637654jab.88.1553189940636;
 Thu, 21 Mar 2019 10:39:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:39:00 -0700
In-Reply-To: <00000000000089904d057f1e0ae0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae4e4405849e364b@google.com>
Subject: Re: general protection fault in rose_send_frame
From:   syzbot <syzbot+7078ae989d857fe17988@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e635fb200000
start commit:   [unknown
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16e635fb200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e635fb200000
dashboard link: https://syzkaller.appspot.com/bug?extid=7078ae989d857fe17988
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1688239f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1059214f200000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
