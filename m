Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83608C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513EA21734
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfCFPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:36:23 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35690 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:36:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so13276836qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+FeZe6PSCOtLAAuNZaCxy4v5LXwB6YxaeesmlZNuV0=;
        b=Y5dvUYPUfyArN67YbGfv0p91qt4xtt3R+x7Kkq5vKBwyUzT4W25pAWSw9EJl7UxU//
         fyh7TNrzpMzCD8Tw5p+IZhppTGkWsKngCJDPBLTgZ+oZITtI/hthA0axNVFnrslcPkHB
         jgmkr8XBAHX/aIDnVAY8w7zd/1/pLqWyJ+0u6AaUL8xzIaLwVb/+y1X4gBnb7Q6U9ypL
         ThBglznkNH7GJpQemjd9Xie/tkYrS6JrPKgpce7w3pzOKTzWjjq+FHT62n+7nH9SI9Jd
         LW0byMfYMDq9CDVUZIoutn1upicUbQngD70sn7D+KufANV7NzI7Ligc6m3NpLToLoU1M
         1ijg==
X-Gm-Message-State: APjAAAXHrYJ8IzrXzcwx7JdA4bTqjOSMSahkV8sfS9dRwuCWOrDDN+LS
        ReQ9bNM8lzXSdaaVy0FcapjLxDPxrScdnU700+I=
X-Google-Smtp-Source: APXvYqxgtj8wrj9LK2YWP2uiA0RzycbeCeEhzl1TFMJ22p5xsTSYFn+1J4W2JlZi7sJwDH7A5AgHikqbew1MjvvFvCk=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr6857391qvd.161.1551886582156;
 Wed, 06 Mar 2019 07:36:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:36:05 +0100
Message-ID: <CAK8P3a2+OspNio3=mLoYPjOg_rbYeomYa8TrRaLwU=ZF1ec20w@mail.gmail.com>
Subject: [GIT PULL 5/6] ARM: New SoC family support for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-newsoc

for you to fetch changes up to c889e2a0b053703be7e7591c9a574975440e5502:

  Merge branch 'milbeaut/newsoc' into arm/newsoc (2019-03-01 15:21:04 +0100)

----------------------------------------------------------------
ARM: New SoC family support

Two new SoC families are added this time.

Sugaya Taichi submitted support for the Milbeaut SoC family from
Socionext and explains:

 "SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
  computer vision. It also features advanced functionalities such as 360-degree,
  real-time spherical stitching with multi cameras, image stabilization for
  without mechanical gimbals, and rolling shutter correction. More detail is
  below:
  https://www.socionext.com/en/products/assp/milbeaut/SC2000.html"

Interestingly, this one has a history dating back to older chips
made by Socionext and previously Matsushita/Panasonic based on their
own mn10300 CPU architecture that was removed from the kernel last year.

Manivannan Sadhasivam adds support for another SoC family, this is the
Bitmain BM1880 chip used in the Sophon Edge TPU developer board.
The chip is intended for Deep Learning applications, and comes
with dual-core Arm Cortex-A53 to run Linux as well as a RISC-V
microcontroller core to control the tensor unit.
For the moment, the TPU is not accessible in mainline Linux, so
we treat it as a generic Arm SoC.
More information is available at https://www.sophon.ai/

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'bitmain-initial-soc-v5.1' of
git://git.kernel.org/.../mani/linux-bitmain into arm/newsoc
      Merge branch 'milbeaut/newsoc' into arm/newsoc

Manivannan Sadhasivam (5):
      dt-bindings: arm: Document Bitmain BM1880 SoC
      arm64: Add ARCH_BITMAIN platform
      arm64: dts: bitmain: Add BM1880 SoC support
      arm64: dts: bitmain: Add Sophon Egde board support
      MAINTAINERS: Add entry for Bitmain SoC platform

Sugaya Taichi (9):
      dt-bindings: sram: milbeaut: Add binding for Milbeaut smp-sram
      dt-bindings: arm: Add SMP enable-method for Milbeaut
      dt-bindings: Add documentation for Milbeaut SoCs
      ARM: milbeaut: Add basic support for Milbeaut m10v SoC
      dt-bindings: timer: Add Milbeaut M10V timer description
      clocksource/drivers/timer-milbeaut: Introduce timer for Milbeaut SoCs
      ARM: dts: milbeaut: Add device tree set for the Milbeaut M10V board
      ARM: configs: Add Milbeaut M10V defconfig
      ARM: multi_v7_defconfig: add ARCH_MILBEAUT and ARCH_MILBEAUT_M10V

 Documentation/devicetree/bindings/arm/bitmain.yaml
|  18 +++++++
 Documentation/devicetree/bindings/arm/cpus.yaml                      |   1 +
 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
|  22 ++++++++
 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
|  24 +++++++++
 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
|  17 ++++++
 MAINTAINERS                                                          |   7 +++
 arch/arm/Kconfig                                                     |   2 +
 arch/arm/Makefile                                                    |   1 +
 arch/arm/boot/dts/Makefile                                           |   1 +
 arch/arm/boot/dts/milbeaut-m10v-evb.dts
|  32 +++++++++++
 arch/arm/boot/dts/milbeaut-m10v.dtsi
|  95 ++++++++++++++++++++++++++++++++
 arch/arm/configs/milbeaut_m10v_defconfig
| 119 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig                                  |   2 +
 arch/arm/mach-milbeaut/Kconfig
|  20 +++++++
 arch/arm/mach-milbeaut/Makefile                                      |   1 +
 arch/arm/mach-milbeaut/platsmp.c
| 143 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/Kconfig.platforms                                         |   5 ++
 arch/arm64/boot/dts/Makefile                                         |   1 +
 arch/arm64/boot/dts/bitmain/Makefile                                 |   3 ++
 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
|  50 +++++++++++++++++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi
| 119 ++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/Kconfig                                          |   9 ++++
 drivers/clocksource/Makefile                                         |   1 +
 drivers/clocksource/timer-milbeaut.c
| 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 24 files changed, 854 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bitmain.yaml
 create mode 100644
Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
 create mode 100644 Documentation/devicetree/bindings/sram/milbeaut-smp-sram.txt
 create mode 100644
Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
 create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi
 create mode 100644 arch/arm/configs/milbeaut_m10v_defconfig
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c
 create mode 100644 arch/arm64/boot/dts/bitmain/Makefile
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
 create mode 100644 arch/arm64/boot/dts/bitmain/bm1880.dtsi
 create mode 100644 drivers/clocksource/timer-milbeaut.c
