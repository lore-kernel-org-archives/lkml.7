Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA2FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDC520663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfDSSvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:51:43 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33836 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDSSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:51:42 -0400
Received: by mail-io1-f70.google.com with SMTP id y13so5280376iol.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Kf/mLZwwDGuwydxNf3kA3IzwdmfZD8nAnja7XQe90tI=;
        b=OXWtZUbGUso5yFIqsKqzTOWWylu1DFU299XFYyEkm0tbM8jqmAhMDKKjxyUemFlKNa
         HEVkg6T6tsE0OqKl2kEeNqBm9XCuizlaFOOWqtzFX8hXoyUqE2ATxuuPpoNR/sbsKvNz
         isAGoYW4DoUxonO9Jzmz/zmNkYbhX5Hr0i+H+c2RK4nyNojEG4kmFVYT1I4Pe6WA9+Y0
         u+426kgYCZr1XrekeCA4XQ+Hcnlf2FYbMrXxS+IEQ5D0FudDmo5HUcL0yeIq4qiMj2fy
         OH6EidfS7GPi/U1syTHQVAFoLBs+CCUScOYVnVMTjIpwAMgGXx/6bE5ldWyIif/jOxLI
         0awA==
X-Gm-Message-State: APjAAAWA9lhXrM0w8rIWG3GweLe1HTcfvKecOfryQApDLoixkFBGcUP+
        FOQXGGNaBlTRVN8rxmzCRV1GkGpZKNIuKIr3x9svtqmvlQPA
X-Google-Smtp-Source: APXvYqyZ/yiw8ZjrSyqXqtnal0Z5JPG/DfrrxtZw0WstB/YZWaI7X1zo0cp5OhFHI5RwBx11L/nbQiqovhGbgxygdy6UrAw5E/Tg
MIME-Version: 1.0
X-Received: by 2002:a24:3556:: with SMTP id k83mr2251209ita.68.1555663921233;
 Fri, 19 Apr 2019 01:52:01 -0700 (PDT)
Date:   Fri, 19 Apr 2019 01:52:01 -0700
In-Reply-To: <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a47db0586de3ba6@google.com>
Subject: Re: WARNING in ovl_instantiate
From:   syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
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
syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com

Tested on:

commit:         59ef64de ovl: detect overlapping layers
git tree:       https://github.com/amir73il/linux.git ovl-check-overlap
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3ee46e9dfc8a383
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
