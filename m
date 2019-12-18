Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F72176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q6e5cOL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLRWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:35:48 -0500
Received: from mout.web.de ([217.72.192.78]:47691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRWfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576708539;
        bh=dWWWJ56z1+3McYaTHm68m10tWxr+xp0Nfa2r5nT/XzM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q6e5cOL09ofwA4pprMspntmwlHo2cj3FfkHb+T+fo+Hokc0pgbhwlsaLXBuFqCQFP
         LUhDsQfBaIFzGK5VnIh/Wsy83NQ3qofTSflXxMyqdGVF+qCCaYhhFdu+YNIkDhIZYd
         OeMpota4U8gq4SgV8yG+/SR5WuWOoNu0++IohITQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([89.204.137.218]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LeLSr-1huKBy0mzt-00qDza; Wed, 18 Dec 2019 23:35:39 +0100
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: rockchip: RockPro64: enable wifi module at sdio0
Date:   Wed, 18 Dec 2019 23:35:22 +0100
Message-Id: <20191218223523.30154-2-smoch@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218223523.30154-1-smoch@web.de>
References: <20191218223523.30154-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROAhb4S5HnA8zC1UxSpS35h6K1uYG1iZNFj0qH1Upg0Ypl38cVT
 KHwIZnhcqQFTHjIGJmcOSDo6GPae4t640XYWTwIfcSeErvbBsWzKrA5Qv5gYv9XLQTqWrKE
 xk4sf/ZpyVe4B5+FhRhNGodEQ0RLFB4O/o7+kTwDkPgjAJRf2GV4c7Tt60eL8DnnnIk0UfH
 2Z4sU/Ore3JwH8bCkj75A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WjCFWLClYzs=:sfZYTqTROrpebhd/C8nXmJ
 QulDk9vDBdJGdA9icQsumC87GMwKHlCewB1YaAeB/4yGhAoVIvE91PEDjHkacHNfN+Bt8R3+K
 atOp8SKjNYkowSZcUOwc1b7LitlCwTSPRjbDbqIQp+yWzBqQ+jlaKKFxnElosmf5nXpdv2FxR
 1bUmSUdFPdtw03UFMVvGH/H3jYTMpG4zdUZdbWEvwgT+zpbAhTz8oLMPxjUHkxMpIl3bc/1L3
 q9Dk3PaKyAuEuMFTsQG+a3S4tTXE1ovS4Jr6Blb3XvjTn8LyqWA2dN2wMxMWan8JNByZoVSOe
 E9elEXDngX2dXKdyqftHY81xCwKE7vY1gG2qj7IIPScoGK6IPilciBjtaDjyY1YrxcbhgAsoO
 FuSrPuyS0znVddHgKsWPcOvIhDKVaDykCQOo6E7HYTUVzPLOFrwTj8Pld6nMaQWDz47rNE8IZ
 wgCnJjq+HJkf9BmZCSalPxaQOugPc/fITL3rM1L94vf015E1W+FkN2qFZBUislon64M1XaW3M
 acFP+tF7VON/3QJPH0OUwBYtqU/ua8iOqmBeBobDc43xotypdP9pXKe1v5mDc4xQcMNbtYZ+C
 jmsIWc1mlcBd9S2g0hdkm9VN0cV79Qlw6JRhbsMoOBEcRd8B6aPzUsMLkgSW5j6S/Hbtfqvwf
 1BV03R9cWgWsh9L8tmnep9B1Jx4wIZItyguUNzl62Z8OUUYOhwj7F7Iic3HywHcAGTpFk3zA6
 ntcMz+JJLNnm1FdOf64UPFxEiRr9pQdHsmFMlEYuNuKIXhO93s7Ow2EZiwIi5KEI92fv7gKrx
 eLQavYqLH9qjjPPm/tAUGPrdqp7qH4xc+jDTTPhhiyxwMJ3JvUZEW/dflmO1JIGZKu+DNmqrI
 0i5JbqtMYkwxlYRIgYAvcw9p63JNxiQ/IVkITm8rFBzVmgpzfef/AphctNC4+5yjWqlQ4Frrc
 JvDGeYgoK4bpUEabFOBKrGz+WqntDCxeVE2I56n5iJebZ7HOK9lohhDxfB+pbgELZZbFfXQZ/
 GG8qPZhbXUm4ToWK9poMYdSha2RjgtAIi501cPT0B7/Dz2ynI2PptER2Osw90hTJuLd9MJMvQ
 TANrT+8fuMoqRxsdvbHkOo+SDnhLpKWpyZecFVda9fbObLZZXxtYkX2fa2V+4Car8IxPNA8PY
 EAcffdHrDmVOBNdda6W+/5Gj1E6Qv9wLTTP6y9UyRMF29esf1ajk4/D5EAGrOwGl9aNbKwxTh
 sXjd8HgAYpVU2uYZMzWZZgWBFJ8lP5pX3Quo/iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RockPro64 supports an Ampak AP6359SA based wifi/bt combo module.
The BCM4359/9 wifi controller in this module is connected to sdio0,
enable this interface.

Use the in-band sdio irq instead of the out-of-band wifi_host_wake_l
signal since the latter is not working reliably on this board (probably
due to it's PCIe WAKE# connection).

Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
changes in v3:
- none
changes in v2:
- add comment about irq in commit message

Not sure where to place exactly the sdio0 node in the dts because
existing sd nodes are not sorted alphabetically.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 7f4b2eba31d4..9fa92790d6e0 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -71,13 +71,6 @@
 		clock-names =3D "ext_clock";
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&wifi_enable_h>;
-
-		/*
-		 * On the module itself this is one of these (depending
-		 * on the actual card populated):
-		 * - SDIO_RESET_L_WL_REG_ON
-		 * - PDN (power down when low)
-		 */
 		reset-gpios =3D <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};

@@ -650,6 +643,20 @@
 	status =3D "okay";
 };

+&sdio0 {
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq =3D <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status =3D "okay";
+};
+
 &sdmmc {
 	bus-width =3D <4>;
 	cap-sd-highspeed;
=2D-
2.17.1

