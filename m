Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9914CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609732171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfDSTeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:34:50 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:57174 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:34:49 -0400
Received: by mail-io1-f70.google.com with SMTP id s184so5295111iod.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=s6D85SDwdxBcmwIk97r8X2C1MUYCWXHYNKcAy06X7inMZKabq7fEBZj6lx71rhGNco
         Xg9v0UTgzmhxZ5TZ+Jjwa7ClltoO7kCbSD3/6old47Gg2QKRDPYMZL8Dw7+NR7L0Migg
         zs3O49oglFECz+h+rNwgEmo8Zulx7ddKqt+qpbxIyu+uqsCiKHshhQ4gpFVgdDfgubS+
         nxbRAZgLqy2WgmZ6L0lMhgttJfN7i1PITf26OgTzp38cEdpBofmpRLSaMF64gQ7Wgr3+
         cvGPUJo8NDGuntzPWm8zBKNN53giZvEXQOihdSSf+8mGxcne52+A6oTeBhp/GdRfeNVG
         azsg==
X-Gm-Message-State: APjAAAUJ5nUmQFGOQhnmpdArWhNe0SFwADa48ycqQFUmE1UolV7ih2kr
        cmv6QogL+qFyVbuLiVUpzHSplh/KK70zuLkZG5rdQu1pglPv
X-Google-Smtp-Source: APXvYqyoMsKaygAicJ5iDCI+6XnP0mH323WeewJWAJ9dCqf55WroUO4XqEl1dRXF3AHwPUs5/LBtPQPBhyOiZYyu+U/PiqH1qF4X
MIME-Version: 1.0
X-Received: by 2002:a02:ba85:: with SMTP id g5mr1948778jao.92.1555668963225;
 Fri, 19 Apr 2019 03:16:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 03:16:03 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0f6e30586df67e3@google.com>
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
