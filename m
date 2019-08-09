Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF035C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989E32086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436837AbfHIRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:53:01 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:40390 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfHIRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:53:01 -0400
Received: by mail-ot1-f70.google.com with SMTP id o21so2388356otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zfLUeixZ0xxyCbY54z0hYvSD6TcuS24V1c/+Vq6E3hY=;
        b=PXWLldl6pRrlf7a5x+CKF04RP8Jn8wv+ekg04GyDbP532kcxXWaJBKYyfuI5Gkv+OV
         jbRYsvG4DGcBdhCMPZBeowG9VcsH8I4WQAg6n0s9/xePwR1+3szrZDL4rq/I9cdevFub
         ftsOQaoTP01+3Zjk8YoTozKuNzz/2FM0kIJWHmPI/Ydm4KAwj6U6CBbqGzHcGC7B2D6s
         DbiqudFn2K4p14EDpmM9xYheuICWMk2i5jgKPKCel5f9FJjfLMomd5H2E2L6qy4K1/5m
         EhLo7O+x3PT9fDmKWku5faE6hJ4frImDkgcgrjsJS2MsfgVDID3oHokpvA+CWOSUyGQM
         QMhQ==
X-Gm-Message-State: APjAAAUjFu0oiRHk1J/WNxQm/2DgZ1CB47AfEpjaUPdKlUGpyA+1s2Ws
        Acr5KaUXY92+yZtvjZkm1kh/JYgL+8zEoDBPYdNJ7yZsbK/+
X-Google-Smtp-Source: APXvYqw/TXi1UjpCaVvf4WkbF4/wpHhbA67XNDTIgl03f49zVXIXcyl57HB5i3MLccYNJEphSG1rojmsMvnLyphLutfMcDYqwKX2
MIME-Version: 1.0
X-Received: by 2002:a02:1087:: with SMTP id 129mr24265518jay.131.1565373180454;
 Fri, 09 Aug 2019 10:53:00 -0700 (PDT)
Date:   Fri, 09 Aug 2019 10:53:00 -0700
In-Reply-To: <CAAeHK+wiwkC0SoGMvZgQ49dUbJE7ECpacXfPWpM4f9C84VY=zQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cb00c058fb2d840@google.com>
Subject: Re: KASAN: use-after-free Read in ld_usb_release
From:   syzbot <syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bhelgaas@google.com, greg@kroah.com,
        kirr@nexedi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux@roeck-us.net, lkundrak@v3.sk,
        logang@deltatee.com, stern@rowland.harvard.edu,
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
syzbot+30cf45ebfe0b0c4847a1@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b4c802600000

Note: testing is done by a robot and is best-effort only.
