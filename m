Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ECCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4E820836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7dsOwud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfLKOYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:24:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42968 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfLKOYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:24:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so16803645lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wUfcAcnFBe6WtukeJWhqpn8x3QOjL+beAb8698aWAeI=;
        b=C7dsOwud2dvcj6Y4qsKZ+L9w5Vz6nGmiUuLBaIMXRUyHcglBta8z/eTFJmvfV8w+gj
         kAq55GqYAlNrzyviUyDmEwQfgReFmugR8Mq+yTl/CnKSXLQOguEgcZU2IgJvVtAUV74d
         7EpP+8aG5I0MCDU8sMMSCNcaHp27fCNfpRWOY0KU+ghfmC8TFSRdw3LeZk3VwQ1IKxNk
         h3Z0L0Y6Z3OnD/yyNAWSQynclz3gLGDJV0hJ3/v1CP0YZln/EAEYZg8FcDLNLEdlRMAG
         w4F9prm7kVgM1uKcCmwrN7AJpxiZZlx3TGkudpq5ILar3NFHsU8bkgEmQqRr6suJ4mv4
         kKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wUfcAcnFBe6WtukeJWhqpn8x3QOjL+beAb8698aWAeI=;
        b=IpX6VTPWCGBWtvGXzqTL1lXdMNZhwm2Rwnms6kUnxDKDH29VFKvTe/n2wTrXszuXNT
         Zx+xMDIMAuZLRSXPn+IJNxy8CGT5Wd7UdH5ntdBqFRrU1yvJzbQYr40FZnJMnP8TKJoC
         5++BQKfffKcwm/N8wI8hWFhfUYQUnuxyFJ/91kB29C1N+p0vg2I50vtjE0g+I9IVDdZm
         9mZXeKAK4Qq0/lNnINwrNlarmoua2zL5mcYPEmCEy9VSv+1SmW5Y/ez6WJcWhMOpAuci
         4/MDcEU6tD/JPwk2QbL/2ORJ+0pLoW9e/Yp4X1vLIVBqNmPVq94i2Vj5H9TUZaO8VymU
         ++jA==
X-Gm-Message-State: APjAAAWeVUig8j2XohkK1ZiY/mHIrjxMpMQpSvizgBC6i3YmTC9RkzwJ
        qZzqJ+DUyYvbi6GGI8dCyMu2ttux6YRgHapjSkwdwg==
X-Google-Smtp-Source: APXvYqwc2TsSGxtAysSfLON5GH+m4pqYIp/+YTd22k75uaW7BnPxJjDSAjhC28yKMszdGrjAbplFPVX26cSCabanRXI=
X-Received: by 2002:a19:f811:: with SMTP id a17mr2385232lff.182.1576074242515;
 Wed, 11 Dec 2019 06:24:02 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 11 Dec 2019 15:23:51 +0100
Message-ID: <CADYN=9J=hL_tcGv7iAx-LUKEXN2UEvs_=L016-+4F37o_EFkHQ@mail.gmail.com>
Subject: Internal error: arm64: allmodconfig
To:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     manivannan.sadhasivam@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got an "Internal error: Oops" when I was running an arm64
allmodconfig kernel
from linux-next, tag: next-20191211.
I disabled CONFIG_DEBUG_TEST_DRIVER_REMOVE and I didn't see this.

Have anyone seen this before?

[  197.227295][    T1] ------------[ cut here ]------------
[  197.229206][    T1] kernel BUG at lib/list_debug.c:53!
[  197.231775][    T1] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  197.233776][    T1] Modules linked in:
[  197.235087][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.5.0-rc1-next-20191211-00015-ge6f2690932be #1
[  197.238131][    T1] Hardware name: linux,dummy-virt (DT)
[  197.239892][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
[  197.241788][    T1] pc : __list_del_entry_valid+0xd0/0x138
[  197.243663][    T1] lr : __list_del_entry_valid+0xd0/0x138
[  197.245444][    T1] sp : ffff00006a3e7660
[  197.246845][    T1] x29: ffff00006a3e7660 x28: ffff000065d1bce8
[  197.248855][    T1] x27: ffff000065d72830 x26: ffffa000144ee900
[  197.250810][    T1] x25: ffffa00015a76fc2 x24: 0000000000000000
[  197.252762][    T1] x23: ffff000065d728c8 x22: ffff000065d72878
[  197.254723][    T1] x21: ffff000065d25618 x20: ffff000065d25618
[  197.256721][    T1] x19: ffff000065d728f8 x18: 0000000000002660
[  197.258704][    T1] x17: 0000000000002710 x16: 0000000000001480
[  197.260716][    T1] x15: 00000000000014bc x14: 20747562202c3866
[  197.262706][    T1] x13: ffff80000d47ce43 x12: 1fffe0000d47ce42
[  197.264685][    T1] x11: 1fffe0000d47ce42 x10: ffff80000d47ce42
[  197.266648][    T1] x9 : ffffa000103d14a4 x8 : 0000000000000001
[  197.268586][    T1] x7 : ffff80000d47ce43 x6 : 0000000041b58ab3
[  197.270515][    T1] x5 : ffff00006a3d8040 x4 : 0000000000000000
[  197.272525][    T1] x3 : ffffa000103d14c0 x2 : 90253b7cba50c200
[  197.274444][    T1] x1 : 0000000000000000 x0 : 0000000000000054
[  197.276411][    T1] Call trace:
[  197.277536][    T1]  __list_del_entry_valid+0xd0/0x138
[  197.279240][    T1]  __dentry_kill+0x174/0x3e8
[  197.280741][    T1]  dput+0x880/0x8f8
[  197.282009][    T1]  simple_recursive_removal+0x1bc/0x3b8
[  197.283798][    T1]  debugfs_remove+0x80/0x98
[  197.285301][    T1]  irq_domain_remove+0x48/0x228
[  197.286889][    T1]  gpiochip_irqchip_remove+0x160/0x308
[  197.288670][    T1]  gpiochip_remove+0x6c/0x1c0
[  197.290227][    T1]  devm_gpio_chip_release+0x2c/0x38
[  197.291940][    T1]  release_nodes+0x530/0x570
[  197.293507][    T1]  devres_release_all+0x70/0x90
[  197.295120][    T1]  really_probe+0x51c/0x928
[  197.296574][    T1]  driver_probe_device+0x16c/0x238
[  197.298259][    T1]  device_driver_attach+0x94/0xc8
[  197.299924][    T1]  __driver_attach+0x1e8/0x200
[  197.301473][    T1]  bus_for_each_dev+0xf8/0x190
[  197.303029][    T1]  driver_attach+0x3c/0x48
[  197.304478][    T1]  bus_add_driver+0x20c/0x3d0
[  197.305966][    T1]  driver_register+0x168/0x200
[  197.307566][    T1]  amba_driver_register+0xbc/0xc8
[  197.309216][    T1]  pl061_gpio_init+0x20/0x28
[  197.310704][    T1]  do_one_initcall+0x4c8/0xae8
[  197.312250][    T1]  kernel_init_freeable+0x3e8/0x508
[  197.314019][    T1]  kernel_init+0x1c/0x208
[  197.315519][    T1]  ret_from_fork+0x10/0x18
[  197.317088][    T1] Code: aa1403e2 aa1303e1 91088000 97cf4483 (d4210000)
[  197.319496][    T1] ---[ end trace 73596202c5dd1276 ]---
[  197.321358][    T1] Kernel panic - not syncing: Fatal exception
[  197.323402][    T1] Kernel Offset: disabled
[  197.324892][    T1] CPU features: 0x00002,20002004
[  197.326550][    T1] Memory Limit: none
[  197.327957][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---


Cheers,
Anders
