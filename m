Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEF1C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B32067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfIQMmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:42:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57057 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfIQMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:42:01 -0400
Received: by mail-io1-f69.google.com with SMTP id n8so5458814ioh.23
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=EOWzZyfbf2PsTOR2XuGeTftz+ncATtL0MNUCtRnpmSE=;
        b=HOwbY1fv8Iytd5Pr900wCMRLgS8V5PIH3FXIKUc0XOfGKUFXSoewVBpZwWOEMsV8Ir
         g/+eEqq7Cn5/5ppXsmXis+YjLc8/XUEphTYkKr1uFvwxOL8CdSHuY1lTyz/gnlU9Tdqu
         eDJWbr63N1kCxPDsSgDVxUYriSew0qQco7AdmWcOxEyJPvd30aRpuGmFRvYqEanCmHg0
         ALyBNWPrExkNqe1NToNI84aeihIymdYv1DxLkT2fdKIaiwCyDsdu8vNDF2Qn5GURd/iW
         TOeUOx3xHk/II8/cuGvw3oHD7dF5rsKap2kC0kzCKEMpFCfJnP6b6m5jMHEezcVPJey1
         xz5w==
X-Gm-Message-State: APjAAAVIxxpff2b5BWJzeiOKsbv+3SNIXz+rSdEcLSoMttnYvD88AhZu
        bsgox3zi4rZaoD3e2pKoZYSW/lpryKmJgu7ZFB3eevnToZmy
X-Google-Smtp-Source: APXvYqzfRJsy4y4ZMCY6Mkee25knrYvCZLxgAfloFJDI8xdlPzlKgTLAQ5ybhad6fxJZizScV+KNKJwvEqz8clvlRI56Mwn4rm3U
MIME-Version: 1.0
X-Received: by 2002:a02:a617:: with SMTP id c23mr3095128jam.14.1568724121126;
 Tue, 17 Sep 2019 05:42:01 -0700 (PDT)
Date:   Tue, 17 Sep 2019 05:42:01 -0700
In-Reply-To: <20190917122404.GA29364@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fda29f0592bf0b95@google.com>
Subject: Re: possible deadlock in usb_deregister_dev (2)
From:   syzbot <syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
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
syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=f9549f5ee8a5416f0b95
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16753b2d600000

Note: testing is done by a robot and is best-effort only.
