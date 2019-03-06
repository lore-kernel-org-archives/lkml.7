Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B139720675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfCFPFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:05:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42478 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfCFPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:05:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so6950795qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AI5UH56vjK3geeI68czcbnkrAamK54QdpdxzKpXJrI8=;
        b=hHnk6h3cxPC9E4PZ318tjWiI8FSa0DT6BI+Zi4UuNfCEekoSsoolmgxEOnxD5asyHk
         JM8jO1XuCM/H4wXiokOs5crlk6YquZX1iwkiNdKyuiYkc5JZBDaEbZwzwE8TRt3UaLp3
         zO27IE17KsjON5nBsCFqYRRb/3Q+zF9rOGBKAM2MxYVCzgPgulCC1tIAIOBS/00/gekp
         boVlYvlETwXyG0OGvym0EKIDAAU7Ni/Qce0bWxIGby67nn5IF80Ny9ggkJNjpWVAlTMo
         boDhBCf6RprHuhVboY7vISS42bXwLOalTaR0yWdM1lH4pwaKC/y42+Ts5a9CCkIPgmBg
         Y3fw==
X-Gm-Message-State: APjAAAVM2IAVDcEW0v5ahRYXdm2Acb2ECypQRFBZbPlBWnqfJk+MEdqZ
        j4Y9iNuo9toaquVMQvF0RFMVvr7MbQ5zVlQ5SO0=
X-Google-Smtp-Source: APXvYqxIsRrwMRxZCmwNkf8uQ+at2Q5W0kcPXSfYPI/r6I+Sl1sB7LdJu3+AYsBclnDCsJSgf/PBcCLfmIucKDBK2SE=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr6069657qki.291.1551884702524;
 Wed, 06 Mar 2019 07:05:02 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:04:46 +0100
Message-ID: <CAK8P3a0gCmN3hAmV-YaX_a1p-DpyMtVKADN2YwhSxi=wPiyyjg@mail.gmail.com>
Subject: [GIT PULL] y2038: A build fix for compat mode
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cfbe271667b7aba03b403aee916ccd457409d2e8:

  Merge tag 'y2038-syscall-abi' of
git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground into
timers/2038 (2019-02-27 21:45:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-fix

for you to fetch changes up to 7e89a37c477c4caacde7b511c64720e20104945f:

  ipc: Fix building compat mode without sysvipc (2019-03-06 16:00:56 +0100)

----------------------------------------------------------------
y2038: A build fix for compat mode

Here is one more patch on top of the y2038 changes already pulled
for linux-5.1, for some reason this had escaped all testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (1):
      ipc: Fix building compat mode without sysvipc

 kernel/sys_ni.c | 3 +++
 1 file changed, 3 insertions(+)
