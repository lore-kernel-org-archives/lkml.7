Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B9BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360F62054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251958;
	bh=pyG5FIZ4IXq7SmyfmurUlrCO1efstdnML0d4c07Z6w4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VMCqVfYunNBjvsiBuNlPBkPSVaJKkiXdyytTyR0dgv8+AbktdDGUoZIIUY/7fZpVL
	 S9MF4H5sX3ef128oZGI3CoCrsML6qIb6X/0WqnG8l8sYSCgKwzE4zCqL6AdnuegOkp
	 +qqzawWXDimen+efkDa0dFqRhL+VgiIpSWiz4VIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfEGR7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfEGR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:59:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DEF82054F;
        Tue,  7 May 2019 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251955;
        bh=pyG5FIZ4IXq7SmyfmurUlrCO1efstdnML0d4c07Z6w4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZQPgxhCXpD7dbokAu04BQW5e7Lf8u6BYoGosIMfWpieyagDF6XEADKU2y7y2SF8hn
         ykbMwA4ztJljyDPspQtsNoX9hpuNVw6Rt3lYiJJXVSHoNYxQlHTCR7/wtQ27cib+uy
         1N1UGybmEXP/SRCYQgtYdv2ViYMG+rCNkkgsR580=
Date:   Tue, 7 May 2019 19:59:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 5.2-rc1
Message-ID: <20190507175912.GA11709@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.2-rc1

for you to fetch changes up to 70e16a620e075cb916644e06012766639b58b2fb:

  kobject: clean up the kobject add documentation a bit more (2019-05-03 08:26:51 +0200)

----------------------------------------------------------------
Driver core/kobject patches for 5.2-rc1

Here is the "big" set of driver core patches for 5.2-rc1

There are a number of ACPI patches in here as well, as Rafael said they
should go through this tree due to the driver core changes they
required.  They have all been acked by the ACPI developers.

There are also a number of small subsystem-specific changes in here, due
to some changes to the kobject core code.  Those too have all been acked
by the various subsystem maintainers.

As for content, it's pretty boring outside of the ACPI changes:
  - spdx cleanups
  - kobject documentation updates
  - default attribute groups for kobjects
  - other minor kobject/driver core fixes

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alison Schofield (1):
      acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY

Andrea Parri (1):
      kernfs: fix barrier usage in __kernfs_new_node()

Andy Shevchenko (1):
      driver core: platform: Propagate error from insert_resource()

Bartosz Golaszewski (1):
      drivers: fix a typo in the kernel doc for devm_platform_ioremap_resource()

Borislav Petkov (1):
      driver core: Clarify which counterparts to use to device_add()

Christina Quast (1):
      fs: kernfs: Corrected spelling mistake

Colin Ian King (1):
      kobject: fix dereference before null check on kobj

Geert Uytterhoeven (1):
      driver: base: Disable CONFIG_UEVENT_HELPER by default

Greg Kroah-Hartman (6):
      device.h: reorganize struct device
      drivers: base: test: add proper SPDX identifier to Makefile
      drivers: base: firmware_loader: add proper SPDX identifiers on files that did not have them.
      drivers: base: power: add proper SPDX identifiers on files that did not have them.
      Revert "driver core: platform: Fix the usage of platform device name(pdev->name)"
      kobject: clean up the kobject add documentation a bit more

Joel Fernandes (Google) (2):
      Provide in-kernel headers to make extending kernel easier
      init/config: Do not select BUILD_BIN2C for IKCONFIG

John Garry (1):
      driver core: Postpone DMA tear-down until after devres release for probe failure

Jonathan Neuschäfer (1):
      firmware_loader: Fix a typo ("syfs" -> "sysfs")

Keith Busch (10):
      acpi: Create subtable parsing infrastructure
      acpi: Add HMAT to generic parsing tables
      acpi/hmat: Parse and report heterogeneous memory
      node: Link memory nodes to their compute nodes
      node: Add heterogenous memory access attributes
      node: Add memory-side caching attributes
      acpi/hmat: Register processor domain to its memory
      acpi/hmat: Register performance attributes
      acpi/hmat: Register memory side cache attributes
      doc/mm: New documentation for memory performance

Kimberly Brown (8):
      kobject: Add support for default attribute groups to kobj_type
      samples/kobject: Replace foo_ktype's default_attrs field with groups
      block: Replace all ktype default_attrs with groups
      net-sysfs: Replace ktype default_attrs field with groups
      irqdesc: Replace irq_kobj_type's default_attrs field with groups
      padata: Replace padata_attr_type default_attrs field with groups
      cpufreq: schedutil: Replace default_attrs field with groups
      livepatch: Replace klp_ktype_patch's default_attrs with groups

Lingutla Chandrasekhar (1):
      arch_topology: Make cpu_capacity sysfs node as read-only

Qian Cai (2):
      acpi/hmat: fix memory leaks in hmat_init()
      acpi/hmat: fix an uninitialized memory_target

Ronald Tschalär (1):
      debugfs: update documented return values of debugfs helpers

Tetsuo Handa (1):
      kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.

Tobin C. Harding (4):
      kobject: Improve docs for kobject_add/del
      kobject: Improve doc clarity kobject_init_and_add()
      kobject: Remove docstring reference to kset
      kobject: Fix kernel-doc comment first line

Venkata Narendra Kumar Gutta (1):
      driver core: platform: Fix the usage of platform device name(pdev->name)

zhong jiang (1):
      mm/memory_hotplug: Do not unlock when fails to take the device_hotplug_lock

 Documentation/ABI/stable/sysfs-devices-node     |  87 +++-
 Documentation/admin-guide/mm/numaperf.rst       | 169 ++++++
 Documentation/filesystems/debugfs.txt           |  16 +-
 arch/arm64/kernel/acpi_numa.c                   |   2 +-
 arch/arm64/kernel/smp.c                         |   4 +-
 arch/ia64/kernel/acpi.c                         |  14 +-
 arch/x86/kernel/acpi/boot.c                     |  36 +-
 block/blk-integrity.c                           |   3 +-
 block/blk-mq-sysfs.c                            |   8 +-
 block/blk-sysfs.c                               |   3 +-
 drivers/acpi/Kconfig                            |   1 +
 drivers/acpi/Makefile                           |   1 +
 drivers/acpi/hmat/Kconfig                       |  11 +
 drivers/acpi/hmat/Makefile                      |   1 +
 drivers/acpi/hmat/hmat.c                        | 666 ++++++++++++++++++++++++
 drivers/acpi/numa.c                             |  16 +-
 drivers/acpi/scan.c                             |   4 +-
 drivers/acpi/tables.c                           |  76 ++-
 drivers/base/Kconfig                            |   9 +-
 drivers/base/arch_topology.c                    |  36 +-
 drivers/base/core.c                             |   5 +
 drivers/base/dd.c                               |   5 +-
 drivers/base/firmware_loader/Kconfig            |   1 +
 drivers/base/firmware_loader/builtin/.gitignore |   1 +
 drivers/base/firmware_loader/fallback.c         |   6 +-
 drivers/base/memory.c                           |   2 +-
 drivers/base/node.c                             | 352 ++++++++++++-
 drivers/base/platform.c                         |  12 +-
 drivers/base/power/clock_ops.c                  |   3 +-
 drivers/base/power/common.c                     |   4 +-
 drivers/base/power/domain.c                     |   4 +-
 drivers/base/power/domain_governor.c            |   4 +-
 drivers/base/power/generic_ops.c                |   4 +-
 drivers/base/power/main.c                       |   4 +-
 drivers/base/power/qos.c                        |   6 +-
 drivers/base/power/runtime.c                    |   4 +-
 drivers/base/power/sysfs.c                      |   6 +-
 drivers/base/power/trace.c                      |   2 +-
 drivers/base/power/wakeirq.c                    |  15 +-
 drivers/base/power/wakeup.c                     |   4 +-
 drivers/base/test/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                   |   2 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c        |   2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c   |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                |   6 +-
 drivers/irqchip/irq-gic-v3.c                    |  10 +-
 drivers/irqchip/irq-gic.c                       |   4 +-
 drivers/mailbox/pcc.c                           |   2 +-
 fs/debugfs/file.c                               |  77 ++-
 fs/kernfs/dir.c                                 |   5 +-
 include/acpi/actbl1.h                           |   2 +-
 include/linux/acpi.h                            |   6 +-
 include/linux/device.h                          |  16 +-
 include/linux/kernfs.h                          |   2 +-
 include/linux/kobject.h                         |   3 +-
 include/linux/node.h                            |  71 +++
 init/Kconfig                                    |  11 +-
 kernel/.gitignore                               |   1 +
 kernel/Makefile                                 |  10 +
 kernel/gen_ikh_data.sh                          |  89 ++++
 kernel/irq/irqdesc.c                            |   3 +-
 kernel/kheaders.c                               |  74 +++
 kernel/livepatch/core.c                         |   3 +-
 kernel/padata.c                                 |   3 +-
 kernel/sched/cpufreq_schedutil.c                |   5 +-
 lib/kobject.c                                   |  93 ++--
 lib/kobject_uevent.c                            |  11 +-
 net/core/net-sysfs.c                            |   6 +-
 samples/kobject/kset-example.c                  |   3 +-
 69 files changed, 1855 insertions(+), 275 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/numaperf.rst
 create mode 100644 drivers/acpi/hmat/Kconfig
 create mode 100644 drivers/acpi/hmat/Makefile
 create mode 100644 drivers/acpi/hmat/hmat.c
 create mode 100755 kernel/gen_ikh_data.sh
 create mode 100644 kernel/kheaders.c
