Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB14FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfLDSRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:17:05 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:47750 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbfLDSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:17:01 -0500
Received: by mail-il1-f197.google.com with SMTP id d4so363612ile.14
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 10:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4wdFb/go3+wXQG1FazkaJLX0eWR/JfQ2cs/FXkmodVM=;
        b=YNWBHMv8UNxQn4PPGriMzA8qCH8XCaegV16l2DLys9f22naRXGRN8MtiaowcVDzg4Y
         zceTk2k3GMYzJf7OgY91AJzWuYsTwSvf0d1STDOlkxKwsgD+xq8GEaZXH/fDZNqnHS5a
         vXRa78qgYcUkdyXjLynufWuNR51LuEf9ikfcL4lE6lS3qgUPmVt7sfv4Bs4EQdpKnneT
         M0L92AFC/3Xzk0l1Znvk7DOq/Yxz9ti6uyC/EHD5NCnNir5EHHPq7Fp2Ppjam7SHUc+/
         g4WTJk0CL3DoHZjWK/hH1ZRY+FPdGwo0tvModAnSkOuR/8ufhPyYxB3JmzJJu8855O84
         ekXw==
X-Gm-Message-State: APjAAAUORIx7LfqhykEmjdFFBuOFTGeiLac5Lx+qu7q/ok/gMNOQLfeh
        UwsG5bss29NQK4l1PY8NZjY/F1SLqX7Z7yHyuFDKlEJe4R3a
X-Google-Smtp-Source: APXvYqxfEJfcqqHIsUcy3WUxOi+VGXY6BPT7GEEyyyT795+CsrgW5AxgzYvjkVDBbiwQc8KpAHs0g0CC3cd5CmVN4OqVVyq0yZ6f
MIME-Version: 1.0
X-Received: by 2002:a02:40c6:: with SMTP id n189mr4320421jaa.18.1575483421189;
 Wed, 04 Dec 2019 10:17:01 -0800 (PST)
Date:   Wed, 04 Dec 2019 10:17:01 -0800
In-Reply-To: <1575471809.30318.6.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab6be80598e4d18d@google.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
From:   syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com,
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
syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com

Tested on:

commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca7a12fd736d93e0232
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1063382ee00000

Note: testing is done by a robot and is best-effort only.
