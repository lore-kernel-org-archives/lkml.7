Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91711C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9E2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfICTqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:46:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53477 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfICTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:46:01 -0400
Received: by mail-io1-f71.google.com with SMTP id l21so4218777iob.20
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kXCvpHAYN0cOVaTNuIIyT705Bu5FecEadrVziKUxy6Q=;
        b=GBoOwpfFndjOX9hMc1gBd9iuXlRiUBkBtUWGSgXE6miUZsQazvrDZ2uWtgZJEcpvTe
         RT14XSRLc8A7eHQiRJUjVuebJJ/8PL4Z73MvQAFiMvnjfeOgv0nHbonGozQGfv343qi9
         fbmtj/a393bv+Rv3Fth2ByAH38KW9gkmErFZd6zj2+0HySyVdua+IymyndOIiBmhjiJj
         /sl42EjV/ZPqS5++W4VaD+jfF8moRQage43ekDpkVS7n4EXyjcefimeJVm9QET/QyvXj
         CIhI+AQtIuz18MjxG7QNvMZaX9J4lOHpL29GMRJGVmQpsPRXyL4wrow5jjyRQu45HnZK
         4UOA==
X-Gm-Message-State: APjAAAUyhRF2kdP2YgvoHV/ehsAoi7HsO6o2JRbczToyXOR6+iRsnc8o
        t7UtvROjKQcvoCHNv1zYsW0MYh6i3xV8G/KG/I/dz4BdTV3b
X-Google-Smtp-Source: APXvYqxfj1sQQ3xKi9kgOKoFd/RTuW+Eik1p8S9uObwW6Wr/ZjuS6oTW/EALOyvbQSKtDYelMARQ70pjhIclDjrjwQY7vKbsWorC
MIME-Version: 1.0
X-Received: by 2002:a5d:80c8:: with SMTP id h8mr10417001ior.188.1567539960460;
 Tue, 03 Sep 2019 12:46:00 -0700 (PDT)
Date:   Tue, 03 Sep 2019 12:46:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909031516520.1859-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083be0c0591ab561e@google.com>
Subject: Re: general protection fault in pk_probe
From:   syzbot <syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=1088533649dafa1c9004
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139bc892600000

Note: testing is done by a robot and is best-effort only.
