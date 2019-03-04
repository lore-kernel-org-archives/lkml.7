Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7D20645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551705802;
	bh=/Z+Eu4VKxicBnJ3WSNpCFsvWhbcb8EnIqJmVNWSFyds=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=0qhpBP23EyHqn/UOiEszZ5GhS8XFZOqy0NFb+IWp3WRdb98Bydq053RQo0ulw6gcO
	 9/TTnma3Van/rC6dRAPoZhgVHxX8HbLwUj/yHDiIDkxirk9l8Yn2mxHAcb6tCw2EYg
	 4nTR76sJhiEP5QE0jRozvSTTgvUsV+hMhFYDbW8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfCDNXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:23:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43438 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCDNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:23:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so4159983ota.10;
        Mon, 04 Mar 2019 05:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TrMGOE6oBUPMDQyrfIEs7CkLtiPNUfFxmENf8eQtffg=;
        b=svRfauChykzFu3ZtKCJJvigZmmAbaNEW6Si2llTGl04AnsGb+K0fslIAOJS4r2nuiy
         nD1ehzdvdybSwkQNcy6qnyxUXA9flm1V9OC7z+uw43Qxl2kdjWCXr3gW+LV4KUw5P1Jl
         ls6YfC38/QR3AFsUZovRFeMSAk7V8KOJC1S5Z2jrbSYqDrt+zP1pL0FyxB63i3ocQZIE
         SKRuMIWxK25j7Kr+hljJZRw5VKZXoj3T3CCFTnZLymZhu13pymcWuMG32F1pNhk5CAtF
         lZbFZ0xNOAvo8eQjSHj4Rla3QiicwINLcxAhQh4bC36hDF4nc2KOj5q9AFjEAPwXV2Fb
         ZoEQ==
X-Gm-Message-State: APjAAAX14WfopuiTIzX47KateNNcuz/Ur9AoWc3MZ0TVLSzLXbQTRbsi
        a6VJqLWLByJaDZOHpbbbxJEiEfSNLktxaDpA34qz7bzQ
X-Google-Smtp-Source: APXvYqwrz5H4H9JqVQc4TOUQeVV97hLNMTWaMwCZipsDckFjPJ2GhUV2AGQGEZIgq3BQSKbFOazzs5tSX1z7Kr+yq00=
X-Received: by 2002:a9d:7547:: with SMTP id b7mr11567216otl.244.1551705799204;
 Mon, 04 Mar 2019 05:23:19 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Mar 2019 14:23:08 +0100
Message-ID: <CAJZ5v0gTvVCn6O63+TnU9QueyMgowNRd7dQC0oO18eXJVUMLsQ@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc1

with top-most commit 8167e00e9e35ad90f62e2e424c80c9bc4f3adf7b

 Merge branches 'acpi-video' and 'acpi-x86'

on top of commit 5908e6b738e3357af42c10e1183753c70a0117a9

 Linux 5.0-rc8

to receive ACPI updates for 5.1-rc1.

These are ACPICA updates including ACPI 6.3 support among other
things, APEI updates including the ARM Software Delegated Exception
Interface (SDEI) support, ACPI EC driver fixes and cleanups and other
assorted improvements.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20190215
   including ACPI 6.3 support and more:
   * New predefined methods: _NBS, _NCH, _NIC, _NIH, and _NIG (Erik
     Schmauss).
   * Update of the PCC Identifier structure in PDTT (Erik Schmauss).
   * Support for new Generic Affinity Structure subtable in SRAT
     (Erik Schmauss).
   * New PCC operation region support (Erik Schmauss).
   * Support for GICC statistical profiling for MADT (Erik Schmauss).
   * New Error Disconnect Recover notification support (Erik Schmauss).
   * New PPTT Processor Structure Flags fields support (Erik Schmauss).
   * ACPI 6.3 HMAT updates (Erik Schmauss).
   * GTDT Revision 3 support (Erik Schmauss).
   * Legacy module-level code (MLC) support removal (Erik Schmauss).
   * Update/clarification of messages for control method failures
     (Bob Moore).
   * Warning on creation of a zero-length opregion (Bob Moore).
   * acpiexec option to dump extra info for memory leaks (Bob Moore).
   * More ACPI error to firmware error conversions (Bob Moore).
   * Debugger fix (Bob Moore).
   * Copyrights update (Bob Moore).

 - Clean up sleep states support code in ACPICA (Christoph Hellwig).

 - Rework in_nmi() handling in the APEI code and add suppor for the
   ARM Software Delegated Exception Interface (SDEI) to it (James
   Morse).

 - Fix possible out-of-bounds accesses in BERT-related core (Ross
   Lagerwall).

 - Fix the APEI code parsing HEST that includes a Deferred Machine
   Check subtable (Yazen Ghannam).

 - Use DEFINE_DEBUGFS_ATTRIBUTE for APEI-related debugfs files
   (YueHaibing).

 - Switch the APEI ERST code to the new generic UUID API (Andy
   Shevchenko).

 - Update the MAINTAINERS entry for APEI (Borislav Petkov).

 - Fix and clean up the ACPI EC driver (Rafael Wysocki, Zhang Rui).

 - Fix DMI checks handling in the ACPI backlight driver and add the
   "Lunch Box" chassis-type check to it (Hans de Goede).

 - Add support for using ACPI table overrides included in built-in
   initrd images (Shunyong Yang).

 - Update ACPI device enumeration to treat the PWM2 device as "always
   present" on Lenovo Yoga Book (Yauhen Kharuzhy).

 - Fix up the enumeration of device objects with the PRP0001 device
   ID (Andy Shevchenko).

 - Clean up PPTT parsing error messages (John Garry).

 - Clean up debugfs files creation handling (Greg Kroah-Hartman,
   Rafael Wysocki).

 - Clean up the ACPI DPTF Makefile (Masahiro Yamada).

Thanks!


---------------

Andy Shevchenko (2):
      APEI / ERST: Switch to use new generic UUID API
      ACPI / bus: Respect PRP0001 when retrieving device match data

Bob Moore (8):
      ACPICA: Convert more ACPI errors to firmware errors
      ACPICA: acpiexec: Add option to dump extra info for memory leaks
      ACPICA: All acpica: Update copyrights to 2019
      ACPICA: Update version to 20190108
      ACPICA: Interpreter: Emit warning for creation of a zero-length op region
      ACPICA: Debugger: Fix possible fault with the "test objects" command
      ACPICA: Update/clarify messages for control method failures
      ACPICA: Update version to 20190215

Borislav Petkov (1):
      MAINTAINERS: Add James Morse to the list of APEI reviewers

Christoph Hellwig (1):
      ACPICA: Get rid of acpi_sleep_dispatch()

Erik Schmauss (11):
      ACPICA: Remove legacy module-level code support
      ACPICA: ACPI 6.3: Adding predefined methods _NBS, _NCH, _NIC,
_NIH, and _NIG
      ACPICA: ACPI 6.3: Add Trigger order to PCC Identifier structure in PDTT
      ACPICA: ACPI 6.3: SRAT: add Generic Affinity Structure subtable
      ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter
      ACPICA: ACPI 6.3: MADT: add support for statistical profiling in GICC
      ACPICA: ACPI 6.3: add Error Disconnect Recover Notification value
      ACPICA: ACPI 6.3: PPTT add additional fields in Processor Structure Flags
      ACPICA: ACPI 6.3: HMAT updates
      ACPICA: ACPI 6.3: add GTDT Revision 3 support
      ACPI/ACPICA: Trivial: fix spelling mistakes and fix whitespace formatting

Greg Kroah-Hartman (1):
      ACPI: no need to check return value of debugfs_create functions

Hans de Goede (2):
      ACPI / video: Refactor and fix dmi_is_desktop()
      ACPI / video: Extend chassis-type detection with a "Lunch Box" check

James Morse (23):
      ACPI / APEI: Don't wait to serialise with oops messages when panic()ing
      ACPI / APEI: Remove silent flag from ghes_read_estatus()
      ACPI / APEI: Switch estatus pool to use vmalloc memory
      ACPI / APEI: Make hest.c manage the estatus memory pool
      ACPI / APEI: Make estatus pool allocation a static size
      ACPI / APEI: Don't store CPER records physical address in struct ghes
      ACPI / APEI: Remove spurious GHES_TO_CLEAR check
      ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
      ACPI / APEI: Generalise the estatus queue's notify code
      ACPI / APEI: Don't allow ghes_ack_error() to mask earlier errors
      ACPI / APEI: Move NOTIFY_SEA between the estatus-queue and NOTIFY_NMI
      ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
      KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
      arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
      ACPI / APEI: Move locking to the notification helper
      ACPI / APEI: Let the notification helper specify the fixmap slot
      ACPI / APEI: Pass ghes and estatus separately to avoid a later copy
      ACPI / APEI: Make GHES estatus header validation more user friendly
      ACPI / APEI: Split ghes_read_estatus() to allow a peek at the CPER length
      ACPI / APEI: Only use queued estatus entry during in_nmi_queue_one_entry()
      ACPI / APEI: Use separate fixmap pages for arm64 NMI-like notifications
      firmware: arm_sdei: Add ACPI GHES registration helper
      ACPI / APEI: Add support for the SDEI GHES Notification type

John Garry (1):
      ACPI/PPTT: Add acpi_pptt_warn_missing() to consolidate logs

Masahiro Yamada (1):
      ACPI / DPTF: remove header search path to the parent directory

Rafael J. Wysocki (7):
      ACPI: debug: Clean up acpi_aml_init()
      ACPI: EC: Clean up probing for early EC
      ACPI: EC: Declare boot_ec as static
      ACPI: EC: Make acpi_ec_ecdt_probe() more straightforward
      ACPI: EC: Make acpi_ec_dsdt_probe() more straightforward
      ACPI: EC: Eliminate acpi_config_boot_ec()
      ACPI: EC: Simplify boot EC checks in acpi_ec_add()

Ross Lagerwall (2):
      ACPI: APEI: Fix possible out-of-bounds access to BERT region
      efi: cper: Fix possible out-of-bounds access

Shunyong Yang (1):
      ACPI / tables: table override from built-in initrd

Yauhen Kharuzhy (1):
      ACPI / x86: Make PWM2 device always present at Lenovo Yoga Book

Yazen Ghannam (1):
      ACPI / APEI: Fix parsing HEST that includes Deferred Machine
Check subtable

YueHaibing (1):
      ACPI: APEI: EINJ: Use DEFINE_DEBUGFS_ATTRIBUTE for debugfs files

Zhang Rui (1):
      Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

---------------

 Documentation/acpi/initrd_table_override.txt       |   4 +
 MAINTAINERS                                        |   1 +
 arch/arm/include/asm/kvm_ras.h                     |  14 +
 arch/arm/include/asm/system_misc.h                 |   5 -
 arch/arm64/include/asm/acpi.h                      |   4 +-
 arch/arm64/include/asm/daifflags.h                 |   1 +
 arch/arm64/include/asm/fixmap.h                    |   6 +-
 arch/arm64/include/asm/kvm_ras.h                   |  25 +
 arch/arm64/include/asm/system_misc.h               |   2 -
 arch/arm64/kernel/acpi.c                           |  31 +
 arch/arm64/mm/fault.c                              |  24 +-
 drivers/acpi/Kconfig                               |  10 +
 drivers/acpi/acpi_dbg.c                            |  30 +-
 drivers/acpi/acpi_video.c                          |  20 +-
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   5 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   3 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   4 +-
 drivers/acpi/acpica/acmacros.h                     |   4 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   3 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |  17 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |   2 +-
 drivers/acpi/acpica/dbdisply.c                     |   4 +-
 drivers/acpi/acpica/dbexec.c                       |   4 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dbnames.c                      |   2 +-
 drivers/acpi/acpica/dbobject.c                     |   2 +-
 drivers/acpi/acpica/dbtest.c                       | 164 +++---
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   9 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |  28 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   4 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   4 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   4 +-
 drivers/acpi/acpica/evrgnini.c                     |  21 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   6 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   4 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |  71 ++-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |  10 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exserial.c                     |   4 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |   2 +-
 drivers/acpi/acpica/exutils.c                      |   4 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |  98 +--
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   4 +-
 drivers/acpi/acpica/nsparse.c                      |  68 +--
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/nsutils.c                      |   4 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       | 195 +-----
 drivers/acpi/acpica/psobject.c                     |   2 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |  10 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsdumpinfo.c                   |  14 +-
 drivers/acpi/acpica/rsirq.c                        |   8 +-
 drivers/acpi/acpica/rsserial.c                     |  10 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   4 +-
 drivers/acpi/acpica/tbfind.c                       |   2 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   6 +-
 drivers/acpi/acpica/tbxfload.c                     |  27 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |  20 +-
 drivers/acpi/acpica/utdelete.c                     |   4 +
 drivers/acpi/acpica/uterror.c                      |   9 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   2 +-
 drivers/acpi/acpica/uttrack.c                      |  14 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxferror.c                    |  44 ++
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/apei/Kconfig                          |  12 +-
 drivers/acpi/apei/bert.c                           |  23 +-
 drivers/acpi/apei/einj.c                           |  93 +--
 drivers/acpi/apei/erst.c                           |  27 +-
 drivers/acpi/apei/ghes.c                           | 655 ++++++++++++---------
 drivers/acpi/apei/hest.c                           |  16 +-
 drivers/acpi/bus.c                                 |  14 +
 drivers/acpi/custom_method.c                       |   6 -
 drivers/acpi/dptf/Makefile                         |   2 -
 drivers/acpi/dptf/int340x_thermal.c                |   2 +-
 drivers/acpi/ec.c                                  | 208 ++++---
 drivers/acpi/ec_sys.c                              |  36 +-
 drivers/acpi/internal.h                            |   4 +-
 drivers/acpi/irq.c                                 |   4 +-
 drivers/acpi/pci_link.c                            |   8 +-
 drivers/acpi/pptt.c                                |  13 +-
 drivers/acpi/resource.c                            |   4 +-
 drivers/acpi/tables.c                              |  12 +-
 drivers/acpi/x86/utils.c                           |   5 +
 drivers/firmware/arm_sdei.c                        |  68 +++
 drivers/firmware/efi/cper.c                        |  13 +-
 drivers/gpio/gpiolib-acpi.c                        |   2 +-
 drivers/platform/x86/sony-laptop.c                 |   8 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  14 +-
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   4 +-
 include/acpi/acexcep.h                             |   5 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   4 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |  18 +-
 include/acpi/acrestyp.h                            |  16 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |  19 +-
 include/acpi/actbl2.h                              |  17 +-
 include/acpi/actbl3.h                              |  21 +-
 include/acpi/actypes.h                             |  14 +-
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/ghes.h                                |   4 +-
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |   2 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/acintel.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/linux/arm_sdei.h                           |   9 +
 include/linux/initrd.h                             |   3 +
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   2 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 virt/kvm/arm/mmu.c                                 |   4 +-
 227 files changed, 1437 insertions(+), 1321 deletions(-)
