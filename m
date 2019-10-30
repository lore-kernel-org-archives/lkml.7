Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD934CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747F220862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyTE4zhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJ3LZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:25:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50699 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726065AbfJ3LZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572434701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WyEl0wLRTIq+YoJeUVVm33OKOBR2PjTrxSrJAN0xprI=;
        b=QyTE4zhZA2qZ5k6QJu2mkESVDYXWWZpj+cm0XiJ0ZeLO1uJO2ptj742ZlS+kL61sgXyV/z
        VDh1D0/mn4yMMPWzYeS7SioLTD6Sza/FqOel1h2ZnFjdApTchPcyM6k9dYVtnvEt2FSa2w
        m2k2M1zOUxKzHKdfPQ4IRAqzt/4HSP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-gA-vopK9M4uyfpozlQqNRw-1; Wed, 30 Oct 2019 07:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 434031800D56;
        Wed, 30 Oct 2019 11:24:58 +0000 (UTC)
Received: from max.com (unknown [10.40.206.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8595DA70;
        Wed, 30 Oct 2019 11:24:52 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2: Fix remounting (broken in -rc1)
Date:   Wed, 30 Oct 2019 12:24:49 +0100
Message-Id: <20191030112449.24984-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gA-vopK9M4uyfpozlQqNRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following fix for gfs2?

Thanks,
Andreas

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02=
:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gf=
s2-v5.4-rc5.fixes

for you to fetch changes up to d5798141fd54cea074c3429d5803f6c41ade0ca8:

  gfs2: Fix initialisation of args for remount (2019-10-30 12:16:53 +0100)

----------------------------------------------------------------
Fix remounting (broken in -rc1).

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Fix initialisation of args for remount

 fs/gfs2/ops_fstype.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

