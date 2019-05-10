Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfEJP2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:28:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:48734 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEJP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:28:39 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 987782C5;
        Fri, 10 May 2019 15:28:38 +0000 (UTC)
Date:   Fri, 10 May 2019 09:28:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Some more documentation work for 5.2
Message-ID: <20190510092837.09b2a4f5@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
d9defe448f4c7b88ca2ae636a321ef8970fa718d:

  docs/livepatch: Unify style of livepatch documentation in the ReST format (2019-05-07 16:06:28 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.2a

for you to fetch changes up to afbd4d42470e91470bc59040094b89cd717530bd:

  Merge branch 'x86' into docs-next (2019-05-08 14:38:11 -0600)

----------------------------------------------------------------
Some late arriving documentation changes.  In particular, this contains the
conversion of the x86 docs to RST (acked by Ingo), which has been in the
works for some time but needed a couple of final tweaks.

There is a moderately annoying conflict with
Documentation/x86/x86_64/mm.txt, which has a parallel change that went in
via the x86 tree.  The resolution is to delete that file but to propagate
the change; I've put a proposed merge (which is really just what Stephen
did in docs-next) at the tag docs-5.2a-merge should that be helpful.
----------------------------------------------------------------

Changbin Du (27): Documentation: add Linux x86 docs to Sphinx TOC tree
      Documentation: x86: convert boot.txt to reST
      Documentation: x86: convert topology.txt to reST
      Documentation: x86: convert exception-tables.txt to reST
      Documentation: x86: convert kernel-stacks to reST
      Documentation: x86: convert entry_64.txt to reST
      Documentation: x86: convert earlyprintk.txt to reST
      Documentation: x86: convert zero-page.txt to reST
      Documentation: x86: convert tlb.txt to reST
      Documentation: x86: convert mtrr.txt to reST
      Documentation: x86: convert pat.txt to reST
      Documentation: x86: convert protection-keys.txt to reST
      Documentation: x86: convert intel_mpx.txt to reST
      Documentation: x86: convert amd-memory-encryption.txt to reST
      Documentation: x86: convert pti.txt to reST
      Documentation: x86: convert microcode.txt to reST
      Documentation: x86: convert resctrl_ui.txt to reST
      Documentation: x86: convert orc-unwinder.txt to reST
      Documentation: x86: convert usb-legacy-support.txt to reST
      Documentation: x86: convert i386/IO-APIC.txt to reST
      Documentation: x86: convert x86_64/boot-options.txt to reST
      Documentation: x86: convert x86_64/uefi.txt to reST
      Documentation: x86: convert x86_64/mm.txt to reST
      Documentation: x86: convert x86_64/5level-paging.txt to reST
      Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
      Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
      Documentation: x86: convert x86_64/machinecheck to reST

Federico Vaga (1):
      doc:it_IT: align documentation after licenses patches

Jonathan Corbet (1):
      Merge branch 'x86' into docs-next

Tzvetomir Stoyanov (1):
      Documentation/trace: Add clarification how histogram onmatch works

 Documentation/index.rst                            |   1 +
 Documentation/trace/histogram.rst                  |  11 +-
 .../translations/it_IT/process/license-rules.rst   |  60 +-
 ...ry-encryption.txt => amd-memory-encryption.rst} |  13 +-
 Documentation/x86/{boot.txt => boot.rst}           | 528 +++++++-----
 .../x86/{earlyprintk.txt => earlyprintk.rst}       | 122 +--
 Documentation/x86/{entry_64.txt => entry_64.rst}   |  12 +-
 .../{exception-tables.txt => exception-tables.rst} | 247 +++---
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}          |  28 +-
 Documentation/x86/i386/index.rst                   |  10 +
 Documentation/x86/index.rst                        |  30 +
 Documentation/x86/{intel_mpx.txt => intel_mpx.rst} | 120 +--
 .../x86/{kernel-stacks => kernel-stacks.rst}       |  20 +-
 Documentation/x86/{microcode.txt => microcode.rst} |  62 +-
 Documentation/x86/mtrr.rst                         | 354 ++++++++
 Documentation/x86/mtrr.txt                         | 329 --------
 .../x86/{orc-unwinder.txt => orc-unwinder.rst}     |  27 +-
 Documentation/x86/pat.rst                          | 242 ++++++
 Documentation/x86/pat.txt                          | 230 ------
 .../{protection-keys.txt => protection-keys.rst}   |  33 +-
 Documentation/x86/{pti.txt => pti.rst}             |  17 +-
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}         | 916 +++++++++++----------
 Documentation/x86/{tlb.txt => tlb.rst}             |  30 +-
 Documentation/x86/{topology.txt => topology.rst}   |  92 ++-
 ...b-legacy-support.txt => usb-legacy-support.rst} |  40 +-
 .../{5level-paging.txt => 5level-paging.rst}       |  16 +-
 Documentation/x86/x86_64/boot-options.rst          | 335 ++++++++
 Documentation/x86/x86_64/boot-options.txt          | 278 -------
 .../{cpu-hotplug-spec => cpu-hotplug-spec.rst}     |   5 +-
 ...-numa-for-cpusets => fake-numa-for-cpusets.rst} |  25 +-
 Documentation/x86/x86_64/index.rst                 |  16 +
 .../x86/x86_64/{machinecheck => machinecheck.rst}  |  12 +-
 Documentation/x86/x86_64/mm.rst                    | 161 ++++
 Documentation/x86/x86_64/mm.txt                    | 153 ----
 Documentation/x86/x86_64/{uefi.txt => uefi.rst}    |  30 +-
 Documentation/x86/zero-page.rst                    |  45 +
 Documentation/x86/zero-page.txt                    |  40 -
 37 files changed, 2620 insertions(+), 2070 deletions(-)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
 rename Documentation/x86/{boot.txt => boot.rst} (73%)
 rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (51%)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (64%)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
 create mode 100644 Documentation/x86/i386/index.rst
 create mode 100644 Documentation/x86/index.rst
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)
 create mode 100644 Documentation/x86/mtrr.rst
 delete mode 100644 Documentation/x86/mtrr.txt
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
 rename Documentation/x86/{pti.txt => pti.rst} (96%)
 rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (68%)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)
 rename Documentation/x86/{topology.txt => topology.rst} (74%)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (53%)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)
 create mode 100644 Documentation/x86/x86_64/boot-options.rst
 delete mode 100644 Documentation/x86/x86_64/boot-options.txt
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (85%)
 create mode 100644 Documentation/x86/x86_64/index.rst
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)
 create mode 100644 Documentation/x86/x86_64/mm.rst
 delete mode 100644 Documentation/x86/x86_64/mm.txt
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt
