Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F75C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C37204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfHWRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:23:46 -0400
Received: from foss.arm.com ([217.140.110.172]:37574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388934AbfHWRXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:23:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82F2337;
        Fri, 23 Aug 2019 10:23:45 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66C113F246;
        Fri, 23 Aug 2019 10:23:44 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 0/2] ELF: Alternate program property parser
Date:   Fri, 23 Aug 2019 18:23:38 +0100
Message-Id: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an experimental reimplementation of ELF property parsing
(see NT_GNU_PROPERTY_TYPE_0, [1]) for the ELF loader.

This is intended for comparison / merging with [2] (or could replace it,
if people think this approach is better).

This supersedes RFC v1 [3].

For changes see the individual patches.


[1] Linux Extensions to gABI
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI

[2] [PATCH v8 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
https://lore.kernel.org/lkml/20190813205225.12032-23-yu-cheng.yu@intel.com/

[3] [RFC PATCH 0/2] ELF: Alternate program property parser
https://lore.kernel.org/lkml/1566295063-7387-1-git-send-email-Dave.Martin@arm.com/

Dave Martin (2):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support

 fs/Kconfig.binfmt        |   3 ++
 fs/binfmt_elf.c          | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c   |   4 ++
 include/linux/elf.h      |  27 +++++++++++
 include/uapi/linux/elf.h |   5 ++
 5 files changed, 163 insertions(+)

-- 
2.1.4

