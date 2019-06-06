Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB1420866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfFFOpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:45:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47094 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfFFOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:45:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so2153345ote.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=csaYIwXQEBX950eZ96n2wzROQkFVAMhN8cg2KCdNjEI=;
        b=hs+BATWLiFbiQebOGmOr9QTkJAy7cMUAmSCT0q8fEBTUvssUvmBZS8UB/Dme1ywsk+
         EJwfy7m5OxkajELDnII/8c8PDCeuxAadSxkJfNudidBxNNbjVJFQCi8IajeboTJgSNu/
         QMfxEfjmzXDK/k/nXtfWqGZxtvEq4V0jmDeAXnkGoUmgFC/qpM1n7/v0nDL6hOQ9BpkM
         FwfUlY4jXr5w/dcln1lwKpS/xMJ5PGuGjiD0oZYt1reOYjYo69qkrWTn4ItfbJdW0qsl
         QIYL2fLOeLuPxFKRcyCzVD39qipfur5al2R0RseFOimDXvuiFPbS35D2cVk8HJBJieB3
         RiYg==
X-Gm-Message-State: APjAAAUVnvAsyVB22Sgqeok8OGehxDL2ZLJqyvexl4NfAzzCj8YrWrn2
        H/5YDr8F6nZCQ0a03Ra7ykq5N5Qh9oXXbypqeXMyouG6YwM=
X-Google-Smtp-Source: APXvYqzOiNSsDsz1tD3ucAPIfuAw+X51u3KUPDzK8U3WMrZ8VztMqbCKvv2H9Im2Ar2t1P4QYr7//APmNuZpKQS1yQM=
X-Received: by 2002:a9d:704f:: with SMTP id x15mr15024571otj.297.1559832308563;
 Thu, 06 Jun 2019 07:45:08 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 6 Jun 2019 16:44:57 +0200
Message-ID: <CAHc6FU6XnohtY0q365cxhx3-mAQqTCyHdL61XV1Z2wbTQL_EPg@mail.gmail.com>
Subject: [GET PULL] Revert "gfs2: Replace gl_revokes with a GLF flag"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following revert? The patch turned out to be broken.

Thank you very much,
Andreas

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
tags/gfs2-v5.2.fixes

for you to fetch changes up to 638803d4568121d73a266e440530f880ffa2dacc:

  Revert "gfs2: Replace gl_revokes with a GLF flag" (2019-06-06 16:29:26 +0200)

----------------------------------------------------------------
Revert commit "gfs2: Replace gl_revokes with a GLF flag".

----------------------------------------------------------------
Bob Peterson (1):
      Revert "gfs2: Replace gl_revokes with a GLF flag"

 fs/gfs2/glock.c  |  4 ++--
 fs/gfs2/incore.h |  2 +-
 fs/gfs2/log.c    |  4 +---
 fs/gfs2/lops.c   | 33 +++++++++------------------------
 fs/gfs2/main.c   |  1 +
 fs/gfs2/super.c  |  2 +-
 6 files changed, 15 insertions(+), 31 deletions(-)
