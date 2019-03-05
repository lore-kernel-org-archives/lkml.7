Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6258820652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JBoAMPA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfCEWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:35:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38766 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:35:48 -0500
Received: by mail-lf1-f65.google.com with SMTP id t2so2801024lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=H5EaCEM8IwjJTJOyWJM1wgz/KhpCFBgM9FRNacppwU0=;
        b=JBoAMPA+yLJrqSQWI1AO71qqMzg8NAgHWQg8WkX/i/R0jX7RpkTkXwI2FTiDiLHDR2
         eKPbdngbIzNXED/Xm2pa1j6cLwAnigvb9jEzbaoHka6FX+kgsXHaqTwv1mTkYRSwHCtr
         qGoug5sQ7syNdD2ghFHyXXgOTu/usQCbScROHILHI3KZ5VS6uYDESzxy/7Rn9vHfMw3T
         wiWZq/o0EkBSyoFduthyNyxkJnmU/FiHXuLOx62ZRyIEbv9poL1sSYbBC15DlHUy2v+Q
         DmYA9Edje4BovyqcQukw6tUQSPpAZW4XRUnjbvD0tbKAO8CwXkFNK0GbHozE8soIlhnK
         XluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=H5EaCEM8IwjJTJOyWJM1wgz/KhpCFBgM9FRNacppwU0=;
        b=R1pMH/5TxLebw8xqC5CTy0bS4vQMtopv8SI68QuxaZcmR5Csu9R91NqAl0K8p65QcJ
         XWJEjaojy8s7upehYQVv7pEY+xLO/zyUqF5eICjBu/WLgZRjxc03SWLIYwqgHp6X3YHG
         0vO20UbC0VdX45jKe3EPBKwEHTQHhdDwMInX9ymH5ZVrJqaQNkLpZFfL88078zXcbTWK
         1OdD0bZmJojVBc8kXqbicmSC5YTkKmnXUgvoATyS5Z8qFWrhiPzb5Nu0dmfjIB/BejP7
         58WbhowPLwaS0F9PZYzHHmrmEJoGy+UCradfeZUK6T5E3xnjkLvegwlG9iQagb6p17mP
         nCkQ==
X-Gm-Message-State: APjAAAWAWgjg1ZVAhcgxZzh5pYfbagx/s+zIUX+SPrlEYorDH6P4qJJW
        lhMQktly8pZPHrqLney+o8JmkF4a6u0cUZoHaT2U
X-Google-Smtp-Source: APXvYqwWcW88o5HTu+b2GRN3GBpSDp2pGmtLAXd4p0uCkqBZf787zNN+JjBNTrGzDb5lUOBN/sYa/RusvV8z9fEnp/M=
X-Received: by 2002:a19:23cc:: with SMTP id j195mr1857734lfj.91.1551825346205;
 Tue, 05 Mar 2019 14:35:46 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Mar 2019 17:35:35 -0500
Message-ID: <CAHC9VhRzEap1iU0PAMw44oXnjdSoDBb+S8=es0MGfpC2dDGVGA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A lucky 13 audit patches for v5.1.  Despite the rather large diffstat,
most of the changes are from two bug fix patches that move code from
one Kconfig option to another.  Beyond that bit of churn, the
remaining changes are largely cleanups and bug-fixes as we slowly
march towards container auditing.  It isn't all boring though, we do
have a couple of new things: file capabilities v3 support, and
expanded support for filtering on filesystems to solve problems with
remote filesystems.

All changes pass the audit-testsuite.  Please merge for v5.1.

Thanks,
-Paul

--
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

 Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20190305

for you to fetch changes up to 131d34cb07957151c369366b158690057d2bce5e:

 audit: mark expected switch fall-through (2019-02-12 20:17:13 -0500)

----------------------------------------------------------------
audit/stable-5.1 PR 20190305

----------------------------------------------------------------
Gustavo A. R. Silva (1):
     audit: mark expected switch fall-through

Richard Guy Briggs (12):
     audit: give a clue what CONFIG_CHANGE op was involved
     audit: hand taken context to audit_kill_trees for syscall logging
     audit: add syscall information to CONFIG_CHANGE records
     audit: move loginuid and sessionid from CONFIG_AUDITSYSCALL to
            CONFIG_AUDIT
     audit: add support for fcaps v3
     audit: more filter PATH records keyed on filesystem magic
     audit: clean up AUDITSYSCALL prototypes and stubs
     audit: ignore fcaps on umount
     audit: remove unused actx param from audit_rule_match
     audit: remove audit_context when CONFIG_ AUDIT and not AUDITSYSCALL
     audit: join tty records to their syscall
     audit: hide auditsc_get_stamp and audit_serial prototypes

drivers/tty/tty_audit.c             |   2 +-
fs/namei.c                          |   2 +-
fs/namespace.c                      |   2 +
fs/proc/base.c                      |   6 +-
include/linux/audit.h               |  66 ++++----
include/linux/capability.h          |   5 +-
include/linux/lsm_hooks.h           |   4 +-
include/linux/namei.h               |   3 +
include/linux/sched.h               |   4 +-
include/linux/security.h            |   5 +-
init/init_task.c                    |   2 +-
kernel/audit.c                      | 267 ++++++++++++------------------
kernel/audit.h                      |  81 +++++----
kernel/audit_fsnotify.c             |   2 +-
kernel/audit_tree.c                 |  19 ++-
kernel/audit_watch.c                |   2 +-
kernel/auditfilter.c                |   6 +-
kernel/auditsc.c                    | 320 +++++++++++++++++++++++-------------
security/apparmor/audit.c           |   3 +-
security/apparmor/include/audit.h   |   3 +-
security/commoncap.c                |   2 +
security/integrity/ima/ima.h        |   3 +-
security/integrity/ima/ima_policy.c |   6 +-
security/security.c                 |   6 +-
security/selinux/include/audit.h    |   4 +-
security/selinux/ss/services.c      |   3 +-
security/smack/smack_lsm.c          |   4 +-
27 files changed, 440 insertions(+), 392 deletions(-)

-- 
paul moore
www.paul-moore.com
