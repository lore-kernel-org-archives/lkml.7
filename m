Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A8EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B8A21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfISMcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:32:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45677 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfISMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:32:03 -0400
Received: by mail-io1-f69.google.com with SMTP id o11so4903633iop.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xRvATBd4vJz/ca0H8KHxwpk25gX5YP7T2VKX90zZjjY=;
        b=jMryXIbCRojtvrOVuWLRZI2riJQiikAdZ6t9vwYO4hrAFZ44v6jybDvrVKz+zCyJce
         TQOcFhE4BJdxexavWjucbFSEW+aGlmAsKLpUoAjY34oAJXWeeVX6uMpmHWVr5AJEWPk8
         hZPcu5heoaLJ0Egd8DbYOX9cSk/fbo14gsKlMGMzacOokhb2I6rPsMMuLsbwy02c0qZY
         OVl2WSmImrg0LL3vRTHSY5UT4hbWLJW+Aq8iUaj71Fwyp7DWY/b+rig/WCMQ9Wb4V+ST
         F6HEUb4/gBKxG5sOIG+hac7ycOWuz2K80+zF/zvjDzgIMNUY3b/Vfj8OUPuZ9UNZiKMA
         H9dg==
X-Gm-Message-State: APjAAAUeL8jj1Fr0fFeRqcV2tPPDZLjPtBjZxlY1Tr4ky7f1k+mb2LI+
        T6iwbr3wqtvfl4jdjXvmZQTQ0ejiwZS3/pDYBrMvW9Gqxgus
X-Google-Smtp-Source: APXvYqznsY295KYp6iVKDsqG6sE+Z6Mre4W0acF8SRnsbhhSSg0DoispESLcXcx0yTSMXL8rH7pjSRc8Sz/uxP6+Ti76M+HxxP4c
MIME-Version: 1.0
X-Received: by 2002:a6b:b8c3:: with SMTP id i186mr12174261iof.194.1568896320918;
 Thu, 19 Sep 2019 05:32:00 -0700 (PDT)
Date:   Thu, 19 Sep 2019 05:32:00 -0700
In-Reply-To: <20190919121234.30620-1-johan@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5e3c40592e723c4@google.com>
Subject: Re: KASAN: use-after-free Read in atusb_disconnect
From:   syzbot <syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, andreyknvl@google.com, davem@davemloft.net,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        stable@vger.kernel.org, stefan@datenfreihafen.org,
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
syzbot+f4509a9138a1472e7e80@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=f4509a9138a1472e7e80
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f3ebb5600000

Note: testing is done by a robot and is best-effort only.
