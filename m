Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA67206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556293203;
	bh=aAaugfC/CUVO6dTBORWe1tSSO4TClAgWzURPCFvwM1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AxgMCVjttdCLvynBLY3Bq/Ov6b3Nc9aClqLAH4+4QlLOOyyJ9MgcP5h25zISy4bHU
	 QTrqsKu3c8fsOrlo9fhCEa4Jrlbd2splyaMWtAaO2vlKHIjjeqlUgMObqs/dTisJEe
	 jh2Qapb45FN0txt0KE8LTiOzexSVwuP2JYng3osI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDZPkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:40:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:49582 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDZPkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=16uZ7IKY0ZVsZFtwWmnG9sJK2gJj5IMiMiqr4KT0ZEk=; b=XiaUviSKZNFfj4JRA7RP2kQTqs
        n4LDrrJTBX6ngJPQW9v5PExJGOW4e7Uu6ZwJQRMZH9rv9FAnjBwnKSjeXU7yyuhFI7/C+yxxJMjG9
        hcTpWSDBzSBJVstBSk22/H9It8lenLtTKuW0NL0TSskwKHrFScTXtRlhcdyL4GrOtM1wwKw6MDuea
        Q6uyemYRl/p4SxJQTfT8bWxvqpAYQnf+Ia0l0rYwrkVv0TNc+TgI5tQfmrDdgB53UbQd8NyBftAUD
        1bpJd6ict1FsZAzFUkZdNPmZVJRBcZUtGJCNZj23Eq9LaRJ5+Sjsb8sedFHVtVr64mRlC7yHIhs22
        71RAL6qw==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK2x5-0007rx-3e; Fri, 26 Apr 2019 15:39:51 +0000
Date:   Fri, 26 Apr 2019 12:39:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190426123946.554730b8@coco.lan>
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:23 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Hi all,
> 
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux x86 docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://www.bytemem.com:8080/kernel-doc/index.html

Do you have a URL for the git tree? It is probably easier to merge from
it on a tem branch locally, specially for some patches like 02/27, were 
git didn't understand the conversion as a rename.

> 
> Thank you!
> 
> Changbin Du (27):
>   Documentation: add Linux x86 docs to Sphinx TOC tree
>   Documentation: x86: convert boot.txt to reST
>   Documentation: x86: convert topology.txt to reST
>   Documentation: x86: convert exception-tables.txt to reST
>   Documentation: x86: convert kernel-stacks to reST
>   Documentation: x86: convert entry_64.txt to reST
>   Documentation: x86: convert earlyprintk.txt to reST
>   Documentation: x86: convert zero-page.txt to reST
>   Documentation: x86: convert tlb.txt to reST
>   Documentation: x86: convert mtrr.txt to reST
>   Documentation: x86: convert pat.txt to reST
>   Documentation: x86: convert protection-keys.txt to reST
>   Documentation: x86: convert intel_mpx.txt to reST
>   Documentation: x86: convert amd-memory-encryption.txt to reST
>   Documentation: x86: convert pti.txt to reST
>   Documentation: x86: convert microcode.txt to reST
>   Documentation: x86: convert resctrl_ui.txt to reST
>   Documentation: x86: convert orc-unwinder.txt to reST
>   Documentation: x86: convert usb-legacy-support.txt to reST
>   Documentation: x86: convert i386/IO-APIC.txt to reST
>   Documentation: x86: convert x86_64/boot-options.txt to reST
>   Documentation: x86: convert x86_64/uefi.txt to reST
>   Documentation: x86: convert x86_64/mm.txt to reST
>   Documentation: x86: convert x86_64/5level-paging.txt to reST
>   Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
>   Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
>   Documentation: x86: convert x86_64/machinecheck to reST
> 
>  Documentation/index.rst                       |    1 +
>  ...cryption.txt => amd-memory-encryption.rst} |   13 +-
>  Documentation/x86/boot.rst                    | 1238 +++++++++++++++++
>  Documentation/x86/boot.txt                    | 1130 ---------------
>  .../x86/{earlyprintk.txt => earlyprintk.rst}  |  103 +-
>  .../x86/{entry_64.txt => entry_64.rst}        |   12 +-
>  ...eption-tables.txt => exception-tables.rst} |  231 +--
>  .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     |   26 +-
>  Documentation/x86/i386/index.rst              |   10 +
>  Documentation/x86/index.rst                   |   30 +
>  .../x86/{intel_mpx.txt => intel_mpx.rst}      |  120 +-
>  .../x86/{kernel-stacks => kernel-stacks.rst}  |   20 +-
>  .../x86/{microcode.txt => microcode.rst}      |   62 +-
>  Documentation/x86/mtrr.rst                    |  350 +++++
>  Documentation/x86/mtrr.txt                    |  329 -----
>  .../{orc-unwinder.txt => orc-unwinder.rst}    |   27 +-
>  Documentation/x86/pat.rst                     |  235 ++++
>  Documentation/x86/pat.txt                     |  230 ---
>  ...rotection-keys.txt => protection-keys.rst} |   33 +-
>  Documentation/x86/{pti.txt => pti.rst}        |   17 +-
>  .../x86/{resctrl_ui.txt => resctrl_ui.rst}    |  913 ++++++------
>  Documentation/x86/{tlb.txt => tlb.rst}        |   30 +-
>  .../x86/{topology.txt => topology.rst}        |   92 +-
>  ...acy-support.txt => usb-legacy-support.rst} |    8 +-
>  .../{5level-paging.txt => 5level-paging.rst}  |   16 +-
>  Documentation/x86/x86_64/boot-options.rst     |  326 +++++
>  Documentation/x86/x86_64/boot-options.txt     |  278 ----
>  ...{cpu-hotplug-spec => cpu-hotplug-spec.rst} |    5 +-
>  ...-for-cpusets => fake-numa-for-cpusets.rst} |   25 +-
>  Documentation/x86/x86_64/index.rst            |   16 +
>  .../x86_64/{machinecheck => machinecheck.rst} |   11 +-
>  Documentation/x86/x86_64/mm.rst               |  161 +++
>  Documentation/x86/x86_64/mm.txt               |  153 --
>  .../x86/x86_64/{uefi.txt => uefi.rst}         |   30 +-
>  Documentation/x86/zero-page.rst               |   45 +
>  Documentation/x86/zero-page.txt               |   40 -
>  36 files changed, 3412 insertions(+), 2954 deletions(-)
>  rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
>  create mode 100644 Documentation/x86/boot.rst
>  delete mode 100644 Documentation/x86/boot.txt
>  rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (59%)
>  rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
>  rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (67%)
>  rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
>  create mode 100644 Documentation/x86/i386/index.rst
>  create mode 100644 Documentation/x86/index.rst
>  rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)
>  rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)
>  rename Documentation/x86/{microcode.txt => microcode.rst} (81%)
>  create mode 100644 Documentation/x86/mtrr.rst
>  delete mode 100644 Documentation/x86/mtrr.txt
>  rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)
>  create mode 100644 Documentation/x86/pat.rst
>  delete mode 100644 Documentation/x86/pat.txt
>  rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
>  rename Documentation/x86/{pti.txt => pti.rst} (96%)
>  rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (68%)
>  rename Documentation/x86/{tlb.txt => tlb.rst} (81%)
>  rename Documentation/x86/{topology.txt => topology.rst} (74%)
>  rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)
>  rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)
>  create mode 100644 Documentation/x86/x86_64/boot-options.rst
>  delete mode 100644 Documentation/x86/x86_64/boot-options.txt
>  rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)
>  rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (85%)
>  create mode 100644 Documentation/x86/x86_64/index.rst
>  rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)
>  create mode 100644 Documentation/x86/x86_64/mm.rst
>  delete mode 100644 Documentation/x86/x86_64/mm.txt
>  rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)
>  create mode 100644 Documentation/x86/zero-page.rst
>  delete mode 100644 Documentation/x86/zero-page.txt
> 



Thanks,
Mauro
