Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F17C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BDB2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfCYV2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:28:18 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:41895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731046AbfCYV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:28:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8BD8F182CF66C;
        Mon, 25 Mar 2019 21:28:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hands11_2a9bf37221a53
X-Filterd-Recvd-Size: 4705
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:28:12 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@amd64.org>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Bad file pattern in MAINTAINERS section 'X86 MCE INFRASTRUCTURE'
Date:   Mon, 25 Mar 2019 14:28:11 -0700
Message-Id: <20190325212811.27961-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	16938	X86 MCE INFRASTRUCTURE
	16939	M:	Tony Luck <tony.luck@intel.com>
	16940	M:	Borislav Petkov <bp@alien8.de>
	16941	L:	linux-edac@vger.kernel.org
	16942	S:	Maintained
-->	16943	F:	arch/x86/kernel/cpu/mcheck/*

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'arch/x86/kernel/cpu/mcheck/*':

commit c1f5c54b57341e872a9d375dccef7257f86033ef
Author: Ingo Molnar <mingo@elte.hu>
Date:   Sat Jun 18 22:51:13 2011 +0200

    x86, MAINTAINERS: Add x86 MCE people
    
    Announce the new x86 MCE infrastructure maintainers.
    
    Acked-by: Borislav Petkov <bp@amd64.org>
    Acked-by: Tony Luck <tony.luck@intel.com>
    Acked-by: H. Peter Anvin <hpa@linux.intel.com>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/n/tip-8hs7yob6wib4vblmrmbpbav4@git.kernel.org
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'arch/x86/kernel/cpu/mcheck/*':

commit 21afaf181362b4aeb5be72705d2914673b336149
Author: Borislav Petkov <bp@suse.de>
Date:   Sun Nov 18 15:15:05 2018 +0100

    x86/mce: Streamline MCE subsystem's naming
    
    Rename the containing folder to "mce" which is the most widespread name.
    Drop the "mce[-_]" filename prefix of some compilation units (while
    others don't have it).
    
    This unifies the file naming in the MCE subsystem:
    
    mce/
    |-- amd.c
    |-- apei.c
    |-- core.c
    |-- dev-mcelog.c
    |-- genpool.c
    |-- inject.c
    |-- intel.c
    |-- internal.h
    |-- Makefile
    |-- p5.c
    |-- severity.c
    |-- therm_throt.c
    |-- threshold.c
    `-- winchip.c
    
    No functional changes.
    
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Reviewed-by: Ingo Molnar <mingo@kernel.org>
    Acked-by: Tony Luck <tony.luck@intel.com>
    Link: https://lkml.kernel.org/r/20181205141323.14995-1-bp@alien8.de

 arch/x86/kernel/cpu/Makefile                                  |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/Makefile                  | 10 +++++-----
 arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c}           |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c}         |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c}              |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c              |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c}   |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c}     |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c}       |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} |  0
 arch/x86/kernel/cpu/{mcheck => mce}/p5.c                      |  0
 arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c             |  0
 arch/x86/kernel/cpu/{mcheck => mce}/threshold.c               |  0
 arch/x86/kernel/cpu/{mcheck => mce}/winchip.c                 |  0
 15 files changed, 14 insertions(+), 14 deletions(-)
