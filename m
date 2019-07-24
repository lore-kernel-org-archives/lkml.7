Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60933C76190
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC42238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGXBkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:40:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39648 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGXBkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:40:01 -0400
Received: by mail-io1-f72.google.com with SMTP id y13so49255662iol.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 18:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w92/D4APly1S0dijjuo/84NrUKS2JIroIh/+k83Y0Yg=;
        b=QJ79uSzKvXFQWTi+06Yhd8UkFwdTxrYGYk3nIwNEvmyAjSEhjMK5SDd3ooR/4NbHl+
         HTalaEt8itfLb+2FbIDDkxJlAp8d5QgbLtP87koWkRW0S2onF8LndBVs7UuX9vSrvM10
         F+2Kj1UboLAMWSjdjT+y8FiBKAh9O+O4yXyROjjrAJBlYAu7wKsmXWFUpWFYKjCwyCED
         GIBb1vmMchRrVf3KGVzhVDTei1lpBxcCDLXWXPHAkh4xtOQM51IcggOeF+mMPDDmIASR
         9Wc+NRY3BvdQQ6ruP8IlP9gSVX2bJEfBS7K0za6uOfEAGCxXoCsQJLuYadqlHZNt/5G8
         RDIA==
X-Gm-Message-State: APjAAAVnEUmFdWUZaMi3AJ4H6l0ieDxeDV/LnGbRZxoVhoLBKjm5JEf9
        b173x/xE9XJ8gMc9PH/JbpuaNuhEPCpzJHm6bhFAQysAlM2N
X-Google-Smtp-Source: APXvYqxZV7f2M7mWAmPB7Zk6w2/BTeh9n6/BKLJgP5HdF+ftj8Txa1VpP1wlpVLNOViX/+n9pFrEH7CBKE5ifAlRW9n+RxMquc0l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:691:: with SMTP id i17mr82704018jab.70.1563932401090;
 Tue, 23 Jul 2019 18:40:01 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:40:01 -0700
In-Reply-To: <5d3744ff777cc_436d2adb6bf105c41c@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000384ae4058e636360@google.com>
Subject: Re: kernel panic: stack is corrupted in pointer
From:   syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>
To:     airlied@linux.ie, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org,
        christian.koenig@amd.com, daniel@iogearbox.net,
        david1.zhou@amd.com, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, john.fastabend@gmail.com, leo.liu@amd.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com

Tested on:

commit:         decb705e libbpf: fix using uninitialized ioctl results
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=87305c3ca9c25c70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
