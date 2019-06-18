Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E835C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423092133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfFRIgv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:36:51 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:21744 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbfFRIgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:36:50 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:36:46 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 18 Jun
 2019 16:36:45 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 18 Jun 2019 16:36:45 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v2 0/3] Add support for Zhaoxin Processors
Thread-Topic: [PATCH v2 0/3] Add support for Zhaoxin Processors
Thread-Index: AdUlrSR1T73mI8PvQHamV9Uc0ITcpQ==
Date:   Tue, 18 Jun 2019 08:36:45 +0000
Message-ID: <c9cee6a53cc54a74a0555da9fab07b5d@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a new x86 CPU Vendor, Shanghai Zhaoxin Semiconductor Co., Ltd.
 ("Zhaoxin") provide high performance general-purpose x86 processors.

CPU Vendor ID "Shanghai" belongs to Zhaoxin.

To enable the supports of Linux kernel to Zhaoxin's CPUs, add a new vendor
type (X86_VENDOR_ZHAOXIN, with value of 10) in
arch/x86/include/asm/processor.h.

To enable the support of Linux kernel's specific configuration to
Zhaoxin's CPUs, add a new file arch/x86/kernel/cpu/zhaoxin.c.

This patch series have been applied and tested successfully on Zhaoxin's
Soc silicon. Also tested on other processors, it works fine and makes no
harm to the existing codes.

v1->v2:
 - Rebased on 5.2.0-rc5 and tested against it.
 - remove GPL "boilerplate" text in the patch.
 - adjust signed-off-by: line match From: line.
 - run patch series through checkpatch.pl.

v1:
 - Rebased on 5.2.0-rc1 and tested against it.
 - Split the patch set to small series of patches.
 - Rework patch descriptions.

TonyWWang (3):
 x86/cpu: Create Zhaoxin processors architecture support file
 ACPI, x86: add Zhaoxin processors support for NONSTOP TSC
 x86/acpi/cstate: add Zhaoxin processors support for cache flush policy
 in C3

 MAINTAINERS                      |   6 ++
 arch/x86/Kconfig.cpu             |  13 ++++
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/acpi/cstate.c    |  15 ++++
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/zhaoxin.c    | 164 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpi_pad.c          |   1 +
 drivers/acpi/processor_idle.c    |   1 +
 8 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/zhaoxin.c

-- 
2.7.4
