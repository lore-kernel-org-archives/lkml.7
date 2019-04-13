Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17826C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B5F2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555115442;
	bh=fAtvgvDd3j3zHaN26HBF+ShtqqH+fa1OP8ecdv1x/24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wjDhcjQmGBZ5rpbwzGzWF2h3WxKAsAuwEfrCj6Yq0HjrnFjdI5MLL7rX2erk5nYsE
	 JXC3cvlBMNEUsTK+LUvysBV+agAbl14cS+9myfwiPZoYvsVg9qdrjiL2iufjVQ/0wZ
	 gjAFyzhNGQFWj551WcWnOxxKVoGT8uxdw3WP0nKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDMAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:30:40 -0400
Received: from casper.infradead.org ([85.118.1.10]:51158 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDMAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K0jlWU+ztEkxyTeoeC0fCgCWfJiJqC3+tUNJnYZlucg=; b=RnBkxyloEREyqIY+VtGqoaSXIT
        sRWA9+6JqhWjzjJsXypxC4wLEw3MH7pzC7RoYe2ztvaXmgsmqPHDlH0LOj/xMP0k8ZSunYOC0qVTq
        EP/OIRsK0Jg2K30asCnYwRPZ2bAJ4GBmtzlYLEhnVURRM4L0Wh1B2Dh7fYzf2iL0CRtUVjUCEKUFk
        2tNSdVFOccEdya+yQcbYMV04+5AkUWYfpK7WOamUEkeEw8xabVAJfVJ3yNnsNN/1yGMvZx/kCTz+X
        HqVKuPDnQ2UULn3kRJWkVV96+7KqXNBQba5p22KDUO79yFf7De3qzizRjXWeva+lX0JzJTJ/jDkIp
        HUnQ/Mhw==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hF6Z0-0002TM-3M; Sat, 13 Apr 2019 00:30:35 +0000
Date:   Fri, 12 Apr 2019 21:30:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add all documentation files to an html/pdf
 produced book
Message-ID: <20190412213029.209c80b1@coco.lan>
In-Reply-To: <20190412062826.7681c803@coco.lan>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
        <20190408161820.6a12657f@lwn.net>
        <20190410064939.2a9dca9a@coco.lan>
        <20190411124904.12e61bc7@lwn.net>
        <20190412062826.7681c803@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 12 Apr 2019 06:28:26 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> > So I don't have any hard numbers, but my feeling is that this work is
> > continuing apace and perhaps even picking up.  Certainly I'm having a
> > harder time keeping up with it, even when you're busy with other things :)
> > These things take time; I'm not really ready to give up on it yet.  
> 
> Ok. I'm working on a series of patches converting stuff from some random
> subsystems. I should be sending the series soon.

Finished the conversion. I need to do double-check if everything is
ok and fix broken links, but if you want to take a sneak peak, it is
on my devel tree:

	https://git.linuxtv.org/mchehab/experimental.git/tree/?h=all_with_indexes

It got a way bigger than the past series:

 379 files changed, 22705 insertions(+), 17379 deletions(-)

As this time it is doing a ReST conversion instead of just adding
indexes for *.txt files.


Thanks,
Mauro

Mauro Carvalho Chehab (41):
      docs: acpi: convert text files to ReST
      Documentation/aoe: convert it to ReST output
      Documentation/arm64: convert documentation to ReST format
      Documentation/cdrom/cdrom-standard.tex: convert from LaTeX to ReST
      Documentation/cdrom: add plain text files to ReST output
      Documentation/cdrom: convert remaining files to ReST
      Documentation/cgroup-v1: add plain text files to ReST output
      docs: cgroup-v1/cgroups.txt: convert it to ReST file format
      Documentation/cpu-freq: convert files to ReST
      Documentation/device-mapper: convert it to ReST format
      docs: extcon: move it to acpi dir and convert it to ReST
      Documentation/fault-injection: convert it to ReST format
      Documentation/fb: convert documentation to ReST format
      Documentation/fpga: convert it to ReST
      Documentation/gpio: convert it to ReST
      Documentation/ide: convert it to ReST format
      Documentation/infiniband: convert it to ReST format
      Documentation/kbuild: convert it to ReST output
      Documentation/kdump: convert it to ReST
      Documentation/livepatch: convert it to ReST format
      Documentation/locking: convert docs to ReST format
      Documentation/mic: convert it to ReST format
      Documentation/netlabel: convert it to ReST
      Documentation/PCI: convert docs to ReST format
      Documentation/pcmcia: convert it to ReST format
      Documentation/power: convert docs to ReST
      Documentation/powerpc: convert docs to ReST
      Documentation/pps/pps.txt convert it to ReST and move to API book
      Documentation/ptp/ptp.txt: convert to ReST and move to driver-api
      Documentation/riscv: convert it to ReST format
      s390: include/asm/debug.h add kerneldoc markups
      s390: Debugging390.txt convert table to ascii artwork
      s390: docs: convert text files to ReST format
      s390: docs: s390dbf.rst: use kernel-doc markup
      Documentation/serial: convert it to ReST format
      Documentation/target: convert it to ReST format
      Documentation/timers: convert to ReST and add to the kernel API book
      Documentation/usb: convert documents to ReST
      Documentation/watchdog: convert documents to ReST format
      Documentation/x86: convert text files to ReST and add to arch book
      Documentation/xilinx: convert eemi.txt to ReST

 Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} |   56 +-
 .../PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}   |   57 +-
 Documentation/PCI/{acpi-info.txt => acpi-info.rst} |    9 +-
 .../PCI/endpoint/function/binding/pci-test.rst     |   24 +
 .../PCI/endpoint/function/binding/pci-test.txt     |   19 -
 .../{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} |   37 +-
 .../{pci-endpoint.txt => pci-endpoint.rst}         |  101 +-
 ...pci-test-function.txt => pci-test-function.rst} |   70 +-
 .../{pci-test-howto.txt => pci-test-howto.rst}     |   49 +-
 Documentation/PCI/index.rst                        |   28 +
 ...i-error-recovery.txt => pci-error-recovery.rst} |  201 +-
 .../PCI/{pci-iov-howto.txt => pci-iov-howto.rst}   |   88 +-
 Documentation/PCI/{pci.txt => pci.rst}             |  170 +-
 .../PCI/{pcieaer-howto.txt => pcieaer-howto.rst}   |  103 +-
 ...operties-rules.txt => DSD-properties-rules.rst} |    4 +-
 Documentation/acpi/{acpi-lid.txt => acpi-lid.rst}  |   37 +-
 .../acpi/{aml-debugger.txt => aml-debugger.rst}    |   31 +-
 Documentation/acpi/apei/{einj.txt => einj.rst}     |   59 +-
 Documentation/acpi/apei/output_format.rst          |  148 ++
 Documentation/acpi/apei/output_format.txt          |  147 --
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}        |   52 +-
 Documentation/acpi/{debug.txt => debug.rst}        |   20 +-
 .../drivers/extcon-intel-int3496.rst}              |   14 +-
 ...ode-references.txt => data-node-references.rst} |   11 +-
 Documentation/acpi/dsd/{graph.txt => graph.rst}    |   24 +-
 .../acpi/{dsdt-override.txt => dsdt-override.rst}  |    4 +-
 .../acpi/{enumeration.txt => enumeration.rst}      |   40 +-
 .../{gpio-properties.txt => gpio-properties.rst}   |   42 +-
 .../acpi/{i2c-muxes.txt => i2c-muxes.rst}          |   21 +-
 Documentation/acpi/index.rst                       |   41 +
 ...able_override.txt => initrd_table_override.rst} |   90 +-
 .../{linuxized-acpica.txt => linuxized-acpica.rst} |   58 +-
 Documentation/acpi/{lpit.txt => lpit.rst}          |    8 +-
 ...thod-customizing.txt => method-customizing.rst} |   48 +-
 .../{method-tracing.txt => method-tracing.rst}     |  132 +-
 .../acpi/{namespace.txt => namespace.rst}          |  327 +--
 Documentation/acpi/{osi.txt => osi.rst}            |    3 +-
 .../acpi/{scan_handlers.txt => scan_handlers.rst}  |    9 +-
 .../acpi/{ssdt-overlays.txt => ssdt-overlays.rst}  |  128 +-
 .../{video_extension.txt => video_extension.rst}   |   16 +-
 Documentation/aoe/{aoe.txt => aoe.rst}             |   65 +-
 Documentation/aoe/examples.rst                     |   24 +
 Documentation/aoe/index.rst                        |   17 +
 Documentation/aoe/{todo.txt => todo.rst}           |    3 +
 ...acpi_object_usage.txt => acpi_object_usage.rst} |  280 ++-
 Documentation/arm64/{arm-acpi.txt => arm-acpi.rst} |  161 +-
 Documentation/arm64/{booting.txt => booting.rst}   |   91 +-
 ...ure-registers.txt => cpu-feature-registers.rst} |  196 +-
 .../arm64/{elf_hwcaps.txt => elf_hwcaps.rst}       |   50 +-
 .../arm64/{hugetlbpage.txt => hugetlbpage.rst}     |    7 +-
 Documentation/arm64/index.rst                      |   26 +
 ...cy_instructions.txt => legacy_instructions.rst} |   43 +-
 Documentation/arm64/memory.rst                     |   98 +
 Documentation/arm64/memory.txt                     |   97 -
 ...thentication.txt => pointer-authentication.rst} |    2 +
 .../{silicon-errata.txt => silicon-errata.rst}     |   62 +-
 Documentation/arm64/{sve.txt => sve.rst}           |   10 +-
 .../{tagged-pointers.txt => tagged-pointers.rst}   |    6 +-
 Documentation/cdrom/Makefile                       |   21 -
 Documentation/cdrom/cdrom-standard.rst             | 1063 ++++++++
 Documentation/cdrom/cdrom-standard.tex             | 1026 --------
 Documentation/cdrom/{ide-cd => ide-cd.rst}         |  132 +-
 Documentation/cdrom/index.rst                      |   17 +
 .../{packet-writing.txt => packet-writing.rst}     |   27 +-
 .../cgroup-v1/{cgroups.txt => cgroups.rst}         |  182 +-
 Documentation/cgroup-v1/index.rst                  |   16 +
 Documentation/cgroup-v1/text_files.rst             |   72 +
 .../{amd-powernow.txt => amd-powernow.rst}         |    7 +
 Documentation/cpu-freq/{core.txt => core.rst}      |   66 +-
 .../cpu-freq/{cpu-drivers.txt => cpu-drivers.rst}  |  207 +-
 .../{cpufreq-nforce2.txt => cpufreq-nforce2.rst}   |    8 +-
 Documentation/cpu-freq/cpufreq-stats.rst           |  128 +
 Documentation/cpu-freq/cpufreq-stats.txt           |  127 -
 Documentation/cpu-freq/index.rst                   |   50 +
 Documentation/cpu-freq/index.txt                   |   56 -
 .../cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst}  |  102 +-
 .../{cache-policies.txt => cache-policies.rst}     |   24 +-
 .../device-mapper/{cache.txt => cache.rst}         |  214 +-
 .../device-mapper/{delay.txt => delay.rst}         |   29 +-
 .../device-mapper/{dm-crypt.txt => dm-crypt.rst}   |   61 +-
 .../device-mapper/{dm-flakey.txt => dm-flakey.rst} |   45 +-
 .../device-mapper/{dm-init.txt => dm-init.rst}     |   75 +-
 .../{dm-integrity.txt => dm-integrity.rst}         |   55 +-
 .../device-mapper/{dm-io.txt => dm-io.rst}         |   13 +-
 .../device-mapper/{dm-log.txt => dm-log.rst}       |    5 +-
 .../{dm-queue-length.txt => dm-queue-length.rst}   |   25 +-
 .../device-mapper/{dm-raid.txt => dm-raid.rst}     |  225 +-
 .../{dm-service-time.txt => dm-service-time.rst}   |   76 +-
 Documentation/device-mapper/dm-uevent.rst          |  110 +
 Documentation/device-mapper/dm-uevent.txt          |   97 -
 .../device-mapper/{dm-zoned.txt => dm-zoned.rst}   |   10 +-
 Documentation/device-mapper/{era.txt => era.rst}   |   36 +-
 Documentation/device-mapper/index.rst              |   42 +
 .../device-mapper/{kcopyd.txt => kcopyd.rst}       |    9 +-
 Documentation/device-mapper/linear.rst             |   63 +
 Documentation/device-mapper/linear.txt             |   61 -
 .../{log-writes.txt => log-writes.rst}             |  107 +-
 .../{persistent-data.txt => persistent-data.rst}   |    4 +
 .../device-mapper/{snapshot.txt => snapshot.rst}   |  116 +-
 .../{statistics.txt => statistics.rst}             |   62 +-
 Documentation/device-mapper/striped.rst            |   61 +
 Documentation/device-mapper/striped.txt            |   57 -
 .../device-mapper/{switch.txt => switch.rst}       |   46 +-
 ...thin-provisioning.txt => thin-provisioning.rst} |   68 +-
 .../device-mapper/{unstriped.txt => unstriped.rst} |   93 +-
 .../device-mapper/{verity.txt => verity.rst}       |   20 +-
 .../{writecache.txt => writecache.rst}             |   13 +-
 Documentation/device-mapper/{zero.txt => zero.rst} |   13 +-
 Documentation/driver-api/index.rst                 |    3 +
 Documentation/{pps/pps.txt => driver-api/pps.rst}  |   67 +-
 Documentation/{ptp/ptp.txt => driver-api/ptp.rst}  |   17 +-
 .../driver => driver-api/serial/driver.rst}        |  113 +-
 Documentation/driver-api/serial/index.rst          |   30 +
 Documentation/driver-api/serial/moxa-smartio.rst   |  615 +++++
 Documentation/driver-api/serial/n_gsm.rst          |  103 +
 .../rocket.txt => driver-api/serial/rocket.rst}    |  132 +-
 .../serial/serial-iso7816.rst}                     |   21 +-
 .../serial/serial-rs485.rst}                       |   22 +-
 .../{serial/tty.txt => driver-api/serial/tty.rst}  |   93 +-
 .../{fault-injection.txt => fault-injection.rst}   |  281 ++-
 Documentation/fault-injection/index.rst            |   18 +
 ...-error-inject.txt => notifier-error-inject.rst} |   18 +-
 .../fault-injection/nvme-fault-injection.rst       |  120 +
 .../fault-injection/nvme-fault-injection.txt       |  116 -
 Documentation/fault-injection/provoke-crashes.rst  |   48 +
 Documentation/fault-injection/provoke-crashes.txt  |   38 -
 Documentation/fb/{api.txt => api.rst}              |   29 +-
 Documentation/fb/{arkfb.txt => arkfb.rst}          |    8 +-
 Documentation/fb/{aty128fb.txt => aty128fb.rst}    |   31 +-
 Documentation/fb/{cirrusfb.txt => cirrusfb.rst}    |   45 +-
 .../fb/{cmap_xfbdev.txt => cmap_xfbdev.rst}        |   56 +-
 .../fb/{deferred_io.txt => deferred_io.rst}        |   28 +-
 Documentation/fb/{efifb.txt => efifb.rst}          |   18 +-
 Documentation/fb/{ep93xx-fb.txt => ep93xx-fb.rst}  |   25 +-
 Documentation/fb/{fbcon.txt => fbcon.rst}          |  179 +-
 .../fb/{framebuffer.txt => framebuffer.rst}        |   79 +-
 Documentation/fb/{gxfb.txt => gxfb.rst}            |   22 +-
 Documentation/fb/index.rst                         |   48 +
 Documentation/fb/{intel810.txt => intel810.rst}    |   77 +-
 Documentation/fb/{intelfb.txt => intelfb.rst}      |   62 +-
 Documentation/fb/{internals.txt => internals.rst}  |   23 +-
 Documentation/fb/{lxfb.txt => lxfb.rst}            |   23 +-
 Documentation/fb/matroxfb.rst                      |  443 ++++
 Documentation/fb/matroxfb.txt                      |  413 ----
 .../fb/{metronomefb.txt => metronomefb.rst}        |    7 +-
 Documentation/fb/{modedb.txt => modedb.rst}        |   44 +-
 Documentation/fb/pvr2fb.rst                        |   66 +
 Documentation/fb/pvr2fb.txt                        |   65 -
 Documentation/fb/{pxafb.txt => pxafb.rst}          |   81 +-
 Documentation/fb/{s3fb.txt => s3fb.rst}            |    8 +-
 Documentation/fb/{sa1100fb.txt => sa1100fb.rst}    |   23 +-
 Documentation/fb/sh7760fb.rst                      |  130 +
 Documentation/fb/sh7760fb.txt                      |  131 -
 Documentation/fb/{sisfb.txt => sisfb.rst}          |   38 +-
 Documentation/fb/{sm501.txt => sm501.rst}          |    7 +-
 Documentation/fb/{sm712fb.txt => sm712fb.rst}      |   18 +-
 Documentation/fb/sstfb.rst                         |  207 ++
 Documentation/fb/sstfb.txt                         |  174 --
 Documentation/fb/{tgafb.txt => tgafb.rst}          |   30 +-
 Documentation/fb/{tridentfb.txt => tridentfb.rst}  |   34 +-
 Documentation/fb/{udlfb.txt => udlfb.rst}          |   55 +-
 Documentation/fb/{uvesafb.txt => uvesafb.rst}      |  141 +-
 Documentation/fb/{vesafb.txt => vesafb.rst}        |  143 +-
 Documentation/fb/viafb.rst                         |  297 +++
 Documentation/fb/viafb.txt                         |  252 --
 Documentation/fb/{vt8623fb.txt => vt8623fb.rst}    |   10 +-
 Documentation/fpga/{dfl.txt => dfl.rst}            |   58 +-
 Documentation/fpga/index.rst                       |   15 +
 Documentation/gpio/index.rst                       |   15 +
 Documentation/gpio/{sysfs.txt => sysfs.rst}        |   39 +-
 Documentation/ide/changelogs.rst                   |   18 +
 Documentation/ide/{ide-tape.txt => ide-tape.rst}   |   23 +-
 Documentation/ide/{ide.txt => ide.rst}             |  147 +-
 Documentation/ide/index.rst                        |   19 +
 .../{warm-plug-howto.txt => warm-plug-howto.rst}   |   10 +-
 Documentation/index.rst                            |   31 +
 .../{core_locking.txt => core_locking.rst}         |   64 +-
 Documentation/infiniband/index.rst                 |   21 +
 Documentation/infiniband/{ipoib.txt => ipoib.rst}  |   18 +-
 .../infiniband/{opa_vnic.txt => opa_vnic.rst}      |  110 +-
 Documentation/infiniband/{sysfs.txt => sysfs.rst}  |    4 +-
 .../{tag_matching.txt => tag_matching.rst}         |    5 +
 .../infiniband/{user_mad.txt => user_mad.rst}      |   33 +-
 .../infiniband/{user_verbs.txt => user_verbs.rst}  |   12 +-
 .../{headers_install.txt => headers_install.rst}   |    5 +-
 Documentation/kbuild/index.rst                     |   25 +
 Documentation/kbuild/issues.rst                    |   11 +
 Documentation/kbuild/{kbuild.txt => kbuild.rst}    |  119 +-
 .../{kconfig-language.txt => kconfig-language.rst} |  240 +-
 ...cro-language.txt => kconfig-macro-language.rst} |   37 +-
 Documentation/kbuild/{kconfig.txt => kconfig.rst}  |  136 +-
 .../kbuild/{makefiles.txt => makefiles.rst}        |  515 ++--
 Documentation/kbuild/{modules.txt => modules.rst}  |  167 +-
 Documentation/kdump/index.rst                      |   19 +
 Documentation/kdump/{kdump.txt => kdump.rst}       |  138 +-
 .../kdump/{vmcoreinfo.txt => vmcoreinfo.rst}       |   59 +-
 .../livepatch/{callbacks.txt => callbacks.rst}     |   12 +-
 ...mulative-patches.txt => cumulative-patches.rst} |   14 +-
 Documentation/livepatch/index.rst                  |   19 +
 .../livepatch/{livepatch.txt => livepatch.rst}     |   58 +-
 ...module-elf-format.txt => module-elf-format.rst} |  217 +-
 .../livepatch/{shadow-vars.txt => shadow-vars.rst} |   65 +-
 Documentation/locking/index.rst                    |   22 +
 .../{lockdep-design.txt => lockdep-design.rst}     |   41 +-
 Documentation/locking/lockstat.rst                 |  204 ++
 Documentation/locking/lockstat.txt                 |  183 --
 .../locking/{locktorture.txt => locktorture.rst}   |  105 +-
 .../locking/{mutex-design.txt => mutex-design.rst} |   26 +-
 .../{rt-mutex-design.txt => rt-mutex-design.rst}   |  135 +-
 .../locking/{rt-mutex.txt => rt-mutex.rst}         |   30 +-
 .../locking/{spinlocks.txt => spinlocks.rst}       |   32 +-
 .../{ww-mutex-design.txt => ww-mutex-design.rst}   |   82 +-
 Documentation/mic/index.rst                        |   16 +
 .../mic/{mic_overview.txt => mic_overview.rst}     |    6 +-
 .../mic/{scif_overview.txt => scif_overview.rst}   |   58 +-
 .../netlabel/{cipso_ipv4.txt => cipso_ipv4.rst}    |   19 +-
 Documentation/netlabel/draft_ietf.rst              |    5 +
 Documentation/netlabel/index.rst                   |   19 +
 .../{introduction.txt => introduction.rst}         |   16 +-
 .../{lsm_interface.txt => lsm_interface.rst}       |   16 +-
 .../pcmcia/{devicetable.txt => devicetable.rst}    |    4 +
 .../{driver-changes.txt => driver-changes.rst}     |   35 +-
 Documentation/pcmcia/{driver.txt => driver.rst}    |   18 +-
 Documentation/pcmcia/index.rst                     |   18 +
 Documentation/pcmcia/{locking.txt => locking.rst}  |   39 +-
 Documentation/power/{apm-acpi.txt => apm-acpi.rst} |   10 +-
 ...sic-pm-debugging.txt => basic-pm-debugging.rst} |   77 +-
 .../{charger-manager.txt => charger-manager.rst}   |  105 +-
 .../{drivers-testing.txt => drivers-testing.rst}   |    5 +
 .../power/{energy-model.txt => energy-model.rst}   |  105 +-
 ...freezing-of-tasks.txt => freezing-of-tasks.rst} |   91 +-
 Documentation/power/index.rst                      |   44 +
 .../power/{interface.txt => interface.rst}         |   20 +-
 Documentation/power/{opp.txt => opp.rst}           |  175 +-
 Documentation/power/{pci.txt => pci.rst}           |   77 +-
 .../{pm_qos_interface.txt => pm_qos_interface.rst} |  127 +-
 Documentation/power/power_supply_class.rst         |  282 +++
 Documentation/power/power_supply_class.txt         |  231 --
 Documentation/power/powercap/powercap.rst          |  257 ++
 Documentation/power/powercap/powercap.txt          |  236 --
 .../power/regulator/{consumer.txt => consumer.rst} |  141 +-
 .../power/regulator/{design.txt => design.rst}     |    9 +-
 .../power/regulator/{machine.txt => machine.rst}   |   47 +-
 .../power/regulator/{overview.txt => overview.rst} |   51 +-
 Documentation/power/regulator/regulator.rst        |   32 +
 Documentation/power/regulator/regulator.txt        |   30 -
 .../power/{runtime_pm.txt => runtime_pm.rst}       |  234 +-
 Documentation/power/{s2ram.txt => s2ram.rst}       |   20 +-
 ...d-cpuhotplug.txt => suspend-and-cpuhotplug.rst} |   42 +-
 ...d-interrupts.txt => suspend-and-interrupts.rst} |    2 +
 ...nd-swap-files.txt => swsusp-and-swap-files.rst} |   15 +-
 .../{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst}     |  120 +-
 Documentation/power/swsusp.rst                     |  501 ++++
 Documentation/power/swsusp.txt                     |  446 ----
 Documentation/power/{tricks.txt => tricks.rst}     |    6 +-
 .../{userland-swsusp.txt => userland-swsusp.rst}   |   53 +-
 Documentation/power/{video.txt => video.rst}       |  156 +-
 .../powerpc/{DAWR-POWER9.txt => DAWR-POWER9.rst}   |    9 +-
 .../powerpc/{bootwrapper.txt => bootwrapper.rst}   |    6 +-
 .../powerpc/{cpu_families.txt => cpu_families.rst} |   23 +-
 .../powerpc/{cpu_features.txt => cpu_features.rst} |    6 +-
 Documentation/powerpc/{cxl.txt => cxl.rst}         |   46 +-
 .../powerpc/{cxlflash.txt => cxlflash.rst}         |    6 +-
 Documentation/powerpc/{dscr.txt => dscr.rst}       |   18 +-
 ...ror-recovery.txt => eeh-pci-error-recovery.rst} |   96 +-
 ...ssisted-dump.txt => firmware-assisted-dump.rst} |  117 +-
 Documentation/powerpc/{hvcs.txt => hvcs.rst}       |  108 +-
 Documentation/powerpc/index.rst                    |   32 +
 Documentation/powerpc/isa-versions.rst             |   13 +-
 Documentation/powerpc/{mpc52xx.txt => mpc52xx.rst} |   12 +-
 ...powernv.txt => pci_iov_resource_on_powernv.rst} |   15 +-
 Documentation/powerpc/{pmu-ebb.txt => pmu-ebb.rst} |    1 +
 Documentation/powerpc/ptrace.rst                   |  156 ++
 Documentation/powerpc/ptrace.txt                   |  151 --
 .../powerpc/{qe_firmware.txt => qe_firmware.rst}   |   37 +-
 .../{syscall64-abi.txt => syscall64-abi.rst}       |   29 +-
 ...ctional_memory.txt => transactional_memory.rst} |   45 +-
 Documentation/riscv/index.rst                      |   15 +
 Documentation/riscv/{pmu.txt => pmu.rst}           |   98 +-
 Documentation/s390/{3270.txt => 3270.rst}          |   85 +-
 Documentation/s390/Debugging390.rst                | 2613 ++++++++++++++++++++
 Documentation/s390/Debugging390.txt                | 2142 ----------------
 Documentation/s390/{cds.txt => cds.rst}            |  368 +--
 Documentation/s390/{CommonIO => common_io.rst}     |   47 +-
 Documentation/s390/{DASD => dasd.rst}              |   33 +-
 .../s390/{driver-model.txt => driver-model.rst}    |  177 +-
 Documentation/s390/index.rst                       |   28 +
 .../s390/{monreader.txt => monreader.rst}          |   84 +-
 Documentation/s390/{qeth.txt => qeth.rst}          |   36 +-
 Documentation/s390/s390dbf.rst                     |  474 ++++
 Documentation/s390/s390dbf.txt                     |  667 -----
 Documentation/s390/text_files.rst                  |   11 +
 Documentation/s390/{vfio-ap.txt => vfio-ap.rst}    |  499 ++--
 Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst}  |   90 +-
 Documentation/s390/{zfcpdump.txt => zfcpdump.rst}  |    2 +
 Documentation/serial/README.cycladesZ              |    8 -
 Documentation/serial/moxa-smartio                  |  523 ----
 Documentation/serial/n_gsm.txt                     |   96 -
 Documentation/target/index.rst                     |   17 +
 Documentation/target/scripts.rst                   |   11 +
 Documentation/target/tcm_mod_builder.rst           |  149 ++
 Documentation/target/tcm_mod_builder.txt           |  145 --
 .../target/{tcmu-design.txt => tcmu-design.rst}    |  274 +-
 Documentation/timers/{highres.txt => highres.rst}  |    8 +-
 Documentation/timers/{hpet.txt => hpet.rst}        |    4 +-
 .../timers/{hrtimers.txt => hrtimers.rst}          |    4 +-
 Documentation/timers/index.rst                     |   20 +
 Documentation/timers/{NO_HZ.txt => no_hz.rst}      |   40 +-
 .../timers/{timekeeping.txt => timekeeping.rst}    |    3 +-
 .../timers/{timers-howto.txt => timers-howto.rst}  |   15 +-
 Documentation/usb/acm.rst                          |  132 +
 Documentation/usb/acm.txt                          |  128 -
 .../usb/{authorization.txt => authorization.rst}   |   75 +-
 Documentation/usb/{chipidea.txt => chipidea.rst}   |  102 +-
 Documentation/usb/{dwc3.txt => dwc3.rst}           |   12 +-
 Documentation/usb/{ehci.txt => ehci.rst}           |   42 +-
 .../usb/{functionfs.txt => functionfs.rst}         |   16 +-
 .../usb/{gadget-testing.txt => gadget-testing.rst} |  611 +++--
 .../{gadget_configfs.txt => gadget_configfs.rst}   |  306 +--
 .../usb/{gadget_hid.txt => gadget_hid.rst}         |  175 +-
 .../usb/{gadget_multi.txt => gadget_multi.rst}     |   43 +-
 .../usb/{gadget_printer.txt => gadget_printer.rst} |  155 +-
 .../usb/{gadget_serial.txt => gadget_serial.rst}   |   75 +-
 Documentation/usb/index.rst                        |   39 +
 .../usb/{iuu_phoenix.txt => iuu_phoenix.rst}       |   32 +-
 .../usb/{mass-storage.txt => mass-storage.rst}     |   19 +-
 .../usb/{misc_usbsevseg.txt => misc_usbsevseg.rst} |    7 +
 Documentation/usb/{mtouchusb.txt => mtouchusb.rst} |   34 +-
 Documentation/usb/{ohci.txt => ohci.rst}           |    4 +
 Documentation/usb/{rio.txt => rio.rst}             |   54 +-
 Documentation/usb/text_files.rst                   |   29 +
 Documentation/usb/usb-help.rst                     |   17 +
 Documentation/usb/usb-help.txt                     |   16 -
 .../usb/{usb-serial.txt => usb-serial.rst}         |  165 +-
 Documentation/usb/usbip_protocol.rst               |  411 +++
 Documentation/usb/usbip_protocol.txt               |  357 ---
 Documentation/usb/{usbmon.txt => usbmon.rst}       |  100 +-
 ...esign-overview.txt => wusb-design-overview.rst} |   55 +-
 ...l_api.txt => convert_drivers_to_kernel_api.rst} |  108 +-
 Documentation/watchdog/{hpwdt.txt => hpwdt.rst}    |   29 +-
 Documentation/watchdog/index.rst                   |   23 +
 .../watchdog/{mlx-wdt.txt => mlx-wdt.rst}          |   24 +-
 .../{pcwd-watchdog.txt => pcwd-watchdog.rst}       |   12 +-
 .../{watchdog-api.txt => watchdog-api.rst}         |   75 +-
 ...hdog-kernel-api.txt => watchdog-kernel-api.rst} |   89 +-
 Documentation/watchdog/watchdog-parameters.rst     |  736 ++++++
 Documentation/watchdog/watchdog-parameters.txt     |  410 ---
 .../watchdog/{watchdog-pm.txt => watchdog-pm.rst}  |    3 +
 Documentation/watchdog/{wdt.txt => wdt.rst}        |   31 +-
 ...ry-encryption.txt => amd-memory-encryption.rst} |   10 +-
 Documentation/x86/{boot.txt => boot.rst}           |  588 ++---
 .../x86/{earlyprintk.txt => earlyprintk.rst}       |   77 +-
 Documentation/x86/{entry_64.txt => entry_64.rst}   |   11 +-
 .../{exception-tables.txt => exception-tables.rst} |  247 +-
 .../x86/i386/{IO-APIC.txt => IO-APIC.rst}          |   22 +-
 Documentation/x86/index.rst                        |   40 +
 Documentation/x86/{intel_mpx.txt => intel_mpx.rst} |   57 +-
 Documentation/x86/{microcode.txt => microcode.rst} |   51 +-
 Documentation/x86/mtrr.rst                         |  351 +++
 Documentation/x86/mtrr.txt                         |  329 ---
 .../x86/{orc-unwinder.txt => orc-unwinder.rst}     |    1 +
 Documentation/x86/pat.rst                          |  231 ++
 Documentation/x86/pat.txt                          |  230 --
 .../{protection-keys.txt => protection-keys.rst}   |   33 +-
 Documentation/x86/{pti.txt => pti.rst}             |    8 +-
 .../x86/{resctrl_ui.txt => resctrl_ui.rst}         |  643 ++---
 Documentation/x86/{tlb.txt => tlb.rst}             |   12 +-
 Documentation/x86/{topology.txt => topology.rst}   |   26 +-
 ...b-legacy-support.txt => usb-legacy-support.rst} |   38 +-
 .../{5level-paging.txt => 5level-paging.rst}       |   13 +-
 .../x86_64/{boot-options.txt => boot-options.rst}  |   98 +-
 Documentation/x86/x86_64/mm.rst                    |  185 ++
 Documentation/x86/x86_64/mm.txt                    |  153 --
 Documentation/x86/x86_64/{uefi.txt => uefi.rst}    |   21 +-
 Documentation/x86/zero-page.rst                    |   47 +
 Documentation/x86/zero-page.txt                    |   40 -
 Documentation/xilinx/{eemi.txt => eemi.rst}        |    8 +-
 Documentation/xilinx/index.rst                     |   15 +
 arch/s390/include/asm/debug.h                      |  231 ++
 379 files changed, 22705 insertions(+), 17379 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (90%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (85%)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.rst
 delete mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (81%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (80%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (59%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (83%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (77%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (74%)
 rename Documentation/PCI/{pci.txt => pci.rst} (83%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (77%)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (98%)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (85%)
 rename Documentation/acpi/{aml-debugger.txt => aml-debugger.rst} (77%)
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (77%)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (59%)
 rename Documentation/acpi/{debug.txt => debug.rst} (93%)
 rename Documentation/{extcon/intel-int3496.txt => acpi/drivers/extcon-intel-int3496.rst} (66%)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (91%)
 rename Documentation/acpi/dsd/{graph.txt => graph.rst} (88%)
 rename Documentation/acpi/{dsdt-override.txt => dsdt-override.rst} (55%)
 rename Documentation/acpi/{enumeration.txt => enumeration.rst} (95%)
 rename Documentation/acpi/{gpio-properties.txt => gpio-properties.rst} (91%)
 rename Documentation/acpi/{i2c-muxes.txt => i2c-muxes.rst} (82%)
 create mode 100644 Documentation/acpi/index.rst
 rename Documentation/acpi/{initrd_table_override.txt => initrd_table_override.rst} (53%)
 rename Documentation/acpi/{linuxized-acpica.txt => linuxized-acpica.rst} (92%)
 rename Documentation/acpi/{lpit.txt => lpit.rst} (92%)
 rename Documentation/acpi/{method-customizing.txt => method-customizing.rst} (72%)
 rename Documentation/acpi/{method-tracing.txt => method-tracing.rst} (74%)
 rename Documentation/acpi/{namespace.txt => namespace.rst} (65%)
 rename Documentation/acpi/{osi.txt => osi.rst} (99%)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (98%)
 rename Documentation/acpi/{ssdt-overlays.txt => ssdt-overlays.rst} (62%)
 rename Documentation/acpi/{video_extension.txt => video_extension.rst} (95%)
 rename Documentation/aoe/{aoe.txt => aoe.rst} (79%)
 create mode 100644 Documentation/aoe/examples.rst
 create mode 100644 Documentation/aoe/index.rst
 rename Documentation/aoe/{todo.txt => todo.rst} (98%)
 rename Documentation/arm64/{acpi_object_usage.txt => acpi_object_usage.rst} (84%)
 rename Documentation/arm64/{arm-acpi.txt => arm-acpi.rst} (87%)
 rename Documentation/arm64/{booting.txt => booting.rst} (86%)
 rename Documentation/arm64/{cpu-feature-registers.txt => cpu-feature-registers.rst} (66%)
 rename Documentation/arm64/{elf_hwcaps.txt => elf_hwcaps.rst} (95%)
 rename Documentation/arm64/{hugetlbpage.txt => hugetlbpage.rst} (86%)
 create mode 100644 Documentation/arm64/index.rst
 rename Documentation/arm64/{legacy_instructions.txt => legacy_instructions.rst} (73%)
 create mode 100644 Documentation/arm64/memory.rst
 delete mode 100644 Documentation/arm64/memory.txt
 rename Documentation/arm64/{pointer-authentication.txt => pointer-authentication.rst} (98%)
 rename Documentation/arm64/{silicon-errata.txt => silicon-errata.rst} (55%)
 rename Documentation/arm64/{sve.txt => sve.rst} (98%)
 rename Documentation/arm64/{tagged-pointers.txt => tagged-pointers.rst} (94%)
 delete mode 100644 Documentation/cdrom/Makefile
 create mode 100644 Documentation/cdrom/cdrom-standard.rst
 delete mode 100644 Documentation/cdrom/cdrom-standard.tex
 rename Documentation/cdrom/{ide-cd => ide-cd.rst} (87%)
 create mode 100644 Documentation/cdrom/index.rst
 rename Documentation/cdrom/{packet-writing.txt => packet-writing.rst} (91%)
 rename Documentation/cgroup-v1/{cgroups.txt => cgroups.rst} (89%)
 create mode 100644 Documentation/cgroup-v1/index.rst
 create mode 100644 Documentation/cgroup-v1/text_files.rst
 rename Documentation/cpu-freq/{amd-powernow.txt => amd-powernow.rst} (94%)
 rename Documentation/cpu-freq/{core.txt => core.rst} (67%)
 rename Documentation/cpu-freq/{cpu-drivers.txt => cpu-drivers.rst} (57%)
 rename Documentation/cpu-freq/{cpufreq-nforce2.txt => cpufreq-nforce2.rst} (66%)
 create mode 100644 Documentation/cpu-freq/cpufreq-stats.rst
 delete mode 100644 Documentation/cpu-freq/cpufreq-stats.txt
 create mode 100644 Documentation/cpu-freq/index.rst
 delete mode 100644 Documentation/cpu-freq/index.txt
 rename Documentation/cpu-freq/{pcc-cpufreq.txt => pcc-cpufreq.rst} (80%)
 rename Documentation/device-mapper/{cache-policies.txt => cache-policies.rst} (94%)
 rename Documentation/device-mapper/{cache.txt => cache.rst} (61%)
 rename Documentation/device-mapper/{delay.txt => delay.rst} (53%)
 rename Documentation/device-mapper/{dm-crypt.txt => dm-crypt.rst} (87%)
 rename Documentation/device-mapper/{dm-flakey.txt => dm-flakey.rst} (60%)
 rename Documentation/device-mapper/{dm-init.txt => dm-init.rst} (68%)
 rename Documentation/device-mapper/{dm-integrity.txt => dm-integrity.rst} (90%)
 rename Documentation/device-mapper/{dm-io.txt => dm-io.rst} (92%)
 rename Documentation/device-mapper/{dm-log.txt => dm-log.rst} (90%)
 rename Documentation/device-mapper/{dm-queue-length.txt => dm-queue-length.rst} (76%)
 rename Documentation/device-mapper/{dm-raid.txt => dm-raid.rst} (71%)
 rename Documentation/device-mapper/{dm-service-time.txt => dm-service-time.rst} (60%)
 create mode 100644 Documentation/device-mapper/dm-uevent.rst
 delete mode 100644 Documentation/device-mapper/dm-uevent.txt
 rename Documentation/device-mapper/{dm-zoned.txt => dm-zoned.rst} (97%)
 rename Documentation/device-mapper/{era.txt => era.rst} (70%)
 create mode 100644 Documentation/device-mapper/index.rst
 rename Documentation/device-mapper/{kcopyd.txt => kcopyd.rst} (93%)
 create mode 100644 Documentation/device-mapper/linear.rst
 delete mode 100644 Documentation/device-mapper/linear.txt
 rename Documentation/device-mapper/{log-writes.txt => log-writes.rst} (61%)
 rename Documentation/device-mapper/{persistent-data.txt => persistent-data.rst} (98%)
 rename Documentation/device-mapper/{snapshot.txt => snapshot.rst} (62%)
 rename Documentation/device-mapper/{statistics.txt => statistics.rst} (87%)
 create mode 100644 Documentation/device-mapper/striped.rst
 delete mode 100644 Documentation/device-mapper/striped.txt
 rename Documentation/device-mapper/{switch.txt => switch.rst} (84%)
 rename Documentation/device-mapper/{thin-provisioning.txt => thin-provisioning.rst} (92%)
 rename Documentation/device-mapper/{unstriped.txt => unstriped.rst} (60%)
 rename Documentation/device-mapper/{verity.txt => verity.rst} (98%)
 rename Documentation/device-mapper/{writecache.txt => writecache.rst} (96%)
 rename Documentation/device-mapper/{zero.txt => zero.rst} (83%)
 rename Documentation/{pps/pps.txt => driver-api/pps.rst} (90%)
 rename Documentation/{ptp/ptp.txt => driver-api/ptp.rst} (90%)
 rename Documentation/{serial/driver => driver-api/serial/driver.rst} (92%)
 create mode 100644 Documentation/driver-api/serial/index.rst
 create mode 100644 Documentation/driver-api/serial/moxa-smartio.rst
 create mode 100644 Documentation/driver-api/serial/n_gsm.rst
 rename Documentation/{serial/rocket.txt => driver-api/serial/rocket.rst} (70%)
 rename Documentation/{serial/serial-iso7816.txt => driver-api/serial/serial-iso7816.rst} (85%)
 rename Documentation/{serial/serial-rs485.txt => driver-api/serial/serial-rs485.rst} (89%)
 rename Documentation/{serial/tty.txt => driver-api/serial/tty.rst} (76%)
 rename Documentation/fault-injection/{fault-injection.txt => fault-injection.rst} (68%)
 create mode 100644 Documentation/fault-injection/index.rst
 rename Documentation/fault-injection/{notifier-error-inject.txt => notifier-error-inject.rst} (83%)
 create mode 100644 Documentation/fault-injection/nvme-fault-injection.rst
 delete mode 100644 Documentation/fault-injection/nvme-fault-injection.txt
 create mode 100644 Documentation/fault-injection/provoke-crashes.rst
 delete mode 100644 Documentation/fault-injection/provoke-crashes.txt
 rename Documentation/fb/{api.txt => api.rst} (97%)
 rename Documentation/fb/{arkfb.txt => arkfb.rst} (92%)
 rename Documentation/fb/{aty128fb.txt => aty128fb.rst} (66%)
 rename Documentation/fb/{cirrusfb.txt => cirrusfb.rst} (75%)
 rename Documentation/fb/{cmap_xfbdev.txt => cmap_xfbdev.rst} (50%)
 rename Documentation/fb/{deferred_io.txt => deferred_io.rst} (86%)
 rename Documentation/fb/{efifb.txt => efifb.rst} (75%)
 rename Documentation/fb/{ep93xx-fb.txt => ep93xx-fb.rst} (86%)
 rename Documentation/fb/{fbcon.txt => fbcon.rst} (69%)
 rename Documentation/fb/{framebuffer.txt => framebuffer.rst} (92%)
 rename Documentation/fb/{gxfb.txt => gxfb.rst} (65%)
 create mode 100644 Documentation/fb/index.rst
 rename Documentation/fb/{intel810.txt => intel810.rst} (83%)
 rename Documentation/fb/{intelfb.txt => intelfb.rst} (73%)
 rename Documentation/fb/{internals.txt => internals.rst} (82%)
 rename Documentation/fb/{lxfb.txt => lxfb.rst} (65%)
 create mode 100644 Documentation/fb/matroxfb.rst
 delete mode 100644 Documentation/fb/matroxfb.txt
 rename Documentation/fb/{metronomefb.txt => metronomefb.rst} (98%)
 rename Documentation/fb/{modedb.txt => modedb.rst} (87%)
 create mode 100644 Documentation/fb/pvr2fb.rst
 delete mode 100644 Documentation/fb/pvr2fb.txt
 rename Documentation/fb/{pxafb.txt => pxafb.rst} (78%)
 rename Documentation/fb/{s3fb.txt => s3fb.rst} (94%)
 rename Documentation/fb/{sa1100fb.txt => sa1100fb.rst} (64%)
 create mode 100644 Documentation/fb/sh7760fb.rst
 delete mode 100644 Documentation/fb/sh7760fb.txt
 rename Documentation/fb/{sisfb.txt => sisfb.rst} (85%)
 rename Documentation/fb/{sm501.txt => sm501.rst} (65%)
 rename Documentation/fb/{sm712fb.txt => sm712fb.rst} (59%)
 create mode 100644 Documentation/fb/sstfb.rst
 delete mode 100644 Documentation/fb/sstfb.txt
 rename Documentation/fb/{tgafb.txt => tgafb.rst} (71%)
 rename Documentation/fb/{tridentfb.txt => tridentfb.rst} (71%)
 rename Documentation/fb/{udlfb.txt => udlfb.rst} (77%)
 rename Documentation/fb/{uvesafb.txt => uvesafb.rst} (52%)
 rename Documentation/fb/{vesafb.txt => vesafb.rst} (53%)
 create mode 100644 Documentation/fb/viafb.rst
 delete mode 100644 Documentation/fb/viafb.txt
 rename Documentation/fb/{vt8623fb.txt => vt8623fb.rst} (85%)
 rename Documentation/fpga/{dfl.txt => dfl.rst} (89%)
 create mode 100644 Documentation/fpga/index.rst
 create mode 100644 Documentation/gpio/index.rst
 rename Documentation/gpio/{sysfs.txt => sysfs.rst} (86%)
 create mode 100644 Documentation/ide/changelogs.rst
 rename Documentation/ide/{ide-tape.txt => ide-tape.rst} (83%)
 rename Documentation/ide/{ide.txt => ide.rst} (72%)
 create mode 100644 Documentation/ide/index.rst
 rename Documentation/ide/{warm-plug-howto.txt => warm-plug-howto.rst} (61%)
 rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
 create mode 100644 Documentation/infiniband/index.rst
 rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (93%)
 rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
 rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
 rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
 rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
 rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)
 rename Documentation/kbuild/{headers_install.txt => headers_install.rst} (96%)
 create mode 100644 Documentation/kbuild/index.rst
 create mode 100644 Documentation/kbuild/issues.rst
 rename Documentation/kbuild/{kbuild.txt => kbuild.rst} (72%)
 rename Documentation/kbuild/{kconfig-language.txt => kconfig-language.rst} (85%)
 rename Documentation/kbuild/{kconfig-macro-language.txt => kconfig-macro-language.rst} (94%)
 rename Documentation/kbuild/{kconfig.txt => kconfig.rst} (80%)
 rename Documentation/kbuild/{makefiles.txt => makefiles.rst} (84%)
 rename Documentation/kbuild/{modules.txt => modules.rst} (85%)
 create mode 100644 Documentation/kdump/index.rst
 rename Documentation/kdump/{kdump.txt => kdump.rst} (90%)
 rename Documentation/kdump/{vmcoreinfo.txt => vmcoreinfo.rst} (95%)
 rename Documentation/livepatch/{callbacks.txt => callbacks.rst} (94%)
 rename Documentation/livepatch/{cumulative-patches.txt => cumulative-patches.rst} (89%)
 create mode 100644 Documentation/livepatch/index.rst
 rename Documentation/livepatch/{livepatch.txt => livepatch.rst} (94%)
 rename Documentation/livepatch/{module-elf-format.txt => module-elf-format.rst} (68%)
 rename Documentation/livepatch/{shadow-vars.txt => shadow-vars.rst} (87%)
 create mode 100644 Documentation/locking/index.rst
 rename Documentation/locking/{lockdep-design.txt => lockdep-design.rst} (93%)
 create mode 100644 Documentation/locking/lockstat.rst
 delete mode 100644 Documentation/locking/lockstat.txt
 rename Documentation/locking/{locktorture.txt => locktorture.rst} (57%)
 rename Documentation/locking/{mutex-design.txt => mutex-design.rst} (94%)
 rename Documentation/locking/{rt-mutex-design.txt => rt-mutex-design.rst} (91%)
 rename Documentation/locking/{rt-mutex.txt => rt-mutex.rst} (71%)
 rename Documentation/locking/{spinlocks.txt => spinlocks.rst} (89%)
 rename Documentation/locking/{ww-mutex-design.txt => ww-mutex-design.rst} (93%)
 create mode 100644 Documentation/mic/index.rst
 rename Documentation/mic/{mic_overview.txt => mic_overview.rst} (96%)
 rename Documentation/mic/{scif_overview.txt => scif_overview.rst} (76%)
 rename Documentation/netlabel/{cipso_ipv4.txt => cipso_ipv4.rst} (87%)
 create mode 100644 Documentation/netlabel/draft_ietf.rst
 create mode 100644 Documentation/netlabel/index.rst
 rename Documentation/netlabel/{introduction.txt => introduction.rst} (91%)
 rename Documentation/netlabel/{lsm_interface.txt => lsm_interface.rst} (88%)
 rename Documentation/pcmcia/{devicetable.txt => devicetable.rst} (97%)
 rename Documentation/pcmcia/{driver-changes.txt => driver-changes.rst} (90%)
 rename Documentation/pcmcia/{driver.txt => driver.rst} (66%)
 create mode 100644 Documentation/pcmcia/index.rst
 rename Documentation/pcmcia/{locking.txt => locking.rst} (81%)
 rename Documentation/power/{apm-acpi.txt => apm-acpi.rst} (87%)
 rename Documentation/power/{basic-pm-debugging.txt => basic-pm-debugging.rst} (87%)
 rename Documentation/power/{charger-manager.txt => charger-manager.rst} (78%)
 rename Documentation/power/{drivers-testing.txt => drivers-testing.rst} (93%)
 rename Documentation/power/{energy-model.txt => energy-model.rst} (74%)
 rename Documentation/power/{freezing-of-tasks.txt => freezing-of-tasks.rst} (75%)
 create mode 100644 Documentation/power/index.rst
 rename Documentation/power/{interface.txt => interface.rst} (87%)
 rename Documentation/power/{opp.txt => opp.rst} (78%)
 rename Documentation/power/{pci.txt => pci.rst} (97%)
 rename Documentation/power/{pm_qos_interface.txt => pm_qos_interface.rst} (62%)
 create mode 100644 Documentation/power/power_supply_class.rst
 delete mode 100644 Documentation/power/power_supply_class.txt
 create mode 100644 Documentation/power/powercap/powercap.rst
 delete mode 100644 Documentation/power/powercap/powercap.txt
 rename Documentation/power/regulator/{consumer.txt => consumer.rst} (61%)
 rename Documentation/power/regulator/{design.txt => design.rst} (86%)
 rename Documentation/power/regulator/{machine.txt => machine.rst} (75%)
 rename Documentation/power/regulator/{overview.txt => overview.rst} (81%)
 create mode 100644 Documentation/power/regulator/regulator.rst
 delete mode 100644 Documentation/power/regulator/regulator.txt
 rename Documentation/power/{runtime_pm.txt => runtime_pm.rst} (89%)
 rename Documentation/power/{s2ram.txt => s2ram.rst} (92%)
 rename Documentation/power/{suspend-and-cpuhotplug.txt => suspend-and-cpuhotplug.rst} (90%)
 rename Documentation/power/{suspend-and-interrupts.txt => suspend-and-interrupts.rst} (98%)
 rename Documentation/power/{swsusp-and-swap-files.txt => swsusp-and-swap-files.rst} (85%)
 rename Documentation/power/{swsusp-dmcrypt.txt => swsusp-dmcrypt.rst} (68%)
 create mode 100644 Documentation/power/swsusp.rst
 delete mode 100644 Documentation/power/swsusp.txt
 rename Documentation/power/{tricks.txt => tricks.rst} (93%)
 rename Documentation/power/{userland-swsusp.txt => userland-swsusp.rst} (86%)
 rename Documentation/power/{video.txt => video.rst} (56%)
 rename Documentation/powerpc/{DAWR-POWER9.txt => DAWR-POWER9.rst} (95%)
 rename Documentation/powerpc/{bootwrapper.txt => bootwrapper.rst} (97%)
 rename Documentation/powerpc/{cpu_families.txt => cpu_families.rst} (95%)
 rename Documentation/powerpc/{cpu_features.txt => cpu_features.rst} (97%)
 rename Documentation/powerpc/{cxl.txt => cxl.rst} (95%)
 rename Documentation/powerpc/{cxlflash.txt => cxlflash.rst} (99%)
 rename Documentation/powerpc/{dscr.txt => dscr.rst} (91%)
 rename Documentation/powerpc/{eeh-pci-error-recovery.txt => eeh-pci-error-recovery.rst} (83%)
 rename Documentation/powerpc/{firmware-assisted-dump.txt => firmware-assisted-dump.rst} (80%)
 rename Documentation/powerpc/{hvcs.txt => hvcs.rst} (91%)
 create mode 100644 Documentation/powerpc/index.rst
 rename Documentation/powerpc/{mpc52xx.txt => mpc52xx.rst} (91%)
 rename Documentation/powerpc/{pci_iov_resource_on_powernv.txt => pci_iov_resource_on_powernv.rst} (97%)
 rename Documentation/powerpc/{pmu-ebb.txt => pmu-ebb.rst} (99%)
 create mode 100644 Documentation/powerpc/ptrace.rst
 delete mode 100644 Documentation/powerpc/ptrace.txt
 rename Documentation/powerpc/{qe_firmware.txt => qe_firmware.rst} (95%)
 rename Documentation/powerpc/{syscall64-abi.txt => syscall64-abi.rst} (82%)
 rename Documentation/powerpc/{transactional_memory.txt => transactional_memory.rst} (93%)
 create mode 100644 Documentation/riscv/index.rst
 rename Documentation/riscv/{pmu.txt => pmu.rst} (77%)
 rename Documentation/s390/{3270.txt => 3270.rst} (90%)
 create mode 100644 Documentation/s390/Debugging390.rst
 delete mode 100644 Documentation/s390/Debugging390.txt
 rename Documentation/s390/{cds.txt => cds.rst} (64%)
 rename Documentation/s390/{CommonIO => common_io.rst} (88%)
 rename Documentation/s390/{DASD => dasd.rst} (92%)
 rename Documentation/s390/{driver-model.txt => driver-model.rst} (73%)
 create mode 100644 Documentation/s390/index.rst
 rename Documentation/s390/{monreader.txt => monreader.rst} (81%)
 rename Documentation/s390/{qeth.txt => qeth.rst} (62%)
 create mode 100644 Documentation/s390/s390dbf.rst
 delete mode 100644 Documentation/s390/s390dbf.txt
 create mode 100644 Documentation/s390/text_files.rst
 rename Documentation/s390/{vfio-ap.txt => vfio-ap.rst} (72%)
 rename Documentation/s390/{vfio-ccw.txt => vfio-ccw.rst} (89%)
 rename Documentation/s390/{zfcpdump.txt => zfcpdump.rst} (97%)
 delete mode 100644 Documentation/serial/README.cycladesZ
 delete mode 100644 Documentation/serial/moxa-smartio
 delete mode 100644 Documentation/serial/n_gsm.txt
 create mode 100644 Documentation/target/index.rst
 create mode 100644 Documentation/target/scripts.rst
 create mode 100644 Documentation/target/tcm_mod_builder.rst
 delete mode 100644 Documentation/target/tcm_mod_builder.txt
 rename Documentation/target/{tcmu-design.txt => tcmu-design.rst} (69%)
 rename Documentation/timers/{highres.txt => highres.rst} (98%)
 rename Documentation/timers/{hpet.txt => hpet.rst} (91%)
 rename Documentation/timers/{hrtimers.txt => hrtimers.rst} (98%)
 create mode 100644 Documentation/timers/index.rst
 rename Documentation/timers/{NO_HZ.txt => no_hz.rst} (93%)
 rename Documentation/timers/{timekeeping.txt => timekeeping.rst} (98%)
 rename Documentation/timers/{timers-howto.txt => timers-howto.rst} (93%)
 create mode 100644 Documentation/usb/acm.rst
 delete mode 100644 Documentation/usb/acm.txt
 rename Documentation/usb/{authorization.txt => authorization.rst} (67%)
 rename Documentation/usb/{chipidea.txt => chipidea.rst} (56%)
 rename Documentation/usb/{dwc3.txt => dwc3.rst} (97%)
 rename Documentation/usb/{ehci.txt => ehci.rst} (92%)
 rename Documentation/usb/{functionfs.txt => functionfs.rst} (87%)
 rename Documentation/usb/{gadget-testing.txt => gadget-testing.rst} (56%)
 rename Documentation/usb/{gadget_configfs.txt => gadget_configfs.rst} (62%)
 rename Documentation/usb/{gadget_hid.txt => gadget_hid.rst} (74%)
 rename Documentation/usb/{gadget_multi.txt => gadget_multi.rst} (90%)
 rename Documentation/usb/{gadget_printer.txt => gadget_printer.rst} (82%)
 rename Documentation/usb/{gadget_serial.txt => gadget_serial.rst} (86%)
 create mode 100644 Documentation/usb/index.rst
 rename Documentation/usb/{iuu_phoenix.txt => iuu_phoenix.rst} (82%)
 rename Documentation/usb/{mass-storage.txt => mass-storage.rst} (96%)
 rename Documentation/usb/{misc_usbsevseg.txt => misc_usbsevseg.rst} (95%)
 rename Documentation/usb/{mtouchusb.txt => mtouchusb.rst} (83%)
 rename Documentation/usb/{ohci.txt => ohci.rst} (98%)
 rename Documentation/usb/{rio.txt => rio.rst} (86%)
 create mode 100644 Documentation/usb/text_files.rst
 create mode 100644 Documentation/usb/usb-help.rst
 delete mode 100644 Documentation/usb/usb-help.txt
 rename Documentation/usb/{usb-serial.txt => usb-serial.rst} (85%)
 create mode 100644 Documentation/usb/usbip_protocol.rst
 delete mode 100644 Documentation/usb/usbip_protocol.txt
 rename Documentation/usb/{usbmon.txt => usbmon.rst} (89%)
 rename Documentation/usb/{WUSB-Design-overview.txt => wusb-design-overview.rst} (93%)
 rename Documentation/watchdog/{convert_drivers_to_kernel_api.txt => convert_drivers_to_kernel_api.rst} (75%)
 rename Documentation/watchdog/{hpwdt.txt => hpwdt.rst} (76%)
 create mode 100644 Documentation/watchdog/index.rst
 rename Documentation/watchdog/{mlx-wdt.txt => mlx-wdt.rst} (78%)
 rename Documentation/watchdog/{pcwd-watchdog.txt => pcwd-watchdog.rst} (89%)
 rename Documentation/watchdog/{watchdog-api.txt => watchdog-api.rst} (80%)
 rename Documentation/watchdog/{watchdog-kernel-api.txt => watchdog-kernel-api.rst} (90%)
 create mode 100644 Documentation/watchdog/watchdog-parameters.rst
 delete mode 100644 Documentation/watchdog/watchdog-parameters.txt
 rename Documentation/watchdog/{watchdog-pm.txt => watchdog-pm.rst} (92%)
 rename Documentation/watchdog/{wdt.txt => wdt.rst} (68%)
 rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (95%)
 rename Documentation/x86/{boot.txt => boot.rst} (74%)
 rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (68%)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (96%)
 rename Documentation/x86/{exception-tables.txt => exception-tables.rst} (66%)
 rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (94%)
 create mode 100644 Documentation/x86/index.rst
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (91%)
 rename Documentation/x86/{microcode.txt => microcode.rst} (84%)
 create mode 100644 Documentation/x86/mtrr.rst
 delete mode 100644 Documentation/x86/mtrr.txt
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (99%)
 create mode 100644 Documentation/x86/pat.rst
 delete mode 100644 Documentation/x86/pat.txt
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
 rename Documentation/x86/{pti.txt => pti.rst} (99%)
 rename Documentation/x86/{resctrl_ui.txt => resctrl_ui.rst} (75%)
 rename Documentation/x86/{tlb.txt => tlb.rst} (93%)
 rename Documentation/x86/{topology.txt => topology.rst} (94%)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (57%)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (92%)
 rename Documentation/x86/x86_64/{boot-options.txt => boot-options.rst} (77%)
 create mode 100644 Documentation/x86/x86_64/mm.rst
 delete mode 100644 Documentation/x86/x86_64/mm.txt
 rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (78%)
 create mode 100644 Documentation/x86/zero-page.rst
 delete mode 100644 Documentation/x86/zero-page.txt
 rename Documentation/xilinx/{eemi.txt => eemi.rst} (92%)
 create mode 100644 Documentation/xilinx/index.rst



