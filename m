Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1361C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB12086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="mtJWe9Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfJCVu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:50:57 -0400
Received: from mout.web.de ([217.72.192.78]:41403 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfJCVu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570139445;
        bh=+slu9oigrifofLBmSnoGBXNUCdUs8UMw+gAQMYZR/OU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=mtJWe9BfGLpk166deIOWv6NwNSVtqNu4zEFmltWTZO+Quufhq50MugB4t3PI53Dij
         P75Ixq7hozzbk0+FHdq9w1smAfhLlT6WCPVlEGLVmzgVIbWf+qdMbLNHxgkPW11OH5
         mvpxatuhvRgzbIbSTYrf6MF+3Mcs9GpROLzrOyrI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from platinum.fritz.box ([89.14.73.200]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdVza-1hpIko3M5i-00ikbu; Thu, 03
 Oct 2019 23:50:44 +0200
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: fix RockPro64 vdd-log regulator settings
Date:   Thu,  3 Oct 2019 23:50:34 +0200
Message-Id: <20191003215036.15023-1-smoch@web.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:sVWSznPIdgTeGmxS0/KuK5sR3zlLN0yEjQwtifgjotr6sUlPGeX
 SCaKNvjkY2xrsa2JwfaH4KWsSiYOkozaZoxo4JmqSc/EwguMpI45EebjNI3cQkwrCfPim6b
 02b5Xj+b3kuMwjLS4tqXGFCniDNAIH3qhHOEWovdeCy4yOGDuzQye7qcb011wpp5K3Y+zv3
 u+KYJmttKbwcJdT8JijcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vCe5hpyJPR8=:disR8f0omoqst11p1fIKAh
 iBAK1nFXc7AmOcAiFW44MeJNXdocthJHRd3VEcy9/B9yqK/hTjhNCgBGLXvhk3UzVzVTDK802
 kBf9cEBdt34sF6mLB40sUD5CXT7PaMoPa78w45lA9C3+dF/9UxU09+6fr6SVTgU3mu6Hn2JqJ
 nvfqFZiqINBWoePt9nqRkkTUrqgEyMT6qHHfJUTadp6PJeCXCeirRPUqFqdJ8vx+tsSMrD+G5
 fmZlzpPnl8Ky3j1gtFkLLcEAOMtAgzPfeEONvZiwK5J6n5MxwprBNRT7E07hW+xDfcQbQE0rD
 8RGbx1mkzr2V92lpYcIRTNqde+Oh+/V4C4s6rQGxN+x/xws7iNpUeU9Rpv65WHyiheHZUcHs6
 4n7JmhPiZXUCFzWUrmM6oJB7O70rL8WobnNCWQmNtYRuiqGautEew+TItXYvKBCtvFrALXdM+
 vb1+FrU03VriEuoHeRWwPEsO45SGVwhYIsolu6CRDFU9G4a0WdORqWZVYVP+0JvpMOe/lA2zY
 2rl2QFH53x1+BtBVK20hHOh7W3xtLH+WzZFsAzmnNe3+61mRhxIzHfDY3otUHd7hUG+pyyhXw
 6RI9YNTvxF2AQ1rzSvvCNNtPkovfmdPvPTfO2Sqig4TRyAE9/Un4zf1wnoho8+Hqw2w2gvh2g
 lFdajNupo7PiibkssZMeWpi2Yyw+Ql484vPZldLOBFiuDXWRwYHJA7n3CWPRqu4FkvqZI0woF
 iWwuOPIyYV09g8L2UPq4YiXXvNXKdJWpQh/x59dBhs26HHmbaZxBvFHrUY7FWo9HRjA0t8hvE
 oDTTozWqTW6xzbFzIwp0E29Vp6mciCpjiqoLv7MMTbg0U9pPnAQecIk11U33l0ZqVQyKSxq8G
 Fdwl4gLqiQcP6Y/Zm2wBLvnsSffYrkTmqpiQ6RjPOPPy9GxZHTglNZP6Cr4a5N3lHKv4+rvUV
 pKvy7jWH6ub53Ne6v/8q//sL+wQIbqfuTNNpvc+MI28YX7YthEldq1GRyRKJ5k4z6o2nrqUik
 oRx5AuvdO3oPcAIsUwKaeuXqRrTtC9M6kdubTFXOZ8EZzZtj1unz7h3zRztMQu37AvKSyHhxt
 k56zCWlbMOjoKO97tb/lVKVF80M81PnaiIOXQ9I9E3UIF2s95Wg/VbtVzkWi4oF6WwrqqO44y
 sthchBfNPGC/jUAm3c9UeqBDY4lM5Ilus4dUpjvn4gcHDKMGS6iu/KEEMEuL56mRaMcwg/xXM
 L5sIsGmzM7HYTjE4fJFm35NicLPlNwOqZLoaMsg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RockPro64 schematic [1] page 18 states a min voltage of 0.8V and a
max voltage of 1.4V for the VDD_LOG pwm regulator. However, there is an
additional note that the pwm parameter needs to be modified.
=46rom the schematics a voltage range of 0.8V to 1.7V can be calculated.
Additional voltage measurements on the board show that this fix indeed
leads to the correct voltage, while without this fix the voltage was set
too high.

[1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Ro=
ckpro64")
Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 0401d4ec1f45..845eb070b5b0 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -173,7 +173,7 @@
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt =3D <800000>;
-		regulator-max-microvolt =3D <1400000>;
+		regulator-max-microvolt =3D <1700000>;
 		vin-supply =3D <&vcc5v0_sys>;
 	};
 };
=2D-
2.17.1

