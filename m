Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F5221848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfIELrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:47:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53009 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfIELrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:47:01 -0400
Received: by mail-io1-f72.google.com with SMTP id q5so2844138iof.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nuyvp9vyMVnR3ZMhOYe+0oKwj4ltt2pST6dZGPPFdDs=;
        b=rPSWWM0dElxyJVszR9CjIkp9yU5JGp9dTUP+yEo9BIMdnnLizmBMk53tIu866bpKkC
         cCoJPBKWCRVSf1yRVWXXEav306Jm6GJBxqfTpbOSeyFMp77VGRauPHb9MqConC3NDUN2
         JnuyhGmDebJtPX+k/d70OPyQa5kP4E00uMLMYnT/YtFNzHsRK5KnFVzkXA0+I98fjxYS
         uFX5vdrRX6HmyroZ8zHjmYRm7FjtvXhPD3pkB0UtzkZe1gn9lWGxnB63DITWDXqsrqAx
         gIi4U4Ck1c84KcqOQkk+VzdZ7Fk86EXgJUsZOnwTxfZsZCet4TOvsoiEQgkvxr7ZlacA
         Somw==
X-Gm-Message-State: APjAAAU4zdMS8BS/fw0Z2G579drt81YIpd0+pyfXc6VS3awI64X2j0Nb
        qkD0zSXamFBJakLoMWNI4uHas1mckXquY3GzinHUAmShp16N
X-Google-Smtp-Source: APXvYqwXx5xVREHqN2GcbqE+Tt8E1onLoKBKAcj+sRYuDGmkwww2a9nv2C6YStKt8wJGXh8WFQyP/WmdeP9MEZWuHR92/vOHwLjw
MIME-Version: 1.0
X-Received: by 2002:a5d:8599:: with SMTP id f25mr3413002ioj.265.1567684020483;
 Thu, 05 Sep 2019 04:47:00 -0700 (PDT)
Date:   Thu, 05 Sep 2019 04:47:00 -0700
In-Reply-To: <CAAeHK+y3eQ7bXvo1tiAkwLCsFkbSU5B+6hsKbdEzkSXP2_Jyzg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000293ed00591cce18a@google.com>
Subject: Re: WARNING in hso_free_net_device
From:   syzbot <syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com>
To:     alexios.zavras@intel.com, andreyknvl@google.com,
        benquike@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.payer@nebelwelt.net,
        netdev@vger.kernel.org, oneukum@suse.com, rfontana@redhat.com,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+44d53c7255bb1aea22d2@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=44d53c7255bb1aea22d2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1188fcc6600000

Note: testing is done by a robot and is best-effort only.
