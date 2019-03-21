Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B0421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfCURjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:39:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:57137 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfCURjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:39:01 -0400
Received: by mail-it1-f200.google.com with SMTP id f5so3123372ita.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tGo0dV6WNu3EHCEHE2uxAleu41eMXPmzfkzne7QhoFQ=;
        b=ggBG7+8d93MxuhUwp8Q5m45WJv/Qat5FXZmzkOW5f3Tdp2djsUXS1LTk+kVHRhaWOp
         hOvXG+mKVz1Hj1Fvtq5F++ojrVNSiO6daBPjsJmwWGqbO45OOQYsjFfnbWPPp2oDwbeA
         38APIWF5bnIT2dl+GLXHksXBtCkwP+xF9pRtKr0OTBLwUD8yvS6miLsfVc4gcv+dw5tu
         Ex/zvD+0N1tGQu59Wziwvdzfen18ndFl8M7QLTv+T7IjVlYmNH6iNG4XXRsxKJILFo+u
         Yt3gTDrcmLJss2rOziTT0CYicls8Tp97W59/a2E0jmCTAib62Ejd4SsLng4+r9kgKjTE
         EOxA==
X-Gm-Message-State: APjAAAW+VVJI8bdU3tMmKxE9GJETIs4VsMwB2qdLX+oMSyM9xQqD/UnM
        qdGSd85DBPu8k+diQVXlDUQ0lOkRHhImWgVpe4x6I+5lbb+c
X-Google-Smtp-Source: APXvYqwNkeXNW3E3iZXXRofDnTLFm0OtnLO2TFYPOUX8czlbLljLGjN+oMfOaPvNDMLv1pLOdwUyptTz/KT20JCt5YFV1GZsG7Cf
MIME-Version: 1.0
X-Received: by 2002:a24:2714:: with SMTP id g20mr3385388ita.86.1553189940880;
 Thu, 21 Mar 2019 10:39:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:39:00 -0700
In-Reply-To: <000000000000fa6a2c057e8b7064@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1e96305849e36f1@google.com>
Subject: Re: general protection fault in prepare_to_wait
From:   syzbot <syzbot+55f9d3e51d49e20b2ce5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fb90ef200000
start commit:   [unknown
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16fb90ef200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fb90ef200000
dashboard link: https://syzkaller.appspot.com/bug?extid=55f9d3e51d49e20b2ce5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109c886cc00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ed20d0c00000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
