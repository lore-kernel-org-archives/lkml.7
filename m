Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC2BC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3732089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfGCAzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:55:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45368 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGCAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:55:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EDD7A1400EF15;
        Tue,  2 Jul 2019 15:25:09 -0700 (PDT)
Date:   Tue, 02 Jul 2019 15:25:09 -0700 (PDT)
Message-Id: <20190702.152509.767279980793826503.davem@davemloft.net>
To:     tranmanphong@gmail.com
Cc:     dcbw@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        glider@google.com, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lynxis@fe80.eu,
        marcel.ziswiler@toradex.com, skhan@linuxfoundation.org,
        syzbot+8a3fc6674bbc3978ed4e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yang.wei9@zte.com.cn,
        zhang.run@zte.com.cn
Subject: Re: [PATCH V2] net: usb: asix: init MAC address buffers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190702001008.26048-1-tranmanphong@gmail.com>
References: <20190630234533.15089-1-tranmanphong@gmail.com>
        <20190702001008.26048-1-tranmanphong@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Jul 2019 15:25:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>
Date: Tue,  2 Jul 2019 07:10:08 +0700

> This is for fixing bug KMSAN: uninit-value in ax88772_bind
> 
> Tested by
> https://groups.google.com/d/msg/syzkaller-bugs/aFQurGotng4/eB_HlNhhCwAJ
> 
> Reported-by: syzbot+8a3fc6674bbc3978ed4e@syzkaller.appspotmail.com
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f75e4cfe kmsan: use kmsan_handle_urb() in urb.c
> git tree:       kmsan
 ...
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Applied, thanks.
