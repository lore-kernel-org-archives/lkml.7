Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF38C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6892089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfG3KbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:31:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54989 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfG3KbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:31:01 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so70871970ioo.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/JDLLKCVTgj6P4LINzTI5WdAL0FV1RdWWRyqarm+YLc=;
        b=dWqmQtUrbGVHzhu58gWlmpjkjI4PpNN6DpDSmTGot8mBe9fzcGws9eeK9pwyrxxY/3
         /17PQdu+MjNXlY+9IB/MtR2K43NtudCOrPix53+cvxFqV3Cj8sEKuKC6zy5YXW9tjg8d
         S8hMSlvc4yyX4KASivEXfEem2TCDSb3cE3ZyR2JObCMMYDoOPPQw2JIEQFADCbScVA0v
         kd5uZd2g4W8wkqkUw9BjDDfBvZelpJOgu2dUPsGG2OxUUFMuG42hkVrANADiBjdWy3cS
         knky5qtjhx0VJy8z9oVs8G1EoD73Rc3Wu9xvdMIQiTxNXnSRmbCznEmQpmtvaJ/SSTKS
         dgMA==
X-Gm-Message-State: APjAAAUO7bqR14LzmQyRh3y8MRo1oYs/Gz7ma7ssdIQJxXPWAhN5+Ya+
        QfXNRI7zEhXGtk8aE8T0QQmW9gi5BTgeTMKgk0gAOH3f7NGt
X-Google-Smtp-Source: APXvYqy+U2um5Uxv6X2VsWwU+YOv0Pyg13yIK5HP9nRe3nmtx/LGqGu7XiWw03MqvAEgiJRAiP/ZZUTmTDN9J4NtbQVrkYnpWnZS
MIME-Version: 1.0
X-Received: by 2002:a02:ca19:: with SMTP id i25mr122464740jak.6.1564482660587;
 Tue, 30 Jul 2019 03:31:00 -0700 (PDT)
Date:   Tue, 30 Jul 2019 03:31:00 -0700
In-Reply-To: <1564481531.25582.22.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003de05e058ee38113@google.com>
Subject: Re: WARNING in usbtouch_open
From:   syzbot <syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mpe@ellerman.id.au, oneukum@suse.com, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+199ea16c7f26418b4365@syzkaller.appspotmail.com

Tested on:

commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347ab44600000

Note: testing is done by a robot and is best-effort only.
