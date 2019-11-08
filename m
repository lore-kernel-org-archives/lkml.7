Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE24FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236B821882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFZjfE0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbfKHIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:53:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727649AbfKHIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573203220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6/rp2sqHx63a+SahoXLpWtKxXlEYGHQF9yA0visXkA=;
        b=bFZjfE0oHTCUcMMmHg6zBwhuyQkuiAeeWJPygGLh10/YgFsEDbNRJBQtcdJcJi/hoxvdPz
        duSMF+v8PRum90FNREmHVT1nHhX+JUUftp5jn6LOKi+VmFWUS79oGocRDgT2cma4QDX9BV
        azpXddOmAaPwDDnRFRyqHSdSskuUuYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-6G1-7NXPP82WUfVR0rZY1Q-1; Fri, 08 Nov 2019 03:53:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79B79107ACC3;
        Fri,  8 Nov 2019 08:53:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04FFA60BE1;
        Fri,  8 Nov 2019 08:53:34 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 668461803C32;
        Fri,  8 Nov 2019 08:53:33 +0000 (UTC)
Date:   Fri, 8 Nov 2019 03:53:33 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     syzbot <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
Cc:     gustavo@padovan.org, johan hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, ytkim@qca.qualcomm.com
Message-ID: <147419886.15836536.1573203213339.JavaMail.zimbra@redhat.com>
In-Reply-To: <000000000000eac5200596c1d46b@google.com>
References: <000000000000eac5200596c1d46b@google.com>
Subject: Re: general protection fault in qca_setup
MIME-Version: 1.0
X-Originating-IP: [10.40.205.171, 10.4.195.27]
Thread-Topic: general protection fault in qca_setup
Thread-Index: nCtYTpj9im0+XRib/oPMJOIb6++6QQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6G1-7NXPP82WUfVR0rZY1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: Bluetooth: hci_uart: check for missing tty operations

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

----- Original Message -----
> From: "syzbot" <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
> To: gustavo@padovan.org, "johan hedberg" <johan.hedberg@gmail.com>, linux=
-bluetooth@vger.kernel.org,
> linux-kernel@vger.kernel.org, marcel@holtmann.org, syzkaller-bugs@googleg=
roups.com, torvalds@linux-foundation.org,
> vdronov@redhat.com, ytkim@qca.qualcomm.com
> Sent: Thursday, November 7, 2019 2:42:08 PM
> Subject: Re: general protection fault in qca_setup
>=20
> syzbot suspects this bug was fixed by commit:
>=20
> commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
> Author: Vladis Dronov <vdronov@redhat.com>
> Date:   Tue Jul 30 09:33:45 2019 +0000
>=20
>      Bluetooth: hci_uart: check for missing tty operations
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1436b32c60=
0000
> start commit:   d1393711 Linux 5.0-rc6
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dee434566c893c=
7b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8c0dbf8843bb75e=
faa05
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D130894af400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10799004c0000=
0
>=20
> If the result looks correct, please mark the bug fixed by replying with:
>=20
> #syz fix: Bluetooth: hci_uart: check for missing tty operations
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

