Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F08420715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKOFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:13:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:55688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfKOFNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:13:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 21:13:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="235950543"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2019 21:12:59 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Shakeel Butt <shakeelb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][v2] Add task resctrl information in procfs
Date:   Fri, 15 Nov 2019 13:23:40 +0800
Message-Id: <cover.1573788882.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the resctrl information in /proc/{pid}/resctrl
so that the user space tool is able to locate the resctrl
directory path in O(1) rather than O(n) - n is the number
of tasks in the system.

Chen Yu (2):
  resctrl: Add CPU_RESCTRL
  x86/resctrl: Add task resctrl information display

 arch/Kconfig                           |  4 +++
 arch/x86/Kconfig                       |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 47 ++++++++++++++++++++++++++
 fs/proc/base.c                         |  7 ++++
 include/linux/resctrl.h                | 16 +++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 include/linux/resctrl.h

-- 
2.17.1

