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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3182C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03F62086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gHAbj603"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfJCVu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:50:58 -0400
Received: from mout.web.de ([212.227.17.12]:34103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfJCVu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570139446;
        bh=eS9hhbwrWcOcLqNrSHnNyzdXGy2wwga1+qIn6yQk704=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gHAbj603m8oUb8oRnbfhCrTHXoe2Jv0281aZhojdxxghdQlBOMK83mjA2Z3jZTd+3
         ufCFrDsLVjZfNUX3Tw/dzvohoMsO6rSiuSQahkiuuzwdIEw55dI+RuczpwTlsfimd8
         /ELDlgZ5x9qlJ4D+KairWvoTfeYMDzYO/laMxJnM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from platinum.fritz.box ([89.14.73.200]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzbDC-1i2Rux318M-014njy; Thu, 03
 Oct 2019 23:50:45 +0200
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: fix RockPro64 sdmmc settings
Date:   Thu,  3 Oct 2019 23:50:36 +0200
Message-Id: <20191003215036.15023-3-smoch@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003215036.15023-1-smoch@web.de>
References: <20191003215036.15023-1-smoch@web.de>
X-Provags-ID: V03:K1:4LIFexwsUixYQS8MiIrk0eN/ESr5uuMkap/XL+MJZBi2SGrACZS
 QOM5njeqvs0G3ohuRk6VlGPJFSZIU/rdaDsNurPb0G16TH+UMWrPtNjpxlbG8CHVc9hy0GU
 tRgF9Dg/Kv/nNgBtmUQlPTftW8kC+xrZPw/XSCOD1v/3YjNrcgJqWYh5CpQZC391CbHqCFF
 CVkOkQTwoCDWzm9cuS+LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixJgCZhwsKg=:uuFw5p1r2pI8Z5nR+G7cM4
 9YVDpOJIgSiiRzinbD76K6fFDuJ7zYgKRiMsUhexYox0+VrDalGw483+3XUMm947dZDMImyV8
 9oqpoxzuQq5PVQw+s21pJYBHLlZXWF3yt1Q1OC21EKW10AyqmWNXcYD13AaedBVvNdOO+EhmX
 YBfMX7wa+Pgd7KHJUO4hwhMSQN2UuVKlIKrtG7rSJgNZcgnu7ZR7bad/rJdpeEUY9bBZW3E31
 eJmEGM4eX+n4MxH/3josdf5EcLcJhN7AobZ169OMGsobFTTY45MRn6xUzPsBY7VyrvHHVbrIV
 FlNpAM6a56P1SU2VMNi0erDEJC4PHoZfGk10e7Y2/ojvnIWeGzrC0H/BDAXIEnaNlqc7avzYb
 NdzZX+H233C2gjRTL0aVy/P5GmmtcuapTfZy8AgXDV1mtpRP1iqslfgiK+vxyu5/zdhR724So
 u1Mnj0D5U2Jk5WTgLGxnfjTk/Ac/A+KmidbJmuYPvoo472LdCwwLyINTE7Iff/ZFFTzGC/LTY
 ulmS0r/CAdEDX4XzOxEoZdVXk1qurucJXUImVKlhk+O8uKIkq24bWY96NkuzYSCDVuBmak6Ef
 jTt43MdN3nNu9SXH54J9E7gyq2W1K5gFSVEdvx/C4wsFJUTnM/GK8V8VbpyYYAjNGM4LvkUUv
 tJG3tQ3q7FRtS5iB59tsWrv3pHPd5fTOqan9wLVUrUDxq2BudqKltab8ke/sIznE5NrbQshM9
 Sen8Oep9oStSgYhZtrAGefEhakiHwK+Xnv9wzxBlltK93RH58hp0YfgsHIe0W1iHYNuCE7hFK
 U8R+2ia0RqZuBIHv3Qkd5e8xF7qUpdgmkfrvkwpGr66gognAlkDh0xMDaGLoTKa2YfTvHRaoe
 5LnXs7JteNIbiOfxa98qlQBC6cgmLDKO0aan/TV0CpC6RK/wxUa8VMluXB73nIeggQUUP2daf
 0JiFv6UBHiKRpI17ZVr1uFK43/Pxummh9yjcNiCUskthNyHaqpWQHHhXe8BVDca62ft4nmi0f
 cQqD7a8lFLTenIMAhWEirD1VKX01JQ8X+9WZhUEJ3aeKgykHdKAz3ijNf1OFIxf9tsOtOA2Zu
 aZuUaStxyOwlmQFJaQP2CdBVLvRcc0rSEzMTIHcreyTjO82bSDUk+qd/0a2HOdMACzP7ltxOS
 Ai4TPrf05zrs5O0091J7PZGGSYueDBcVDNijNwTUpREowPnET9g0ihx8zaDR4FKtjuTmBouX5
 PWL2CLXUJ4l85ohxkxZ6xs6WDc3KfAAM3Q294vw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
connected to a microSD (TF card) slot, which cannot be switched to 1.8V.
So also configure the vcc_sdio regulator, which drives the i/o voltage
of the sdmmc controller, accordingly.

While at it, also remove the cap-mmc-highspeed property of the sdmmc
controller, since no mmc card can be connected here.

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
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 2e44dae4865a..084f1d994a50 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -353,7 +353,7 @@
 				regulator-name =3D "vcc_sdio";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt =3D <1800000>;
+				regulator-min-microvolt =3D <3000000>;
 				regulator-max-microvolt =3D <3000000>;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -624,7 +624,6 @@

 &sdmmc {
 	bus-width =3D <4>;
-	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	cd-gpios =3D <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
=2D-
2.17.1

