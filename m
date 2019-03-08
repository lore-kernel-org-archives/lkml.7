Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A628C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344BC2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:14:02 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:42215 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:14:02 -0500
Received: by mail-it1-f199.google.com with SMTP id j127so11497042itj.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 02:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=l+7YtnjaT67xIIqLNhqolHEUP5r1rzfe5j52+IldsEPeOfJd7cSbuSegMs86DyVHC9
         gYVRGeOiYvJzb92BPoSiO99rQ329R1NWkD3qv4WFNWllX6eUg0eYeci6dQ6fsMLo+0P3
         7brnxKVThNdSesCJyBlAzqx4b1cdwy5mSSwh0ij7nYp5WbielqCYfB1MlBI/46p7HDpT
         w5wYXlomMotdAVLbt400gFZSHKzcw5nlAywScxf1utGSeGSzUC6lIHeldPlTX6QN3lLW
         cHAv0diQ84/mXGbORa1qqJMGN3ddLDygXjUyiwaUXEt4c4McMljzjFW3tcwC0gYDcwdq
         zoyA==
X-Gm-Message-State: APjAAAUlTDBXmnKocVchfgMsjFcrL0AE6BBAtd7BckPSeoty5yzAfOq+
        m51Fh7fYc9QYe3iUoZDmxgDKWfT6nPWvFg/XMMpbzXY0Sr6v
X-Google-Smtp-Source: APXvYqwqjsMmxK58TVMkOsAOgb9cbhf6YO6qQhtHaCPMeEU55XUhqwGUaqGD7EyPt2hBvbbVoQRPIbMs3HhTtgUHFdSki8/AvTOd
MIME-Version: 1.0
X-Received: by 2002:a24:334a:: with SMTP id k71mr11828810itk.14.1552040041785;
 Fri, 08 Mar 2019 02:14:01 -0800 (PST)
Date:   Fri, 08 Mar 2019 02:14:01 -0800
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e34ce0583927ba7@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
vfs: namespace: error pointer dereference in do_remount()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
