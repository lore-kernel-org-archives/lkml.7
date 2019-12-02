Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0679C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8C3217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg8QGGoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLBLzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:55:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbfLBLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575287748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuVPluF8Vz2pOHrANYZgmx+snA3qZCVo/pGJeecZlbw=;
        b=fg8QGGoFJMTm0DOyI6j93rpQeN57Zr49j3wzDTmrbYaTFV3DYK3J9d3B6u3E3W8xiBHz7z
        uISDDc2U2HnfbCUStiKVeRdxQje/cEYOtS5M8yhjIjmB2+PT/embjX/SKEHUcGmGwAz0vw
        UQEYI0NAKdtMpXFLWa3odGfExMY4PTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-jpiNLMe-MTubom-DUZiv6Q-1; Mon, 02 Dec 2019 06:55:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25219DB20;
        Mon,  2 Dec 2019 11:55:44 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD3360BFB;
        Mon,  2 Dec 2019 11:55:42 +0000 (UTC)
Date:   Mon, 2 Dec 2019 12:55:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [MANPAGE] move_mount.2
Message-ID: <20191202115540.gx2dcimzns7osbra@10.255.255.10>
References: <10805.1570726908@warthog.procyon.org.uk>
 <11098.1570727091@warthog.procyon.org.uk>
MIME-Version: 1.0
In-Reply-To: <11098.1570727091@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jpiNLMe-MTubom-DUZiv6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:04:51PM +0100, David Howells wrote:
> .B MOVE_MOUNT_F_NO_AUTOMOUNT
> .B MOVE_MOUNT_F_NO_AUTOMOUNT

The mount.h contains:

    #define MOVE_MOUNT_F_AUTOMOUNTS         0x00000002 /* Follow automounts=
 on from path */
    #define MOVE_MOUNT_T_AUTOMOUNTS         0x00000020 /* Follow automounts=
 on to path */

it means the macros are without the "_NO_".

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

