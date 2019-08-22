Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C518EC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9632F21726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ACG99ANs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfHVKyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:54:15 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:52875 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731964AbfHVKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:54:14 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46DhH82Zbrz1yLF;
        Thu, 22 Aug 2019 12:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566471252; bh=+EKzIqc2mh/WhokNQXrdejfhIJXVgnQbt937LPkohsc=;
        h=Subject:To:References:From:Date:In-Reply-To:From:To:CC:Subject;
        b=ACG99ANsUZ9frOWDbWMLGF/aIfJ9VrUT0tpkmy8Nn7x2Fcj26Yh9HlyUs6hr2c6Vg
         tYOCtaMQs9gbMKLtvoXfwqEzMKX8dteM+/6xANzdvPHHNmBO25BCqp+t0vMcd7nKyg
         d0A6CGmH9aajxEbZ8BVm69C50We3xtlriKfWg0yHrJw0Ov44GJVGWaAeDCmwljPoY/
         czg/vLuJDEM5MXnznuBa/zdrT+7hGkhvsvF+6VkNYBw+Vy05M3djqx8u/yWhqzEG2e
         dc4BBYlk+xaWxJJDgVpVxLe6JWMfSJSvVrZGVoXJlw9eCC+psBCPS/WvYS/mqbNei1
         gSE9CWQvobH0g==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 87.190.42.42
Received: from [10.0.0.25] (unknown [87.190.42.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/4aPYtrEMaX/srkMa7rgnSls7X7ieXjzw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46DhH54BZDz1y69;
        Thu, 22 Aug 2019 12:54:09 +0200 (CEST)
Subject: Re: Status of Subsystems
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
 <20190820171550.GE10232@mit.edu>
 <57a7ae11-282f-8b93-355c-4bc839f76b23@metux.net>
From:   Sebastian Duda <sebastian.duda@fau.de>
Message-ID: <f0022b73-6199-cff2-fe78-0818062ef5be@fau.de>
Date:   Thu, 22 Aug 2019 12:54:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <57a7ae11-282f-8b93-355c-4bc839f76b23@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

below is a list of files explicitly mentioned twice (or more) in the 
MAINTAINERS file.

Kind regards
Sebastian

On 21.08.19 14:10, Enrico Weigelt, metux IT consult wrote:
> On 20.08.19 19:15, Theodore Y. Ts'o wrote:
> 
> Hi,
> 
>> There are some files which have no official
>> owner, and there are also some files which may be modified by more
>> than one subsystem.
> 
> hmm, wouldn't it be better to alway have explicit maintainers ?
> 
> I recall some discussion few weeks ago on some of my patches, where it
> turned out that amm acts as fallback for a lot of code that doesn't have
> a maintainer.
> 
> @Sebastian: maybe you could also create reports for quickly identifying
> those cases.
> 
>> We certainly don't talk about "inheritance" when we talk about
>> maintainers and sub-maintainers. 
> 
> What's the exact definition of the term "sub-maintainer" ?
> 
> Somebody who's maintaining some defined part of something bigger
> (eg. a driver within some subsystem, some platform within some
> arch, etc) or kinda deputee maintainer ?
> 
>> Furthermore, the relationships,
>> processes, and workflows between a particular maintainer and their
>> submaintainers can be unique to a particular maintainer.
> 
> Can we somehow find some (semi-formal) description for those
> relationships and workflows, so it's easier to learn about them
> when some is new to some particular area ?
> 
> (I'd volounteer maintaining such documentation, if the individual
> maintainers feed me the necessary information ;-)).
> 
> 
> --mtx
> 

Documentation/security/keys/trusted-encrypted.rst
drivers/power/supply/bq27xxx_battery.c
tools/power/acpi/
include/linux/lockd/
net/sunrpc/
drivers/i2c/busses/i2c-qcom-geni.c
drivers/block/virtio_blk.c
Documentation/devicetree/bindings/mfd/atmel-usart.txt
Documentation/i2c/busses/i2c-ali1563
include/linux/hippidevice.h
Documentation/PCI/pci-error-recovery.rst
include/linux/vga*
fs/nfs_common/
include/linux/pm.h
drivers/crypto/virtio/
include/linux/mlx5/
drivers/media/tuners/tda8290.*
drivers/crypto/nx/Kconfig
arch/x86/include/asm/pvclock-abi.h
drivers/scsi/53c700*
fs/lockd/
drivers/staging/iio/
drivers/i2c/busses/i2c-omap.c
Documentation/admin-guide/ras.rst
include/acpi/
drivers/staging/greybus/spi.c
drivers/base/power/
include/uapi/linux/media.h
include/uapi/linux/cciss*.h
include/linux/suspend.h
include/uapi/linux/uvcvideo.h
include/trace/events/xdp.h
drivers/staging/greybus/spilib.c
include/linux/cfag12864b.h
Documentation/devicetree/bindings/arm/renesas.yaml
include/linux/soc/renesas/
Documentation/scsi/NinjaSCSI.txt
include/linux/sunrpc/
drivers/crypto/nx/Makefile
drivers/gpu/vga/
include/linux/platform_data/i2c-omap.h
drivers/power/supply/bq27xxx_battery_i2c.c
drivers/mtd/nand/raw/ingenic/
drivers/i2c/busses/i2c-ali1563.c
drivers/soc/renesas/
include/uapi/linux/sunrpc/
drivers/md/Makefile
include/linux/power/bq27xxx_battery.h
include/linux/dmaengine.h
drivers/gpio/gpio-intel-mid.c
drivers/dma/
include/uapi/linux/ivtv*
kernel/power/
drivers/gpio/gpio-ich.c
drivers/net/ethernet/ibm/ibmvnic.*
include/linux/netdevice.h
include/linux/mlx4/
drivers/net/ethernet/ibm/ibmveth.*
drivers/media/platform/mtk-vpu/
drivers/dma/dma-jz4780.c
include/uapi/linux/meye.h
include/uapi/linux/netdevice.h
arch/arm/plat-omap/
include/linux/freezer.h
include/linux/cciss*.h
Documentation/gpu/
drivers/md/Kconfig
include/linux/cpu_cooling.h
include/linux/pwm_backlight.h
arch/mips/include/asm/mach-loongson64/
