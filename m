Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9771720675
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLBVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:18:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42260 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBVSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:18:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 80F3028F568
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        fabien.lahoudere@collabora.com, guillaume.tucker@collabora.com,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] Standard x86_64 defconfig for KernelCI or Chromebooks
Date:   Mon,  2 Dec 2019 22:18:42 +0100
Message-Id: <20191202211844.19629-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

For testing purposes it'd be useful have a standard/mainline config that
supports the devices that we're testing in KernelCI. For Chromebooks we
try to take care of have multi_v7_defconfig and arm64 defconfig up to
date supporting different devices, that way, we don't need to deal with
out-of-tree kernel configs or fragments. We'd like to do the same for
x86 architecture, hence this patch series.

I am unsure if the x86_64_defconfig is the right place to do it, if not,
maybe we can add a chromebooks.config (like xen.config) or even better,
a kernelci.config, so take this as a RFC if that's the case.

Thanks,

Enric Balletbo i Serra (2):
  x86_64_defconfig: Normalize x86_64 defconfig
  x86_64_defconfig: Enable support for Chromebooks devices

 arch/x86/configs/x86_64_defconfig | 156 +++++++++++++++++++-----------
 1 file changed, 97 insertions(+), 59 deletions(-)

-- 
2.20.1

