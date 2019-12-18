Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02950C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85C42176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VlUfPehA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLRWf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:35:56 -0500
Received: from mout.web.de ([212.227.17.12]:56707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfLRWfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576708538;
        bh=lAAhQWrqTZ+3NKkBxKoTqGxYRguwM1a4ntZ/kHINjrI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VlUfPehAqq8T8OZtJhiT4IfKDhZs/FRv88U4/8Ak1XXguF7FO55R1wdAyA9C0sM3a
         qVH+1Krj7CYIRNz1Ovqq7RZW7xX7FRsqXsFlpyYHDmsrm1EE94/WDdXDp0llPGomRW
         P4SowPHzAYyDfdBcBSi+QTpOjoTaAP5oethXARTg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([89.204.137.218]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MXHXF-1iEL5L0ITd-00WDAM; Wed, 18 Dec 2019 23:35:38 +0100
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: dts: rockchip: RockPro64: enable wifi/bt
Date:   Wed, 18 Dec 2019 23:35:21 +0100
Message-Id: <20191218223523.30154-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PHp7e4svlTVsNYUIoz5ytrInhryaO+C+w+4Ft0e59pR0Jme4QXr
 3yIy3GV1HnbboENPQnvjdkXooUWdaGzGjexy5+6K+6HcVN6zNTowZz86HfxgrPMsJjoXKqz
 /ImAgfNVCaVILB9S9abOX8UOUrAVYTm9FwwTnuObKuN6K9ILaw5M0VRXa1g0Zp24Xyrl4Dg
 KrbSf0VdhqY0P61GutUhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NVLy28qVaF8=:P4MJd+g3YR1SVho5Tak2vc
 y6flSHZpnmzbvhLi1FYsOxb5GXrPGQuvPXbxGEJtZdMln5c70msn/iKqFPwqW2oRBWoB08Gg9
 lRVw+qABI/ZwYJybhcNU4FVZBi64oi/xATFzcPb/YRI8dhif8N0PKRgDaBgpeHz9gznK9XGrR
 sJvkavqqZZX4H7P0CXCjQgAP6qrgvD5kF/QgQrkaCL7LV31nUPEHSzNPw6fb0eMb81GVL5Edh
 Gz5duMyxY27+I0Pyi1xVMe+wEmFx4KHGM344LnOdLv7UWPa0/Tk5FdUQCoVpB9c7NMpVAvimY
 bMxxgnrRVyJBKjm4q0S4InSCKheAB9SOuwdfhGl0PRQ6joBU+oEGl0TIl3B2HnTQF+JVbWbje
 T8cCE4cKGA++c2Tt6+G8OYVTauTciOY42KdmqpmUOimUQ7r5fl3m+vS2NdplDd0iOJbknlKwS
 PIJUp66rgXO87v8Ykn7kFU26NU6ICSBkDykKoL+YBnpm8l42tpyhVj4RDCTIsLLL1X5DyKAG3
 gr0y1jE05SqGaRg+bmslLGn2GZ+aUX8wnmmDXleWBih0bZBiN1iZ/OQ9DueWm8FSFG4DjI45Z
 NNwbIiywAOnaqTW2QTOVnyVEC63US/LXOrdWktTccFLG0M7pocjYWfhlJn5z4YvETsJp3WSyI
 crwvuZh83KkxxGvllps8Gc+QQfCgLMpFZaSmMHffb4C8GLCWUE4VzvUyWz0jZ48VPiokSXl5/
 wpBFslguFInnm3FwyPscoXn6e/twVbdOpq7qBABYa2talB1thl4tRdOXeqHfRYZRZwTJhBK8s
 y9rDcGE0EbeIPNuTvIFJf78yPs3id+07qGXRjEO/rUYHHxRaUdYESg0GC6J6apt6ebceoyp/B
 KhzfDREN2otRpzZXwbkfdap4B1ASRd8gNvWxwY8FQBID7V81fuRtuKtb36nkONzLEoMpWXxHI
 mMlUiqynVE1PA/v+7wn8DFUQ+IMT6GB85CDC6+q28Iqm+2NZUwZe0jAqht08FhDzE9/tYzPsb
 wZzUH9UVHpN54Yux212XDjL71tYIp/vIRg5T21lzJFgIQV2JWr7o6aHZvKr2cdXwffcJhJG4U
 kxtxNLO3easZRCo4HD0yXkD9FUTCKizAakSLHm5CUtD8J1ZqSANHUL0X1B0PkyXJkbHK9s4SX
 ++FsCGkRLqS/NlzanPzfi0b3gDSQzSkR3BW3M+IqjExsRXRo7V/M3gQgyg2s4nntALHlHod+4
 DkoFRNEilrwbc21FFOhAcmDjPk8ufmWiP/FmU9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance devicetree of the RockPro64 arm64/rockchip board to use an
AP6359SA based wifi/bt combo module.

Patches 1-7 of version 2 of this patch series (to add support for the
BCM4359 chipset with SDIO interface to the brcmfmac wireless network
driver) are already picked up for wireless-drivers-next. So this
version 3 only contains the patches 8-9 from v2.


Soeren Moch (2):
  arm64: dts: rockchip: RockPro64: enable wifi module at sdio0
  arm64: dts: rockchip: RockPro64: hook up bluetooth at uart0

 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 50 ++++++++++++++++---
 1 file changed, 42 insertions(+), 8 deletions(-)

=2D--
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D-
2.17.1

