Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6174B2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 15:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbfILPRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:17:03 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37974 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbfILPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:17:03 -0400
Received: by mail-io1-f72.google.com with SMTP id a8so1064325ios.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RPiyZVry3vcCdktPjsrAehjjz4bpmZ6S8izbMfh4+Qw=;
        b=IA8Dm2B/ZTBYYqO+m7OjT/EMe1V525RT2dYQ/DKdFOAlfPuolh2N0aN4J9YRrYJaqP
         MNaTOclbZljH/VdGn1zRbf8Nlnu5gUjvFvXynajmA1OwTCslvFZnk07w2urz4PXsRP80
         xaUbpfg3+UaD1nMZUDAt5V1pR15mMd0INjeUgc9F7t8Cma3wuso8bCclk5Ovjz3bhAsJ
         q0RlF0D9MMqVHXYUyWUFqFSfsIMVWmqoHJO/ruEAkE/rk4nsTK4q+aVoaOf5iujA4w1a
         5qlNiHf2Mg0rb5TbIG//STPWXz/YaugUzA6bVwtk8f+xhZkIx/9yG2VR1otb+1ZNBX3W
         gMWQ==
X-Gm-Message-State: APjAAAW+8ypkbgwlF+h/TqgoCr+r54uzs5tfJ8beUYFThiYQMOq0NKW+
        NZTFJGmrvYR1jqHV42ATj7m/RUqJWG61MtIczQwyCoceRjfY
X-Google-Smtp-Source: APXvYqzSR03YPSVhMgY8omiNzjtKp/LsOhihqJynqTinJuXFm9yeiEQpDpPKj8OnPE+PaoUQpZvFmlFn8e22sLT7FtGXZct/f2eo
MIME-Version: 1.0
X-Received: by 2002:a02:aa84:: with SMTP id u4mr23912052jai.14.1568301421376;
 Thu, 12 Sep 2019 08:17:01 -0700 (PDT)
Date:   Thu, 12 Sep 2019 08:17:01 -0700
In-Reply-To: <CAKK_rchVQCYmjPSxk9MszV9BtF8y04-j2dpjV0Jg3c+nrRNEWQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f3a3a05925ca177@google.com>
Subject: Re: memory leak in ppp_write
From:   syzbot <syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, jeliantsurux@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, paulus@samba.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+d9c8bf24e56416d7ce2c@syzkaller.appspotmail.com

Tested on:

commit:         6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6131eafb9408877
dashboard link: https://syzkaller.appspot.com/bug?extid=d9c8bf24e56416d7ce2c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12610ef1600000

Note: testing is done by a robot and is best-effort only.
