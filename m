Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243ECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50582089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128422;
	bh=9NtTVWB7/30uSLuozEDaHMhxgqkK9L3IBxfJrerwbno=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JE60PpRYD6bkKrv3ViQ6Fr+vZessHQgk7BCMQDAVecxR34KY4ryn2EKZjJNqEN0J+
	 TUzJsabqSZlo31Wkn2PCkOHvNRKP56CHQ21tX2uy8KTI3Yfj5y15AkkkY7xlQO5SG/
	 +N5n/kWbCpO6yuQlgMkBbODfOktW7z8hfHNhndko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390297AbfDXRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390252AbfDXR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:05 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8331E206BA;
        Wed, 24 Apr 2019 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126824;
        bh=9NtTVWB7/30uSLuozEDaHMhxgqkK9L3IBxfJrerwbno=;
        h=From:To:Cc:Subject:Date:From;
        b=fu/KuTwDRyz5RUVJ+mFA0IFVSJj6O8A6EZK8q8qzsXmdAv15Ehh3ex3xKRhd36+2e
         sHgqbB59vEsc7iB7GfuDaxT8LRo5GyJhbWd0jMxYerAVjbkGderK1tx+JNAuCmbH03
         eBLChoOAN/04R7KPYOJbDCdTgTJmPkknM27eskEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/70] 4.14.114-stable review
Date:   Wed, 24 Apr 2019 19:09:20 +0200
Message-Id: <20190424170906.751869122@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.114-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.114-rc1
X-KernelTest-Deadline: 2019-04-26T17:09+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.114 release.
There are 70 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 26 Apr 2019 05:07:32 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.114-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.114-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: hold xfs_buf locked between shortform->leaf conversion and the addition of an attribute

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: add the ability to join a held buffer to a defer_ops

Darrick J. Wong <darrick.wong@oracle.com>
    iomap: report collisions between directio and buffered writes to userspace

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt linux/bits.h

Matteo Croce <mcroce@redhat.com>
    percpu: stop printing kernel addresses

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix racy addition/deletion of nodes

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n

Jann Horn <jannh@google.com>
    device_cgroup: fix RCU imbalance in error case

Phil Auld <pauld@redhat.com>
    sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Matthias Kaehlcke <mka@chromium.org>
    Revert "kbuild: use -Oz instead of -Os when using clang"

Peter Oskolkov <posk@google.com>
    net: IP6 defrag: use rbtrees in nf_conntrack_reasm.c

Peter Oskolkov <posk@google.com>
    net: IP6 defrag: use rbtrees for IPv6 defrag

Florian Westphal <fw@strlen.de>
    ipv6: remove dependency of nf_defrag_ipv6 on ipv6 module

Peter Oskolkov <posk@google.com>
    net: IP defrag: encapsulate rbtree defrag code into callable functions

Eric Dumazet <edumazet@google.com>
    ipv6: frags: fix a lockdep false positive

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: check prototype of handler

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: go back to simple devtable lookup

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci: Handle auto-command errors

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci: Fix data command CRC error handling

Christian Lamparter <chunkeey@gmail.com>
    crypto: crypto4xx - properly set IV after de- and encrypt

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Prevent deadlock on ssb_state::lock

Kan Liang <kan.liang@linux.intel.com>
    perf/x86: Fix incorrect PEBS_REGS

Andi Kleen <ak@linux.intel.com>
    x86/cpu/bugs: Use __initconst for 'const' init data

Kim Phillips <kim.phillips@amd.com>
    perf/x86/amd: Add event map for AMD Family 17h

Felix Fietkau <nbd@nbd.name>
    mac80211: do not call driver wake_tx_queue op during reconfig

Vijayakumar Durai <vijayakumar.durai1@vivint.com>
    rt2x00: do not increment sequence number while re-transmitting

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Fix error check when reusing optimized probes

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Mark ftrace mcount handler functions nokprobe

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Verify stack frame on kretprobe

Nathan Chancellor <natechancellor@gmail.com>
    arm64: futex: Restore oldval initialization to work around buggy compilers

Eric Biggers <ebiggers@google.com>
    crypto: x86/poly1305 - fix overflow during partial reduction

Andrea Arcangeli <aarcange@redhat.com>
    coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping

Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>
    Revert "svm: Fix AVIC incomplete IPI emulation"

Saurav Kashyap <skashyap@marvell.com>
    Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Jaesoo Lee <jalee@purestorage.com>
    scsi: core: set result when the command cannot be dispatched

Takashi Iwai <tiwai@suse.de>
    ALSA: core: Fix card races between register and disconnect

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - add two more pin configuration sets to quirk table

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_usb6501: Fix use of uninitialized mutex

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix use of uninitialized semaphore

he, bo <bo.he@intel.com>
    io: accel: kxcjk1013: restore the range after resume.

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: core: fix a possible circular locking dependency

Georg Ottinger <g.ottinger@abatec.at>
    iio: adc: at91: disable adc channel interrupt in timeout case

Lars-Peter Clausen <lars@metafoo.de>
    iio: Fix scan mask selection

Jean-Francois Dagenais <jeff.dagenais@gmail.com>
    iio: dac: mcp4725: add missing powerdown bits in store eeprom

Dragos Bogdan <dragos.bogdan@analog.com>
    iio: ad_sigma_delta: select channel when reading register

Gwendal Grignou <gwendal@chromium.org>
    iio: cros_ec: Fix the maths for gyro scale calculation

Mike Looijmans <mike.looijmans@topic.nl>
    iio/gyro/bmg160: Use millidegrees for temperature scale

Sergey Larin <cerg2010cerg2010@mail.ru>
    iio: gyro: mpu3050: fix chip ID reading

Mircea Caprioru <mircea.caprioru@analog.com>
    staging: iio: ad7192: Fix ad7193 channel address

Leonard Pollak <leonardp@tr-host.de>
    Staging: iio: meter: fixed typo

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: x86: svm: make sure NMI is injected after nmi_singlestep

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Aurelien Aptel <aaptel@suse.com>
    CIFS: keep FileInfo handle live during oplock break

Matteo Croce <mcroce@redhat.com>
    net: thunderx: don't allow jumbo frames with XDP

Matteo Croce <mcroce@redhat.com>
    net: thunderx: raise XDP MTU to 1508

Eric Dumazet <edumazet@google.com>
    ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Stephen Suryaputra <ssuryaextr@gmail.com>
    ipv4: recompile ip options in ipv4_link_failure

Jason Wang <jasowang@redhat.com>
    vhost: reject zero size iova range

Hangbin Liu <liuhangbin@gmail.com>
    team: set slave to promisc if team is already in promisc mode

Eric Dumazet <edumazet@google.com>
    tcp: tcp_grow_window() needs to respect tcp_space()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: multicast: use rcu to access port list from br_multicast_start_querier

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fix per-port af_packet sockets

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1 vulnerabilities

Sabrina Dubroca <sd@queasysnail.net>
    bonding: fix event handling for stacked bonds


-------------

Diffstat:

 Makefile                                           |   7 +-
 arch/arm64/include/asm/futex.h                     |   2 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S             |  14 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S             |  22 +-
 arch/x86/events/amd/core.c                         |  35 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/perf_event.h                       |  38 +--
 arch/x86/kernel/cpu/bugs.c                         |   6 +-
 arch/x86/kernel/kprobes/core.c                     |  26 ++
 arch/x86/kernel/process.c                          |   6 +-
 arch/x86/kvm/emulate.c                             |  21 +-
 arch/x86/kvm/svm.c                                 |  22 +-
 crypto/testmgr.h                                   |  44 ++-
 drivers/char/tpm/tpm_i2c_atmel.c                   |   4 +
 drivers/crypto/amcc/crypto4xx_alg.c                |   3 +-
 drivers/crypto/amcc/crypto4xx_core.c               |   9 +
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |   3 +-
 drivers/iio/accel/kxcjk-1013.c                     |   2 +
 drivers/iio/adc/ad_sigma_delta.c                   |   1 +
 drivers/iio/adc/at91_adc.c                         |  28 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   7 +-
 drivers/iio/dac/mcp4725.c                          |   1 +
 drivers/iio/gyro/bmg160_core.c                     |   6 +-
 drivers/iio/gyro/mpu3050-core.c                    |   8 +-
 drivers/iio/industrialio-buffer.c                  |   5 +-
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  12 +-
 drivers/mmc/host/sdhci.c                           |  79 +++--
 drivers/mmc/host/sdhci.h                           |  11 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  22 +-
 drivers/net/team/team.c                            |  26 ++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  10 -
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |  15 +-
 drivers/scsi/libfc/fc_rport.c                      |   1 -
 drivers/scsi/scsi_lib.c                            |   6 +-
 drivers/staging/comedi/drivers/ni_usb6501.c        |  10 +-
 drivers/staging/comedi/drivers/vmk80xx.c           |   8 +-
 drivers/staging/iio/adc/ad7192.c                   |   8 +-
 drivers/staging/iio/meter/ade7854.c                |   2 +-
 drivers/vhost/vhost.c                              |   6 +-
 fs/cifs/cifsglob.h                                 |   2 +
 fs/cifs/file.c                                     |  30 +-
 fs/cifs/misc.c                                     |  25 +-
 fs/cifs/smb2misc.c                                 |   6 +-
 fs/direct-io.c                                     |  24 +-
 fs/iomap.c                                         |  12 +-
 fs/proc/task_mmu.c                                 |  18 +
 fs/userfaultfd.c                                   |   9 +
 fs/xfs/libxfs/xfs_attr.c                           |  20 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |   9 +-
 fs/xfs/libxfs/xfs_attr_leaf.h                      |   3 +-
 fs/xfs/libxfs/xfs_defer.c                          |  39 ++-
 fs/xfs/libxfs/xfs_defer.h                          |   5 +-
 include/linux/fs.h                                 |   1 +
 include/linux/kprobes.h                            |   1 +
 include/linux/sched/mm.h                           |  21 ++
 include/net/inet_frag.h                            |  16 +-
 include/net/ipv6.h                                 |  29 --
 include/net/ipv6_frag.h                            | 111 +++++++
 kernel/kprobes.c                                   |   6 +-
 kernel/sched/fair.c                                |  25 ++
 kernel/trace/ftrace.c                              |   6 +-
 mm/mmap.c                                          |   7 +-
 mm/percpu.c                                        |   8 +-
 mm/vmstat.c                                        |   5 -
 net/atm/lec.c                                      |   6 +-
 net/bridge/br_input.c                              |  23 +-
 net/bridge/br_multicast.c                          |   4 +-
 net/ieee802154/6lowpan/reassembly.c                |   2 +-
 net/ipv4/fou.c                                     |   4 +-
 net/ipv4/inet_fragment.c                           | 293 +++++++++++++++++
 net/ipv4/ip_fragment.c                             | 302 ++---------------
 net/ipv4/route.c                                   |  16 +-
 net/ipv4/tcp_input.c                               |  10 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            | 279 +++++-----------
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c          |   3 +-
 net/ipv6/reassembly.c                              | 364 +++++----------------
 net/mac80211/driver-ops.h                          |   3 +
 net/openvswitch/conntrack.c                        |   1 +
 scripts/mod/file2alias.c                           | 141 +++-----
 security/device_cgroup.c                           |   2 +-
 sound/core/info.c                                  |  12 +-
 sound/core/init.c                                  |  18 +-
 sound/pci/hda/patch_realtek.c                      |   6 +
 tools/include/linux/bitops.h                       |   7 +-
 tools/include/linux/bits.h                         |  26 ++
 tools/perf/check-headers.sh                        |   1 +
 89 files changed, 1399 insertions(+), 1111 deletions(-)


