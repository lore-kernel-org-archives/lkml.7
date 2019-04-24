Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5442E21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126760;
	bh=E2zx05YuAsf3DRAUt6D14v6fPbhOEodyXqBXgOKD6Oc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xjj/QUuRWDsxs2vgQkjKZmrY7OkhxuVcj5vxJWmmARg0tprcxgXUUQ60hOF1EF+BM
	 HH0JohKzjifwfCrcBztx4VjhHvYjDJL9fUVDeqwRxXmAMyG5j8Ia04MUMNCGcsC9J/
	 8tIbxh4fC715YNOj50Z3GvQqByJ68Bkii9z2yuEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbfDXRZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390123AbfDXRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:55 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 384E62054F;
        Wed, 24 Apr 2019 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126754;
        bh=E2zx05YuAsf3DRAUt6D14v6fPbhOEodyXqBXgOKD6Oc=;
        h=From:To:Cc:Subject:Date:From;
        b=K7V9ftKfhTsK4n/At6V8P94bhTEjXWVYxGykD0RAtnYIWofQ/ugjbtuO2NVUMqwf0
         FITjL4tW05/VFve3qtoEj2F2tXQfNaeoHJYFFobLU5L2xi49qDetAnR63jmN8FrIKe
         MXyxPKqQHHdMFKHZ7H55JI4mV8/IuOYrrJkz7+hY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/44] 4.9.171-stable review
Date:   Wed, 24 Apr 2019 19:09:38 +0200
Message-Id: <20190424170839.924291114@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.171-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.171-rc1
X-KernelTest-Deadline: 2019-04-26T17:09+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.171 release.
There are 44 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 26 Apr 2019 05:07:31 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.171-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.171-rc1

Linus Torvalds <torvalds@linux-foundation.org>
    i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array

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

Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>
    Revert "svm: Fix AVIC incomplete IPI emulation"

Saurav Kashyap <skashyap@marvell.com>
    Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Takashi Iwai <tiwai@suse.de>
    ALSA: core: Fix card races between register and disconnect

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

Georg Ottinger <g.ottinger@abatec.at>
    iio: adc: at91: disable adc channel interrupt in timeout case

Dragos Bogdan <dragos.bogdan@analog.com>
    iio: ad_sigma_delta: select channel when reading register

Mike Looijmans <mike.looijmans@topic.nl>
    iio/gyro/bmg160: Use millidegrees for temperature scale

Mircea Caprioru <mircea.caprioru@analog.com>
    staging: iio: ad7192: Fix ad7193 channel address

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Aurelien Aptel <aaptel@suse.com>
    CIFS: keep FileInfo handle live during oplock break

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: check prototype of handler

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: go back to simple devtable lookup

Adrian Hunter <adrian.hunter@intel.com>
    mmc: sdhci: Fix data command CRC error handling

Christian Lamparter <chunkeey@gmail.com>
    crypto: crypto4xx - properly set IV after de- and encrypt

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

 Makefile                                         |   7 +-
 arch/arm64/include/asm/futex.h                   |   2 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S           |  14 ++-
 arch/x86/crypto/poly1305-sse2-x86_64.S           |  22 ++--
 arch/x86/events/amd/core.c                       |  35 ++++--
 arch/x86/kernel/kprobes/core.c                   |  26 +++++
 arch/x86/kvm/emulate.c                           |  21 ++--
 arch/x86/kvm/svm.c                               |  19 ++-
 crypto/testmgr.h                                 |  44 ++++++-
 drivers/char/tpm/tpm_i2c_atmel.c                 |  10 +-
 drivers/crypto/amcc/crypto4xx_alg.c              |   3 +-
 drivers/crypto/amcc/crypto4xx_core.c             |   9 ++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c         |   3 +-
 drivers/iio/accel/kxcjk-1013.c                   |   2 +
 drivers/iio/adc/ad_sigma_delta.c                 |   1 +
 drivers/iio/adc/at91_adc.c                       |  28 +++--
 drivers/iio/gyro/bmg160_core.c                   |   6 +-
 drivers/mmc/host/sdhci.c                         |  40 +++----
 drivers/net/bonding/bond_main.c                  |   6 +-
 drivers/net/team/team.c                          |  26 +++++
 drivers/net/wireless/ralink/rt2x00/rt2x00.h      |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c   |  10 --
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c |  15 ++-
 drivers/scsi/libfc/fc_rport.c                    |   1 -
 drivers/staging/comedi/drivers/ni_usb6501.c      |  10 +-
 drivers/staging/comedi/drivers/vmk80xx.c         |   8 +-
 drivers/staging/iio/adc/ad7192.c                 |   8 +-
 drivers/vhost/vhost.c                            |   6 +-
 fs/cifs/cifsglob.h                               |   2 +
 fs/cifs/file.c                                   |  30 ++++-
 fs/cifs/misc.c                                   |  25 +++-
 fs/cifs/smb2misc.c                               |   6 +-
 include/linux/kprobes.h                          |   1 +
 kernel/kprobes.c                                 |   6 +-
 kernel/sched/fair.c                              |  25 ++++
 kernel/trace/ftrace.c                            |   6 +-
 mm/percpu.c                                      |   8 +-
 mm/vmstat.c                                      |   5 -
 net/atm/lec.c                                    |   6 +-
 net/bridge/br_input.c                            |  23 ++--
 net/bridge/br_multicast.c                        |   4 +-
 net/ipv4/fou.c                                   |   4 +-
 net/ipv4/route.c                                 |  16 ++-
 net/ipv4/tcp_input.c                             |  10 +-
 net/mac80211/driver-ops.h                        |   3 +
 scripts/mod/file2alias.c                         | 141 ++++++++---------------
 security/device_cgroup.c                         |   2 +-
 sound/core/info.c                                |  12 +-
 sound/core/init.c                                |  18 +--
 49 files changed, 470 insertions(+), 266 deletions(-)


