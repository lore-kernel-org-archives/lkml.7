Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645BECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kSR6/xH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfJORQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:16:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:56371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJORQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571159776;
        bh=pWV8t98N4Fo6WzlbK05g/TVgMxifM1N6xBHlNciUcE8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kSR6/xH+HDHvrO3CO4SQ/kQOCfer1nNoIp8hFH1MfZaC2GVbaIZfFXT6mXxMFMAa7
         jTfmm3fq4Qa4GRx/fqXkan0YnhZ/Exm0SSBpYfajTU09gG56+qXhrT2oBgkiJCcQlN
         lTvgdkYLRebTrVqKPmhNFzPBK+gIg5V4hkMFMrm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7sHo-1iPM7G0QNO-004zt6; Tue, 15 Oct 2019 19:16:16 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-next-2019-10-15
Date:   Tue, 15 Oct 2019 19:15:23 +0200
Message-Id: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:dfZx3uAk0vysgtmYoY6k3UPO7+uWCLJU/YbcuOWHM3bUaop1Kfc
 FdW5t1UZI4gqdAQSn7/POzYMdoPfZ+Ox6/2uHh3do52Bcx0lLROu9rlI+a5II62DuzvRmUG
 6cYs7xrKRSWAHRACx8eCiYvDfSP8DvtsTWlc9mFBmHjUfK+G9pJpycZeRt3vu4f7YskTHe/
 +ykUGtHcFwPt8sXHOpFAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyIlnAb9bcA=:RB4gxlwT01gSsq4Bmz8/05
 DlmkjBB/Z9cOI2zys9IFQNgv2YbZBUovkOoFl0EjDkHUdGYKtePogDa/2CtfAmsH/0Z1l8OUW
 zQlevcJQkviYadwRxcMy7FlU5lYOEQqTZVQVmMbchWicu4876i9Etwx3BK3K9tH/erziGQZBs
 6gHGDSi9Ca2a7iJxYvGP/MhwEOiBWwIYhGKxBQk4tWZrvvb8VpbExhS/RarSQVcopi7fwi0i8
 ALu8nowNm2PyU4j7ufap5qO7/e9A4REJrG6yQx30s4kgcEtu1vFjk/gK4qRZahrVTUzuJqBkT
 2S95HEjUAriCT7Ki6jQF7CAK9VWxBF651li20hXsLhABZkfhXp9L2Kpqc9zVJYKvDPKSicArO
 8UaHyakTvVDx8z/Dy9fCkea+by/AT0pFzh/z1s6XjFAsY8zI1NMID9vF8Am/A20NB9US7V/z5
 EbQ3C7vVf13MIlOXE2SSSfXzk31IoeIW8UkcXeOiuHW3PruEDoLFIKt7KyLWvWE3AAOegmRNc
 LCK99P1CSe/nSR+7h32VpL0L8Nw40fDHhWItwObcLRbWMavig7HT6aWOXBR6/q08I1dwE8i3R
 uCMKgEzbp/fn8ZvBF963HCkAGrQbtL3vh1X3RSaBepkVK4dfdNUrAG+W/Wrcoop2ax0xiH7hQ
 WyKItgPxxGOBJIMJu8hqcrUMuODhZiOAcUWWSGiQNooDsj/2X/cpww+bz/PH39942Z8Y9JJgH
 B0mSsZRJ7qOIEZcAxKdVdf2zEwft3O3ND9gHorwQur1YzC9mrxxAB3P5jYnPEor8OZiGmKf3O
 8pYjURdHxcjfDPcXCTlln0M6wC8UUa6ZtqYQNUxJwO9YVNot28f5cvkDfvTjMOGITgmccdpxF
 JjWejq09Nff/UBUeVVHq/e92KMdic6czcHAFZP06qs1JcG4cHivCqFaxRDxjAoQiBeMGrf1uI
 eybHJsBBdIF66DbXzSIKFer9cLsikiA3Rgq6j3ENoICZFfuORQplJsNTNYGVaBKffmPDi0hTD
 TjTD5xcqcu/Gq5XZGZvBYUEzIJbq6AIgwvs+P4do5JI9b4Ikh45bS4XZ7CAOxBMJ01fWU/fhB
 Uy1oC7ulH7zulaT47AUY0GdEKJj2N8WYprxyQJ5e8zpaIC5oOH4fPYpL275yjx7vesC0wzJQV
 9Rzj/lHDsNdOlVkQqtkDUJEgqrL0HmNZRrWzzmW7Mfz/Gd/+fNjCfn65lEq+UN4qobAk+As+H
 fko+Wqbh+gnpIHer4TU5Gi5+sJ+fbeurRDsw7QA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-10-15

for you to fetch changes up to 46fdee06aeefedfc62a4c33b2c4a7a74682ac755:

  arm64: dts: broadcom: Add reference to RPi 4 B (2019-10-10 19:14:28 +0200)

----------------------------------------------------------------
This pull request introduce initial Raspberry Pi 4 support. But all the fancy
stuff like GENET, PCIe, xHCI, 40 bit DMA and V3D is missing.

----------------------------------------------------------------
Stefan Wahren (7):
      ARM: dts: bcm283x: Remove simple-bus from fixed clocks
      ARM: dts: bcm283x: Remove brcm,bcm2835-pl011 compatible
      ARM: dts: bcm283x: Move BCM2835/6/7 specific to bcm2835-common.dtsi
      dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
      dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
      ARM: dts: Add minimal Raspberry Pi 4 support
      arm64: dts: broadcom: Add reference to RPi 4 B

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |  54 ++
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  67 --
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              | 123 +++
 arch/arm/boot/dts/bcm2711.dtsi                     | 844 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-common.dtsi              | 194 +++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 -
 arch/arm/boot/dts/bcm2835.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2837.dtsi                     |   1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi  |   7 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 190 +----
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts   |   2 +
 14 files changed, 1236 insertions(+), 256 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-peripheral.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts
