Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96280C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89421771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK1R4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:56:01 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:33446 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1R4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:56:01 -0500
Received: by mail-io1-f71.google.com with SMTP id p19so18617760iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 09:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D3t8HLkD5KERASZ5/10L4Vedv8sGcluqQlgTqIienfY=;
        b=iMQmegB1iXxjjCsgECKE4+wshPI5etWFoFp77wU4FX5lOL3vyCCrPuriRoB88yajyA
         FaR6xg8bMtlwg4ZHxgk/zjmu3B18/LjTAj6FqnwXjI4hrRuXtSvhP5k9caqysrcRx5UY
         +7GbfKHzKmHvbY2w3LdUUaddgsMhCpe2uMRGbut9K4eWsE/iMM3IyDX0O6z17Y1/ONou
         s57gDXg/aS0JjaXBbufG4e33pfghahxm7TiKTPpAMZHdfi91gktd6WHf1R3bIhkc8RqL
         FhUAu3OG18q3kX6P/hb/wQnjPx9XJKdCL1GdA/SXkqMsaUeCH0N2GbOUuSYOiufxAxhd
         RWAw==
X-Gm-Message-State: APjAAAUO7VAdMl+ZwVC418+V2nSbYO3wQJF/7LV1NSlQ4SbcM58i0KKD
        cp0msfoh2tyAtSd4jpwSsxJ5bTD5vJxKO5StkNgYnKt9HXHU
X-Google-Smtp-Source: APXvYqwtZGLupDC8dXt0vQ4ZsGccZwV0opxixk1mT9lcdgdGXO6PJkgun8hsxChuS0l4VyECRBAJr2PvxTFlSHngLobliKs2uuUl
MIME-Version: 1.0
X-Received: by 2002:a92:7f0a:: with SMTP id a10mr2543646ild.110.1574963760424;
 Thu, 28 Nov 2019 09:56:00 -0800 (PST)
Date:   Thu, 28 Nov 2019 09:56:00 -0800
In-Reply-To: <20191128173407.GD29518@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079707305986bd3cd@google.com>
Subject: Re: WARNING: ODEBUG bug in rsi_probe
From:   syzbot <syzbot+1d1597a5aa3679c65b9f@syzkaller.appspotmail.com>
To:     amitkarwar@gmail.com, andreyknvl@google.com, davem@davemloft.net,
        johan@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        siva8118@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo https://github.com/google/kasan.git/master:  
failed to run  
["git" "fetch" "https://github.com/google/kasan.git" "master"]: exit status  
128
fatal: couldn't find remote ref master



Tested on:

commit:         [unknown
git tree:       https://github.com/google/kasan.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=1d1597a5aa3679c65b9f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152f94dae00000

