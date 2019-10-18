Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0515321852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408823AbfJRPeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:34:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49892 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbfJRPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:34:19 -0400
Received: from [185.81.138.19] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLUGg-0005d2-DU; Fri, 18 Oct 2019 15:34:18 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] usercopy for v5.4-rc4
Date:   Fri, 18 Oct 2019 17:33:13 +0200
Message-Id: <20191018153311.30516-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

/* Summary */
This contains two improvements for the copy_struct_from_user() tests:
- The first patch is a coding style change to get rid of the ugly
  if ((ret |= test())) you pointed out when you pulled the original patchset.
- The second patch avoids soft lockups when running the usercopy tests on
  machines with large page sizes by scanning only a 1024 byte region.

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/copy-struct-from-user-v5.4-rc4

for you to fetch changes up to f418dddffc8007945fd5962380ebde770a240cf5:

  usercopy: Avoid soft lockups in test_check_nonzero_user() (2019-10-16 14:56:21 +0200)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.4-rc2. 

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next.

Please consider pulling these changes from the signed
copy-struct-from-user-v5.4-rc4 tag.

Thanks!
Christian

----------------------------------------------------------------
copy-struct-from-user-v5.4-rc4

----------------------------------------------------------------
Aleksa Sarai (1):
      lib: test_user_copy: style cleanup

Michael Ellerman (1):
      usercopy: Avoid soft lockups in test_check_nonzero_user()

 lib/test_user_copy.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)
