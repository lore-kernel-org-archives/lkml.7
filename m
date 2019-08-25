Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6162FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F6A217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 09:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZDoqqvP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfHYJts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 05:49:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:41111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfHYJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 05:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566726573;
        bh=ZH3ktvFKDfIjfvG3edJxG43YcDL8YeOfATl5KQTWvBU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZDoqqvP/7xezvmXeWAP8SuP3ACUIbkH8/8cbrGpfmkzepxHxi9pi4K+6o8pfrDgH9
         LpBFA5Pq+J/llkiFHeck59TUY7LjBgF/RMxpH7puwp/GlDM8zuymDvCcqnrtcRuy1t
         mcADutQ/x0drAtNUru0Y54E65L65jOAjK4JqOEU8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MRCCJ-1hePfW01E7-00UXKM; Sun, 25 Aug 2019 11:49:33 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add SPDX headers for most files in arch/um
Date:   Sun, 25 Aug 2019 10:49:15 +0100
Message-Id: <20190825094919.4731-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:OEfsTMCMMRvhQOVJAIlqaPmi08JB7rSWVD9OZUgLMN0a4f10BAl
 h7BJHk17LR4qf8w4skPsBSsa6oKJOGyKI6bKNv24Gp6Tpd7GpzhKLX2KUDtVKdlyqBUXirq
 MQ0QllMzlNeC9jglMk/ExucuDdhPKbIUZl7Bpa7DwfUJNSklJ5IDuYzLWvdZf8rl2yBl/ID
 C3SuwTnpHSdGhLR5fvo9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:png6f2SEqsg=:KXJeXyWnY25EJMPX9VnOU1
 2AQf9zIzppNFLaPdYJjwgOylsiOpn2jOIQfgtFqDqhDrD9Au8/AXMmfOYwI6EVi3HSUcxQiue
 CJ5E8NvQkxWqmEtXyPVgaVYzIjDYXJkdwAuEOeRSPyzEyXvlldaXhhxXiPkN2dcVoVY8C7LKT
 o/OIiPRE88brooA8o1JH1CKz4tfGYqELLQtOHsiO1klz0zA7xraR2MUUVyAfGnKpfKlU5qs54
 Y7DJodOf1CIqATdGV+slLxHg1Zr9UvSW6a9bV2qmwsxn4p/RJ0J/wau/EmDstjaIeYbb0/Ls3
 x5eoyTWkdwXdDFVGWf53pMwL7k0Xr8cBmMn3Kktx1Rr1KbogRbfnbAK3Qeg0N4fXZMEe/RaQM
 Z4zYKhvrz9DVZpJjrUSwoGWV9qQ9+Z9Qr/P0PLuUws6EF1GlvzFhlqzz5sORhmrynv7Q4JFDT
 SFWMKU6aPeyYhTAkfgdN06e/Z0N66BtHmVpDNbQPrXgJMdczaKJQBnu1JcQaFBMsAhyAJJPNi
 Mc2f0Q9gEXQDxRUlzQzf78xfS3DfXyxsLdt0+kqFSu+YsRjQGE84RzTLdM7i1uGrbM0IKcJsP
 U9TTs54R6J76OxwUD3erLQ7l4LFoe661gaiRw7RtQXFPntCetaWHWHCqNMWWBCfNdwodW9F+3
 8Xs3W4NM3vjnJS9QSL2sXr1YZ/zJXqfS8Ep1kPgN3isSkcgCw63TffCdPcskHF6Nv9S/yM/4T
 Xz8vG0U6BQvbkxD3arWCTgmYCVeROuRePOvX2rM5rx0xCC4vnX6MVwvx+ZnCGBjoeyi6FHYgu
 MVq2cnpOa7OWAKz4mhNlmdpgFDyJXkeCLMxbXEj9nU+mL/sWyenGkP8gLzAitvl6ndBSXeRRm
 ydSd6ih0LCcJ+xMicorfywwCjm4b6pw5u/sdz9HfOr7P3MVYXCXG1qltoFDqtSYloK8+Kam/J
 AWCctTu8B3NFmlkd1CQMPHmI/CHYWs7zyGd0Ws+H+Vo6JTyHoEqynO0NxVe5M2mQgnTh3qwmd
 MuEFRCuwGXXG2e0HM/QbxfZPcZkNphxgQJPUOkeCshPmxdhRFlIqmQnG0VXGoBBSlFueypTET
 C5DtybmlNaUHaAwx9rHUTC4Wv1BAN4guCTYDjGbJxLTJyQ8Cbvyknd5sZ33Zw1nU4BuHm7NJS
 kUrtqLmSAfBNVrr+ficYZcSPS42RVVSU6gAW5Iy/TZRH6Ujg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most files in arch/um have "Licensed under the GPL" in comments at the
top. Convert to use SPDX headers. I've broken these changes into a
patch series even though they're effectively one logical change,
because the diff was >1700 lines. I can resend as a single patch if
preferred.

There are some remaining files where there was no comment indicating
what the license was, so I haven't added SPDX tags for those (though
presumably they're also GPLv2 -- I can add tags for them in a
separate patch if you like).

The remaining files without SPDX tags are:
arch/um/kernel/asm-offsets.c
arch/um/kernel/dyn.lds.S
arch/um/kernel/vmlinux.lds.S
arch/um/include/shared/mem_user.h
arch/um/include/asm/vmlinux.lds.h
arch/um/include/asm/unwind.h
arch/um/include/asm/kvm_para.h
arch/um/include/asm/asm-prototypes.h
arch/um/os-Linux/execvp.c
arch/um/configs/x86_64_defconfig
arch/um/configs/i386_defconfig
arch/um/drivers/random.c
arch/um/drivers/harddog_kern.c


