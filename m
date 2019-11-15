Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF42C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109AF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKOHQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:16:03 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56354 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKOHQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:16:02 -0500
Received: by mail-il1-f197.google.com with SMTP id e5so8057268ile.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 23:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=H6KZH6ReRCeo81QQ/gV0mVJ1PcfVuetQ7C4r7dOiHMc=;
        b=fwzENd+tpbE0ufA4KfCeKYT7kjDE05t06hlkQoCse4DSQdHd0Pawom/ypErqzCGQWT
         NyQOeOx5Wd9x5YgE0vt336GWBYsQIAcB26VYwTG1mjprBAI3wBDLgCY7iiPV7AZ8D5KC
         0QT3eOer8RcoFhTG4eroxCNSElAt0ajbt2zEyubVhbyeYimPk1WavD/OteBZIVdVuAlh
         MLX1HYS2BiAhpdzh/PrSFQDUIT7P8EnY6QER2loe45Ybymbc8KYoiHRruByxz4xwYjjh
         SV8N3vf7crdK31IZ3U0y7+gkxFHJqKX9Q+sxXEtor/e/rm7DPtDl3OSg3qhdAgeCY8fx
         ECKw==
X-Gm-Message-State: APjAAAVnnTS13zzYMElXgga1j/GzRoDGuPb1srSShhxi628obgf7jtcv
        U9kKt8EoJYouGoQhL5Wn9FCEdnhynsxyfAmPgW+LPdkofds2
X-Google-Smtp-Source: APXvYqxEFgRrGmZN5G1itaTNv92D1H3tBWtZLApFkC5r1LaLaePjg0oe/UMjPdYY3bktn2CSL/7Ek0Or6H4gQTrEenIjpPECTrWI
MIME-Version: 1.0
X-Received: by 2002:a92:dd8f:: with SMTP id g15mr14045121iln.145.1573802160251;
 Thu, 14 Nov 2019 23:16:00 -0800 (PST)
Date:   Thu, 14 Nov 2019 23:16:00 -0800
In-Reply-To: <1573726121.17351.3.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b56e8b05975d5e11@google.com>
Subject: Re: WARNING: ODEBUG bug in input_ff_destroy
From:   syzbot <syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
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
syzbot+b6c55daa701fc389e286@syzkaller.appspotmail.com

Tested on:

commit:         3183c037 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
dashboard link: https://syzkaller.appspot.com/bug?extid=b6c55daa701fc389e286
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c2e254e00000

Note: testing is done by a robot and is best-effort only.
