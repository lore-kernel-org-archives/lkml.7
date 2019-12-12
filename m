Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA52C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF062173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYfqva1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfLLP5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:57:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729734AbfLLP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxNkdTGL+BHDrpQPm/i6A4JCBzTI+wc8n9aRFvVKItM=;
        b=CYfqva1BnMdTn9G2tv3dAjk5Vn5Y0L2QNwNSSxpKh0DQljPWehISwIgMDxxggFa9KfSnng
        74LoUznPPgqQscR1RD+CE+k2yXviwkXl7fS85xI4Wozk0BUqqrEYZoeMU/xebEtl8EJWMd
        5CroIL/sXBuYYB8b0KeW3mnRF0AiK7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-GV9XHqYCP_G1WJjPtl2YTw-1; Thu, 12 Dec 2019 10:57:28 -0500
X-MC-Unique: GV9XHqYCP_G1WJjPtl2YTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 009A7186E8C0;
        Thu, 12 Dec 2019 15:57:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D46C060303;
        Thu, 12 Dec 2019 15:57:25 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3554283729;
        Thu, 12 Dec 2019 15:57:25 +0000 (UTC)
Date:   Thu, 12 Dec 2019 10:57:25 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     syzbot <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, gustavo@padovan.org,
        johan hedberg <johan.hedberg@gmail.com>, jslaby@suse.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic poulain <loic.poulain@intel.com>, marcel@holtmann.org,
        mhjungk@gmail.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Message-ID: <678541062.767044.1576166245082.JavaMail.zimbra@redhat.com>
In-Reply-To: <000000000000b17fae05993f628b@google.com>
References: <000000000000b17fae05993f628b@google.com>
Subject: Re: WARNING in tty_set_termios
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.2.123, 10.4.195.2]
Thread-Topic: WARNING in tty_set_termios
Thread-Index: nfPhKBJJSkrI9vtIk7Do/4ncxH+k5w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: Bluetooth: hci_uart: check for missing tty operations

Best regards,
Vladis Dronov

----- Original Message -----
> From: "syzbot" <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
> To: gregkh@linuxfoundation.org, gustavo@padovan.org, "johan hedberg" <johan.hedberg@gmail.com>, jslaby@suse.com,
> linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, "loic poulain" <loic.poulain@intel.com>,
> marcel@holtmann.org, mhjungk@gmail.com, syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
> vdronov@redhat.com
> Sent: Monday, December 9, 2019 7:20:01 AM
> Subject: Re: WARNING in tty_set_termios
> 
> syzbot suspects this bug was fixed by commit:
> 
> commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
> Author: Vladis Dronov <vdronov@redhat.com>
> Date:   Tue Jul 30 09:33:45 2019 +0000
> 
>      Bluetooth: hci_uart: check for missing tty operations
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b20aeae00000
> start commit:   66c56cfa Merge tag 'remove-dma_zalloc_coherent-5.0' of git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a950165cbb86bdd023a4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cee07400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fdaed8c00000
> 
> If the result looks correct, please mark the bug fixed by replying with:
> 
> #syz fix: Bluetooth: hci_uart: check for missing tty operations
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> 

