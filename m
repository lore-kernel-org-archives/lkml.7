Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9AA222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfKSORb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:17:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfKSORZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:17:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C812B34F;
        Tue, 19 Nov 2019 14:17:23 +0000 (UTC)
Message-ID: <1574173039.28617.13.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in wdm_int_callback
From:   Oliver Neukum <oneukum@suse.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        syzbot <syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com>
Cc:     baijiaju1990@gmail.com, bigeasy@linutronix.de,
        Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Date:   Tue, 19 Nov 2019 15:17:19 +0100
In-Reply-To: <CAAeHK+zV2TXWtdmLj8Fjpfg9DPNNWrZXnbtLJ_bEhMJUjiua9Q@mail.gmail.com>
References: <000000000000dece03058f87bf11@google.com>
         <00000000000091301a058fabc3f1@google.com>
         <CAAeHK+zV2TXWtdmLj8Fjpfg9DPNNWrZXnbtLJ_bEhMJUjiua9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 19.11.2019, 14:46 +0100 schrieb Andrey Konovalov:
> 
> #syz dup: WARNING in wdm_write/usb_submit_urb
> 
> https://syzkaller.appspot.com/bug?extid=d232cca6ec42c2edb3fc

Hi,

this is a bit odd. A fix for that bug went in quite some time ago.
Is the kernel tree these tests are running on regularly updated?

	Regards
		Oliver

