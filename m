Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED33C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE33321905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127085;
	bh=EzglohVuzLXoyRNpzFeoAh6TQZ55ZRZOKWBKRfZXOq8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xRDZb0WHmKKn/+7aOKYvjeFlsYnBIoNMfUxb1p9fVQBT/QoW/nTNYkxn7uyyrOAG7
	 GC0ndAOXQi+ZBAVrM41+/P7asEUhMMCuD7UZNxOiePCov2ep6Zi9/OyNbCWgA7M1Kv
	 yE/DWoOa0wcaJnjzIZYXIAERkW0I+44eOGLurRcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbfDXRbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390561AbfDXRbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:17 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D7D2077C;
        Wed, 24 Apr 2019 17:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127076;
        bh=EzglohVuzLXoyRNpzFeoAh6TQZ55ZRZOKWBKRfZXOq8=;
        h=From:To:Cc:Subject:Date:From;
        b=WupahUB1+Qf+X9Snxyx3s0plmXfU++/+yK4xkrmXXnmA1D92dGvO7ctICLQoeTLqV
         FBC8HocpxzQk/T6iy7dEJeEO/QQLqllmvcKBHJCf+zhQZ98Si31y+a3fMQjmMTw188
         yaGWrFtptv52eArmOjd7FumXX4CAuHcr+tp4gMJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/96] 4.19.37-stable review
Date:   Wed, 24 Apr 2019 19:09:05 +0200
Message-Id: <20190424170919.829037226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.37-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.37-rc1
X-KernelTest-Deadline: 2019-04-26T17:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.37 release.
There are 96 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 26 Apr 2019 05:07:35 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.37-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.37-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    ASoC: rockchip: add missing INTERLEAVED PCM attribute

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

Yue Haibing <yuehaibing@huawei.com>
    tpm: Fix the type of the return value in calc_tpm2_event_size()

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

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Avoid stale ARS results

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Allow root to busy-poll the ARS state machine

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Introduce scrub_flags

Dan Williams <dan.j.williams@intel.com>
    nfit/ars: Remove ars_start_flags

Chang-An Chen <chang-an.chen@mediatek.com>
    timers/sched_clock: Prevent generic sched_clock wrap caused by tick_freeze()

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Prevent deadlock on ssb_state::lock

Kan Liang <kan.liang@linux.intel.com>
    perf/x86: Fix incorrect PEBS_REGS

Andi Kleen <ak@linux.intel.com>
    x86/cpu/bugs: Use __initconst for 'const' init data

Kim Phillips <kim.phillips@amd.com>
    perf/x86/amd: Add event map for AMD Family 17h

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming

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

Christian König <christian.koenig@amd.com>
    drm/ttm: fix out-of-bounds read in ttm_put_pages() v2

Eric Biggers <ebiggers@google.com>
    crypto: x86/poly1305 - fix overflow during partial reduction

Corey Minyard <cminyard@mvista.com>
    ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier

Andrea Arcangeli <aarcange@redhat.com>
    coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping

Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>
    Revert "svm: Fix AVIC incomplete IPI emulation"

Saurav Kashyap <skashyap@marvell.com>
    Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Jaesoo Lee <jalee@purestorage.com>
    scsi: core: set result when the command cannot be dispatched

Mikulas Patocka <mpatocka@redhat.com>
    vt: fix cursor when clearing the screen

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix HSCIF RX sampling point calculation

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix HSCIF RX sampling point adjustment

KT Liao <kt.liao@emc.com.tw>
    Input: elan_i2c - add hardware ID for multiple Lenovo laptops

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

Christian Gromm <christian.gromm@microchip.com>
    staging: most: core: use device description as name

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
    iio:chemical:bme680: Fix SPI read interface

Mike Looijmans <mike.looijmans@topic.nl>
    iio:chemical:bme680: Fix, report temperature in millidegrees

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

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix handle leak in smb2_query_symlink()

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    cifs: Fix use-after-free in SMB2_read

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    cifs: Fix use-after-free in SMB2_write

Aurelien Aptel <aaptel@suse.com>
    CIFS: keep FileInfo handle live during oplock break

Peter Oskolkov <posk@google.com>
    net: IP6 defrag: use rbtrees in nf_conntrack_reasm.c

Peter Oskolkov <posk@google.com>
    net: IP6 defrag: use rbtrees for IPv6 defrag

Peter Oskolkov <posk@google.com>
    net: IP defrag: encapsulate rbtree defrag code into callable functions

Toke Høiland-Jørgensen <toke@redhat.com>
    sch_cake: Simplify logic in cake_select_tin()

Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
    nfp: flower: remove vlan CFI bit from push vlan action

Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
    nfp: flower: replace CFI with vlan present

Toke Høiland-Jørgensen <toke@redhat.com>
    sch_cake: Make sure we can write the IP header before changing DSCP bits

Toke Høiland-Jørgensen <toke@redhat.com>
    sch_cake: Use tc_skb_protocol() helper for getting packet protocol

Jonathan Lemon <jonathan.lemon@gmail.com>
    route: Avoid crash from dereferencing NULL rt->from

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: FPGA, tls, idr remove on flow delete

Jakub Kicinski <jakub.kicinski@netronome.com>
    net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx5: FPGA, tls, hold rcu read lock a bit longer

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

Hoang Le <hoang.h.le@dektech.com.au>
    tipc: missing entries in name table of publications

Hangbin Liu <liuhangbin@gmail.com>
    team: set slave to promisc if team is already in promisc mode

Eric Dumazet <edumazet@google.com>
    tcp: tcp_grow_window() needs to respect tcp_space()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv

Yuya Kusakabe <yuya.kusakabe@gmail.com>
    net: Fix missing meta data in skb with vlan packet

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: multicast: use rcu to access port list from br_multicast_start_querier

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: fix per-port af_packet sockets

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1 vulnerabilities

Si-Wei Liu <si-wei.liu@oracle.com>
    failover: allow name change on IFF_UP slave interfaces

Sabrina Dubroca <sd@queasysnail.net>
    bonding: fix event handling for stacked bonds


-------------

Diffstat:

 Makefile                                           |   7 +-
 arch/arm64/include/asm/futex.h                     |   2 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S             |  14 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S             |  22 +-
 arch/x86/events/amd/core.c                         |  35 ++-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/perf_event.h                       |  38 +--
 arch/x86/kernel/cpu/bugs.c                         |   6 +-
 arch/x86/kernel/kprobes/core.c                     |  26 ++
 arch/x86/kernel/process.c                          |   8 +-
 arch/x86/kvm/emulate.c                             |  21 +-
 arch/x86/kvm/svm.c                                 |  22 +-
 crypto/testmgr.h                                   |  44 ++-
 drivers/acpi/nfit/core.c                           |  63 +++--
 drivers/acpi/nfit/nfit.h                           |  11 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  19 +-
 drivers/char/tpm/eventlog/tpm2.c                   |   4 +-
 drivers/char/tpm/tpm_i2c_atmel.c                   |   4 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   1 +
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |   5 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |   3 +-
 drivers/iio/accel/kxcjk-1013.c                     |   2 +
 drivers/iio/adc/ad_sigma_delta.c                   |   1 +
 drivers/iio/adc/at91_adc.c                         |  28 +-
 drivers/iio/chemical/bme680.h                      |   6 +-
 drivers/iio/chemical/bme680_core.c                 |  54 +++-
 drivers/iio/chemical/bme680_i2c.c                  |  21 --
 drivers/iio/chemical/bme680_spi.c                  | 115 +++++---
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   7 +-
 drivers/iio/dac/mcp4725.c                          |   1 +
 drivers/iio/gyro/bmg160_core.c                     |   6 +-
 drivers/iio/gyro/mpu3050-core.c                    |   8 +-
 drivers/iio/industrialio-buffer.c                  |   5 +-
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/input/mouse/elan_i2c_core.c                |  25 ++
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  12 +-
 drivers/mmc/host/sdhci.c                           |  79 ++++--
 drivers/mmc/host/sdhci.h                           |  11 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  22 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c |  61 ++---
 drivers/net/ethernet/netronome/nfp/flower/action.c |   3 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h   |   3 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c  |  14 +-
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
 drivers/staging/most/core.c                        |   2 +-
 drivers/tty/serial/sh-sci.c                        |   6 +-
 drivers/tty/vt/vt.c                                |   3 +-
 drivers/vhost/vhost.c                              |   6 +-
 fs/cifs/cifsglob.h                                 |   2 +
 fs/cifs/file.c                                     |  30 +-
 fs/cifs/misc.c                                     |  25 +-
 fs/cifs/smb2misc.c                                 |   6 +-
 fs/cifs/smb2ops.c                                  |   2 +
 fs/cifs/smb2pdu.c                                  |   6 +-
 fs/proc/task_mmu.c                                 |  18 ++
 fs/userfaultfd.c                                   |   9 +
 include/linux/kprobes.h                            |   1 +
 include/linux/netdevice.h                          |   3 +
 include/linux/sched/mm.h                           |  21 ++
 include/net/inet_frag.h                            |  16 +-
 include/net/ipv6_frag.h                            |  11 +-
 include/net/tls.h                                  |   2 +-
 kernel/kprobes.c                                   |   6 +-
 kernel/sched/fair.c                                |  25 ++
 kernel/time/sched_clock.c                          |   4 +-
 kernel/time/tick-common.c                          |   2 +
 kernel/time/timekeeping.h                          |   7 +
 kernel/trace/ftrace.c                              |   6 +-
 mm/mmap.c                                          |   7 +-
 mm/percpu.c                                        |   8 +-
 mm/vmstat.c                                        |   5 -
 net/atm/lec.c                                      |   6 +-
 net/bridge/br_input.c                              |  23 +-
 net/bridge/br_multicast.c                          |   4 +-
 net/core/dev.c                                     |  16 +-
 net/core/failover.c                                |   6 +-
 net/core/skbuff.c                                  |  10 +-
 net/ipv4/fou.c                                     |   4 +-
 net/ipv4/inet_fragment.c                           | 293 ++++++++++++++++++++
 net/ipv4/ip_fragment.c                             | 302 +++------------------
 net/ipv4/route.c                                   |  16 +-
 net/ipv4/tcp_input.c                               |  10 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            | 260 +++++-------------
 net/ipv6/reassembly.c                              | 240 +++++-----------
 net/ipv6/route.c                                   |   4 +
 net/mac80211/driver-ops.h                          |   3 +
 net/sched/sch_cake.c                               |  57 ++--
 net/tipc/name_table.c                              |   3 +-
 scripts/mod/file2alias.c                           | 149 ++++------
 security/device_cgroup.c                           |   2 +-
 sound/core/info.c                                  |  12 +-
 sound/core/init.c                                  |  18 +-
 sound/pci/hda/patch_realtek.c                      |   6 +
 sound/soc/rockchip/rockchip_pcm.c                  |   3 +-
 tools/include/linux/bitops.h                       |   7 +-
 tools/include/linux/bits.h                         |  26 ++
 tools/perf/check-headers.sh                        |   1 +
 107 files changed, 1506 insertions(+), 1152 deletions(-)


