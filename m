Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F2FC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7FB2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyczwn3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKLMCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:02:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573560147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86d78sKJ++ShqokmkOTiST9dtUBC3J059GE8dycM4HY=;
        b=hyczwn3GGyXGIO1Wfa39K+jwKNuUCxWNrVIYziz/TQeP5xDiYS3FRam3M/GYJIv0x6JJqh
        svPJ0d3Vs/xv2MrwLFP+MpsqJ7DdqMeDs2zzXoG2SrcF65yvfirzHxjmAOi0HQPqRkQ3+K
        +0zfOotKw4iOpU6KhCuSTjqlXxS1KE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-AVPtyDyaNjWDwpaiGBLQTg-1; Tue, 12 Nov 2019 07:02:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BC8B7A50B;
        Tue, 12 Nov 2019 12:02:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB0A60171;
        Tue, 12 Nov 2019 12:02:23 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4306018089C8;
        Tue, 12 Nov 2019 12:02:23 +0000 (UTC)
Date:   Tue, 12 Nov 2019 07:02:23 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-xfs@vger.kernel.org,
        lkp@lists.01.org, Christoph Hellwig <hch@lst.de>,
        ltp@lists.linux.it
Message-ID: <1108442397.11662343.1573560143066.JavaMail.zimbra@redhat.com>
In-Reply-To: <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
References: <20191111010022.GH29418@shao2-debian> <3fb8b1b04dd7808b45caf5262ee629c09c71e0b6.camel@themaw.net>
Subject: Re: [LTP] [xfs] 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.27]
Thread-Topic: 73e5fff98b: kmsg.dev/zero:Can't_open_blockdev
Thread-Index: lFLu9oVj8OlcWVE2QLH5SvyKY02GuQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AVPtyDyaNjWDwpaiGBLQTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >=20
> > [  135.976643] LTP: starting fs_fill
> > [  135.993912] /dev/zero: Can't open blockdev
>=20
> I've looked at the github source but I don't see how to find out what
> command was used when this error occurred so I don't know even how to
> start to work out what might have caused this.
>=20
> Can you help me to find the test script source please.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/f=
s_fill/fs_fill.c

Setup of that test is trying different file system types, and it looks
at errno code of "mount -t $fs /dev/zero /mnt/$fs".

Test still PASSes. This report appears to be only about extra message in dm=
esg,
which wasn't there before:

# mount -t xfs /dev/zero /mnt/xfs
# dmesg -c
[  897.177168] /dev/zero: Can't open blockdev

Regards,
Jan

