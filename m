Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF183C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE239214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfHITqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:46:01 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:49754 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHITqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:46:01 -0400
Received: by mail-ot1-f71.google.com with SMTP id l7so71013553otj.16
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QaIRxMgZLoHZ+y2N+TmUy7bCggB90Z3nYkENvxZIHn8=;
        b=pHIa741BLk7YLvg3Eh8eOO1UIojR2+s6t9fvZecRgrl1AZqrbt+s64d+StreEj+ajh
         ceQ/YseLNjKYEWWlo/l1rGl3H8bPnVUQB+Vu503lpviKk3M/wUfklUuCMbphsSGEN3RA
         iMjauIzKylXq5F+VXwvne8t5GqHDxTNlys9UATgZ5fQGgnDBLbgKtXi8rMxxIH6eHnZN
         QokrGOwukiS35aK/pTaiBejTlo8sPn7uaju5BWW3NVud1OaJKyIfSi77OwAg0g0KrE/u
         MrLh9jgwwz5lnEkcwQY0VcKpRnyOyc0+Krj3r86k9E4B2Fu554rPLVhKU+1oQckXxYFB
         2a4Q==
X-Gm-Message-State: APjAAAU/b0Id0Ec669SHqOiroYy5qAzhQsin0QAyhThd26shtDiKQNlJ
        p9gFUd/bD72Tfw/fF9VLZr7njNL5WqGun1EYDikGDh4B5F3r
X-Google-Smtp-Source: APXvYqyDp70SxxbdCfTkLBNTtqKAlmRBVV/PIX9YPmml1idmPRr9G9uVWwRcJmVMjSyEyQvuSlFbDAZU3eIBOCSXgDKa2yenBlmz
MIME-Version: 1.0
X-Received: by 2002:a5e:9314:: with SMTP id k20mr23444780iom.235.1565379960645;
 Fri, 09 Aug 2019 12:46:00 -0700 (PDT)
Date:   Fri, 09 Aug 2019 12:46:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1908091524250.1630-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e2e84058fb46c49@google.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
From:   syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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
syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173f2d2c600000

Note: testing is done by a robot and is best-effort only.
