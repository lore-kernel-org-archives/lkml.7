Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B66CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8E20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaRLZb1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502943AbfJXO6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:58:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502933AbfJXO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571929133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C3O8xkMlNTacs7QFl/kG+JtoRc2JwZyKRRSlmHSj0Xk=;
        b=YaRLZb1Dj5jKfCxbyxVa8JCeb3dlVjj2wm/wWu5XRybFkjdMQa4yndCqBbm7IJ8ajD+tbk
        Lg60moRgsUyittPDW8vZd1sP761EYKDz9U7jB1Pq+jo1PGi4O6ZTXkO1QZW3bq1oKY6TIj
        ljRhs+cg8vsxFaQAxnUKcG04PYpYkN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-1ZDlhaUvNsWARoxPtOBSTg-1; Thu, 24 Oct 2019 10:58:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2781005A55;
        Thu, 24 Oct 2019 14:51:24 +0000 (UTC)
Received: from max.com (unknown [10.40.205.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FB0660A97;
        Thu, 24 Oct 2019 14:51:23 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2: Fix a memory leak introduced in -rc1
Date:   Thu, 24 Oct 2019 16:51:20 +0200
Message-Id: <20191024145120.16939-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1ZDlhaUvNsWARoxPtOBSTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following fix for gfs2.

Thanks,
Andreas

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241=
:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gf=
s2-v5.4-rc4.fixes

for you to fetch changes up to 30aecae86e914f526a2ca8d552011960ef6a2615:

  gfs2: Fix memory leak when gfs2meta's fs_context is freed (2019-10-24 16:=
20:43 +0200)

----------------------------------------------------------------
Fix a memory leak introduced in -rc1.

----------------------------------------------------------------
Andrew Price (1):
      gfs2: Fix memory leak when gfs2meta's fs_context is freed

 fs/gfs2/ops_fstype.c | 1 +
 1 file changed, 1 insertion(+)

