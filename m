Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfDWRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:24:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52858 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfDWRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:24:01 -0400
Received: by mail-io1-f69.google.com with SMTP id t12so8680437ioc.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VkO5Vfxw4veeWkeJxoQ/C7OfI5b7RDTFdrBLqvxB0XQ=;
        b=CeAuLyrH1oys/4U/UHal1Q2lGNDUopOLYDVn7D+jEU70I+DwgO/dS2Oyx2dbtwjtp8
         QfzaUoc+GOHETv4cxpv1n+kwfE7WR5zJepp9l+n0V8GASh79FfqrVJ7wUx747ADash/m
         jTWDDuSSib7KuzuQ2nhnKklEEn61/JuOiBRJwCofrRGcUegqaw6AJ/kVfANvSO1IRht4
         1WTnTkdZpArC3+yHYfSEHWaBxqO/ztE7RLgEiIpuSH0FFdKQgqOC2+l1rjIroOPB7C8y
         PwsowHe58GKi/ltOFwJqrhS8agn6eh8td9WkW15fYlktlwrbJnt3uZRJD+Bpf26hYYaN
         ERlg==
X-Gm-Message-State: APjAAAVeTLEDHBJ1cbrRSY03XpV3Sis796/RmDoc7blJhK9yErgZXzEn
        ei8ioVNC6Gmcx6S3/oTWWGJgL3GhkobRnkRfgaYGyMgz9dfr
X-Google-Smtp-Source: APXvYqwcG4FqIkJ2PZJZE6YG9HqGfLHkD4/caAtEYA3OSAL+nUPhgkWSA6UhReP81D1s8O+pQ8lYSaDNP2wtMA+Bokrbku+3CzlK
MIME-Version: 1.0
X-Received: by 2002:a24:9197:: with SMTP id i145mr2970973ite.117.1556040240602;
 Tue, 23 Apr 2019 10:24:00 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:24:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904231240270.1461-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc2582058735d960@google.com>
Subject: Re: general protection fault in __dev_printk
From:   syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
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
syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com

Tested on:

commit:         d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13448547200000

Note: testing is done by a robot and is best-effort only.
