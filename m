Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F447C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243252173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="l8xEm0TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfEUWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:54:54 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15446 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEUWyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:54:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 2CCB1685;
        Wed, 22 May 2019 00:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1558479290; x=1560293691; bh=eDua++K8f0L15ZVi48rQhAPHTYu/F5qk7je
        TfnHKG64=; b=l8xEm0THaSrwVy1ZcsByqHzaLITtODFUtFKHMH9qY/uee1cH5XH
        PLTuoigyfb9M7yOiLppcTq92Tptl13kqzZ5aULlMaYc1tL8T1PZ2aJPB19LKSKgr
        WDKsfSjE2yM8bYrhe1UtCJS8L6MpNKIdbjfbH7HF0L7nleUW1gNq5TYZW4hbeeHV
        331K+PBvIfENJsmlDClFxuuVASSczRzj1Thl9N3Uz3MGkfyot1GnLnuEZc+F9fg5
        LnVpeUOwBV/Rd7U7DQmWjZ82XzRD+PRiIjt62lA/vATintIcGcWDUqFReG1TvglP
        bptR3asWUM/dq0U3s88/OkAwLwPxKqI5LEOBAfYBMEpbW2Q7fMdzQIcI8WHERXmi
        uNtWEp3INyVYHHGG3bz6ztbQJQ/O5Go5o31A/RHAA5gZhvm8RTZPh0wYUScLqoNS
        vCtI/qXsv4o7srTHwaHI9ujRhI3T1CdjR3q3ijjlpNSRVj9zzrDsaddyiVIrCVTb
        Ku4n6dwdeidsHykiuoZwB0q0D4G+wjaOvDLyCY9HC8cbPW6F0Dh6+7fFfVmOmN9I
        cbCkMoXrRo9sdoLYr+gW6jlxbcXMENtEWpzUVQNc8R5fXIPw19N08FzSIOSPqwSz
        mjQa021u/FM4WQNOhHkJBaeSpR0FxJ5quEqSie5XWoZJte0iShYgFSDU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e-CYntZAARNP; Wed, 22 May 2019 00:54:50 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 7361217C;
        Wed, 22 May 2019 00:54:50 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 1F9252A62;
        Wed, 22 May 2019 00:54:50 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/10] Fix broken documentation references at v5.2-rc1
Date:   Wed, 22 May 2019 00:54:48 +0200
Message-ID: <51951662.QppCrsbGrr@harkonnen>
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 20, 2019 4:47:29 PM CEST Mauro Carvalho Chehab wrote:
> There are several broken Documentation/* references within the Kernel
> tree. There are some reasons for several of them:
> 
> 1. The acpi and x86 documentation files were renamed, but the
>    references weren't updated;
> 2. The DT files have been converted to JSON format, causing them
>    to be renamed;
> 3. Translated files point to future translation work still pending merge
>    or require some action from someone that it is fluent at the
>    translated language;

Hi Mauro

I am not sure to get what you mean in terms of actions but I think you are 
referring to the "empty" files I added in the Italian translations. I added 
those files to avoid broken links; the alternative would have been to not 
write those links or to point directly to the main document, but in both 
cases it easy to forget to update them later.
I chose to have links to "empty" files so that the document does 
not need to be updated later.

If you are not referring to those files than I am not understanding, can you 
point to a clear example?

> 4. Some files (specially at DT) weren't accepted yet, but there are already
>    references for them (at MAINTAINERS and on other DT files);
> 5. Some files got removed without addressing Documentation, with
>    needs them to describe some things.
> 
> This series addresses problems 1 and 2, plus other random trivial
> breakages. Problems 3 to 5 depend on either accepting a patch or
> some specific knowledge. So, won't be addressed by this series.
> 
> The first 4 patches improve the documentation script to address some
> corner cases I detected while doing this series. The remaining ones are
> documentation fixes, being the last one having just trivial renaming
> stuff all over the Kernel tree.
> 
> After this series, only those warnings will be reported on v5.2-rc1:
> 
> Removed file without a non-trivial documentation adjustment:
> 
>     Documentation/cgroup-v1/blkio-controller.txt:
> Documentation/block/cfq-iosched.txt
> Documentation/cgroup-v1/blkio-controller.txt:
> Documentation/block/cfq-iosched.txt
> 
> The documentation file uses cfq as an example, but it got removed
> recently. Some parts of doc should be re-written to use another
> scheduler as an example.
> 
> Files pending addition (as far as I identified, there were e-mails asking
> their inclusions, but it didn't happen upstream yet):
> 
>     Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt:
> Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> Documentation/driver-api/generic-counter.rst:
> Documentation/ABI/testing/sys-bus-counter-generic-sysfs
> Documentation/driver-api/generic-counter.rst:
> Documentation/ABI/testing/sys-bus-counter MAINTAINERS:
> Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
> 
> Translation files with broken stuff:
> 
>     Documentation/translations/it_IT/process/adding-syscalls.rst:
> Documentation/translations/it_IT/filesystems/sysfs.txt
> Documentation/translations/it_IT/process/coding-style.rst:
> Documentation/translations/it_IT/kbuild/kconfig-language.txt
> Documentation/translations/it_IT/process/magic-number.rst:
> Documentation/process/magic-numbers.rst
> Documentation/translations/zh_CN/basic_profiling.txt:
> Documentation/basic_profiling
> Documentation/translations/zh_CN/basic_profiling.txt:
> Documentation/basic_profiling
> Documentation/translations/zh_CN/process/howto.rst: Documentation/DocBook/
> 
> Mauro Carvalho Chehab (10):
>   scripts/documentation-file-ref-check: better handle translations
>   scripts/documentation-file-ref-check: exclude false-positives
>   scripts/documentation-file-ref-check: improve tools ref handling
>   scripts/documentation-file-ref-check: teach about .txt -> .yaml
>     renames
>   ABI: sysfs-devices-system-cpu: point to the right docs
>   isdn: mISDN: remove a bogus reference to a non-existing doc
>   mfd: madera: point to the right pinctrl binding file
>   dt: fix refs that were renamed to json with the same file name
>   dt: fix broken references to nand.txt
>   docs: fix broken documentation links
> 
>  .../ABI/testing/sysfs-devices-system-cpu      |  3 +-
>  Documentation/acpi/dsd/leds.txt               |  2 +-
>  .../admin-guide/kernel-parameters.rst         |  6 +--
>  .../admin-guide/kernel-parameters.txt         | 16 +++----
>  Documentation/admin-guide/ras.rst             |  2 +-
>  .../devicetree/bindings/arm/omap/crossbar.txt |  2 +-
>  .../bindings/clock/samsung,s5pv210-clock.txt  |  2 +-
>  .../marvell,odmi-controller.txt               |  2 +-
>  .../bindings/leds/irled/spi-ir-led.txt        |  2 +-
>  .../bindings/mtd/amlogic,meson-nand.txt       |  2 +-
>  .../devicetree/bindings/mtd/gpmc-nand.txt     |  2 +-
>  .../devicetree/bindings/mtd/marvell-nand.txt  |  2 +-
>  .../devicetree/bindings/mtd/tango-nand.txt    |  2 +-
>  .../devicetree/bindings/net/fsl-enetc.txt     |  7 ++-
>  .../bindings/pci/amlogic,meson-pcie.txt       |  2 +-
>  .../regulator/qcom,rpmh-regulator.txt         |  2 +-
>  .../devicetree/booting-without-of.txt         |  2 +-
>  Documentation/driver-api/gpio/board.rst       |  2 +-
>  Documentation/driver-api/gpio/consumer.rst    |  2 +-
>  .../firmware-guide/acpi/enumeration.rst       |  2 +-
>  .../firmware-guide/acpi/method-tracing.rst    |  2 +-
>  Documentation/i2c/instantiating-devices       |  2 +-
>  Documentation/sysctl/kernel.txt               |  4 +-
>  .../translations/it_IT/process/4.Coding.rst   |  2 +-
>  .../translations/it_IT/process/howto.rst      |  2 +-
>  .../it_IT/process/stable-kernel-rules.rst     |  4 +-
>  .../translations/zh_CN/process/4.Coding.rst   |  2 +-
>  Documentation/x86/x86_64/5level-paging.rst    |  2 +-
>  Documentation/x86/x86_64/boot-options.rst     |  4 +-
>  .../x86/x86_64/fake-numa-for-cpusets.rst      |  2 +-
>  MAINTAINERS                                   | 10 ++---
>  arch/arm/Kconfig                              |  2 +-
>  arch/arm64/kernel/kexec_image.c               |  2 +-
>  arch/powerpc/Kconfig                          |  2 +-
>  arch/x86/Kconfig                              | 16 +++----
>  arch/x86/Kconfig.debug                        |  2 +-
>  arch/x86/boot/header.S                        |  2 +-
>  arch/x86/entry/entry_64.S                     |  2 +-
>  arch/x86/include/asm/bootparam_utils.h        |  2 +-
>  arch/x86/include/asm/page_64_types.h          |  2 +-
>  arch/x86/include/asm/pgtable_64_types.h       |  2 +-
>  arch/x86/kernel/cpu/microcode/amd.c           |  2 +-
>  arch/x86/kernel/kexec-bzimage64.c             |  2 +-
>  arch/x86/kernel/pci-dma.c                     |  2 +-
>  arch/x86/mm/tlb.c                             |  2 +-
>  arch/x86/platform/pvh/enlighten.c             |  2 +-
>  drivers/acpi/Kconfig                          | 10 ++---
>  drivers/isdn/mISDN/dsp_core.c                 |  2 -
>  drivers/net/ethernet/faraday/ftgmac100.c      |  2 +-
>  .../fieldbus/Documentation/fieldbus_dev.txt   |  4 +-
>  drivers/vhost/vhost.c                         |  2 +-
>  include/acpi/acpi_drivers.h                   |  2 +-
>  include/linux/fs_context.h                    |  2 +-
>  include/linux/lsm_hooks.h                     |  2 +-
>  include/linux/mfd/madera/pdata.h              |  3 +-
>  mm/Kconfig                                    |  2 +-
>  scripts/documentation-file-ref-check          | 44 +++++++++++++++----
>  security/Kconfig                              |  2 +-
>  tools/include/linux/err.h                     |  2 +-
>  .../Documentation/stack-validation.txt        |  4 +-
>  tools/testing/selftests/x86/protection_keys.c |  2 +-
>  61 files changed, 127 insertions(+), 102 deletions(-)



