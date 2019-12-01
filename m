Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34228C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037EE2146E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLAUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:18:57 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51648 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfLAUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:18:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23B196075EB6;
        Sun,  1 Dec 2019 21:18:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Xx61N7WiFue1; Sun,  1 Dec 2019 21:18:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF17D609D2D9;
        Sun,  1 Dec 2019 21:18:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gvqUPrLA80Gv; Sun,  1 Dec 2019 21:18:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B72596094C4B;
        Sun,  1 Dec 2019 21:18:54 +0100 (CET)
Date:   Sun, 1 Dec 2019 21:18:54 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1468911323.103246.1575231534725.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.5-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: 76qbsLMIGCl1qWUEP3cLHVH+nD3HKw==
Thread-Topic: UML changes for v5.5-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e472c64aa4fa6150c6076fd36d101d667d71c30a:

  Merge tag 'dmaengine-fix-5.4-rc6' of git://git.infradead.org/users/vkoul/slave-dma (2019-10-31 07:34:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.5-rc1

for you to fetch changes up to 9807019a62dc670c73ce8e59e09b41ae458c34b3:

  um: Loadable BPF "Firmware" for vector drivers (2019-11-25 22:43:31 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Fixes for our new virtio code
- Fix for the irqflags tracer
- Kconfig coding style fixes
- Allow BPF firmware loading in our vector driver

----------------------------------------------------------------
Anton Ivanov (1):
      um: Loadable BPF "Firmware" for vector drivers

Johannes Berg (4):
      um: Don't trace irqflags during shutdown
      um: virtio: Remove device on disconnect
      um: virtio: Keep reading on -EAGAIN
      um: virtio_uml: Disallow modular build

Krzysztof Kozlowski (1):
      um: Fix Kconfig indentation

 arch/um/Kconfig               |   2 +-
 arch/um/drivers/Kconfig       |   2 +-
 arch/um/drivers/vector_kern.c | 113 ++++++++++++++++++++++++++++++++++++++----
 arch/um/drivers/vector_kern.h |   8 ++-
 arch/um/drivers/vector_user.c |  94 ++++++++++++++++++++++++++++-------
 arch/um/drivers/vector_user.h |   8 ++-
 arch/um/drivers/virtio_uml.c  |  76 ++++++++++++++++++----------
 arch/um/os-Linux/main.c       |   2 +-
 8 files changed, 247 insertions(+), 58 deletions(-)
